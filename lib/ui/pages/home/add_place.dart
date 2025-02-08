/// Halaman ini menampilkan daftar item dalam bentuk ListView.
/// Setiap item dalam daftar diwakili oleh widget ListTile yang berisi teks.
/// Daftar item diambil dari sebuah sumber data yang berupa list.
/// Pengguna dapat menggulir daftar untuk melihat semua item yang tersedia.
/// Jika daftar item kosong, akan ditampilkan pesan bahwa tidak ada data.
/// Halaman ini juga mendukung penyegaran data dengan menarik daftar ke bawah.
///
library;

import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/data/firestore/place_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/models/address_model.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_text.dart';

import 'package:intl/intl.dart';

class AddPlace extends StatefulWidget {
  final String placeid;
  final double lat;
  final double lng;
  const AddPlace({
    super.key,
    required this.placeid,
    required this.lat,
    required this.lng,
  });

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final homeC = Get.find<HomeController>();
  late TextEditingController nameController;
  late TextEditingController placeidController;
  late TextEditingController latController;
  late TextEditingController lngController;
  late TextEditingController subtitleController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController webController;

  String? countryId;
  int? provinceId;
  int? cityId;
  int? halalCode;

  @override
  void initState() {
    setState(() {
      nameController = TextEditingController(text: homeC.placeDtl?.name);
      placeidController = TextEditingController(text: widget.placeid);
      latController = TextEditingController(text: widget.lat.toString());
      lngController = TextEditingController(text: widget.lng.toString());
      subtitleController = TextEditingController();
      phoneController = TextEditingController();
      addressController =
          TextEditingController(text: homeC.placeDtl?.formattedAddress);
      webController = TextEditingController(text: homeC.placeDtl?.website);
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    placeidController.dispose();
    latController.dispose();
    lngController.dispose();
    subtitleController.dispose();
    phoneController.dispose();
    addressController.dispose();
    webController.dispose();
    super.dispose();
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, CountryModel item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
        subtitle: Text(item.iso),
      ),
    );
  }

  Widget _customPopupProvince(
      BuildContext context, ProvinceModel item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
      ),
    );
  }

  Widget _customPopupCity(
      BuildContext context, CityModel item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
      ),
    );
  }

  Future<List<CountryModel>> getData(filter) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('countries').get();

    return snapshot.docs
        .map((doc) => CountryModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProvinceModel>> getDataProvinci(filter) async {
    if (countryId == null) return [];

    // Get provinces from subcollection of the selected country
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('countries')
        .doc(countryId
            .toString()) // Convert to string since document IDs are strings
        .collection('provinces')
        .get();

    return snapshot.docs
        .map((doc) => ProvinceModel.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id, // Ensure the document ID is included
            }))
        .toList();
  }

  Future<List<CityModel>> getDataCity(filter) async {
    if (countryId == null || provinceId == null) return [];

    // Get cities from subcollection of the selected province
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('countries')
        .doc(countryId.toString())
        .collection('provinces')
        .doc(provinceId.toString())
        .collection('cities')
        .get();

    return snapshot.docs
        .map((doc) => CityModel.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id, // Ensure the document ID is included
            }))
        .toList();
  }

  Future getPhotos() async {
    List photos = homeC.placeDtl?.photos != null ? homeC.placeDtl.photos : [];

    List photosFilter = photos.map((item) => item.photoReference).toList();

    return photosFilter;
  }

  Future<void> addplace() async {
    int id = await PlacesStore().placesId().then((value) => value['id']);
    List photos = await getPhotos();

    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy kk:mm');
    String formattedDate = formatter.format(now);

    if (countryId == null) {
      DialogHelper.showSnackBar(
        'Pilih Negara Terlebih Dahulu',
        title: 'Select Country',
        backgroundColor: kWarningMain,
      );
    } else if (provinceId == null) {
      DialogHelper.showSnackBar(
        'Pilih Provinsi Terlebih Dahulu',
        title: 'Select Provinsi',
        backgroundColor: kWarningMain,
      );
    } else if (cityId == null) {
      DialogHelper.showSnackBar(
        'Pilih Kota Terlebih Dahulu',
        title: 'Select City',
        backgroundColor: kWarningMain,
      );
    } else if (halalCode == null) {
      DialogHelper.showSnackBar(
        'Pilih Status Halal Terlebih Dahulu',
        title: 'Select Halal Status ',
        backgroundColor: kWarningMain,
      );
    } else {
      var placeInfo = {
        'id': id + 1,
        'title': nameController.text.trim(),
        'place_id': placeidController.text.trim(),
        'lat': latController.text.trim(),
        'lng': lngController.text.trim(),
        'subtitle': subtitleController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'website': webController.text.trim(),
        'country_id': countryId,
        'province_id': provinceId,
        'city_id': cityId,
        'halal_status': halalCode,
        'active_inactive_status': 1,
        'created_at': formattedDate,
        'updated_at': formattedDate,
        'image_banner': photos.take(4),
      };

      await PlacesStore().addPlaceToInternal(placeInfo).then((value) async {
        if (value == 'SUCCESS') {
          await homeC.getPlaceMarks();
          Timer(const Duration(seconds: 3), () {
            Get.toNamed(RouteHelper.getHomeDetailPage(
                widget.placeid, homeC.placeDtl?.name, 'addplace', 'food'));
          });
        }
      });
    }
  }

  // upload ke firestore
  bool isUploading = false;
  // buat loading ketika upload+insert ke firestore
  String getCountryIdForProvince(
      List<Map<String, dynamic>> provinces, int provinceId) {
    String provinceIdStr = provinceId.toString();
    var province = provinces.firstWhere(
      (p) => p['id'] == provinceIdStr,
      orElse: () => {},
    );
    return province.isNotEmpty ? province['country_id'] : "";
  }

  // mulai UI
  String halalStatusLabel = "Halal Status";
  String countryLabel = "Country";
  String provinceLabel = "Province";
  String cityLabel = "City";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: GetBuilder<HomeController>(builder: (home) {
        return home.loading
            ? SafeArea(
                child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: kWhiteColor,
                      padding: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                        bottom: 14,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    // kembali ke halaman sebelumnya / tutup dialog.
                                  },
                                  child: const Icon(
                                      Icons.keyboard_backspace_rounded)),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Edit Place ',
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: extraBold,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30.5,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFieldText(
                                      textController: nameController,
                                      hintText: 'Anta Store / Food / Masjid',
                                      label: 'Place Name',
                                      icon: Icons.email,
                                      padding: false,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: TextFieldText(
                                      textController: latController,
                                      hintText: 'LAT',
                                      label: 'Latitude',
                                      icon: Icons.email,
                                      activeBg: true,
                                      padding: false,
                                      readOnly: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFieldText(
                                      textController: lngController,
                                      hintText: 'LNG',
                                      label: 'Langitude',
                                      icon: Icons.email,
                                      activeBg: true,
                                      padding: false,
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFieldText(
                                      textController: subtitleController,
                                      hintText:
                                          'Ramen Restaurant / Sushi Restaurant / Pecel AyAM',
                                      label: 'Subtitle',
                                      icon: Icons.email,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: TextFieldText(
                                      textController: phoneController,
                                      hintText: '+81092020202',
                                      label: 'Phone Number',
                                      icon: Icons.email,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldText(
                                textController: addressController,
                                hintText: '',
                                label: 'Address',
                                icon: Icons.email,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldText(
                                textController: webController,
                                hintText: '',
                                label: 'Website',
                                icon: Icons.email,
                                padding: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                        disabledItemFn: (String s) =>
                                            s.startsWith('I'),
                                        showSearchBox: true,
                                      ),
                                      items: const [
                                        "Halal Friendly",
                                        "Halal Certified",
                                        "Halal",
                                      ],
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: halalStatusLabel,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(6.0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 0.6,
                                              color: Color(0xFFD2D2D2),
                                            ),
                                          ),
                                        ),
                                        baseStyle: blackTextStyle.copyWith(
                                          fontSize: 15,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value == 'Halal Friendly') {
                                          halalCode = 2;
                                        } else if (value == 'Halal Certified') {
                                          halalCode = 1;
                                        } else {
                                          halalCode = 3;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: DropdownSearch<CountryModel>(
                                      key: ValueKey(countryId ?? UniqueKey()),
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder:
                                            _customPopupItemBuilderExample2,
                                        showSearchBox: false,
                                        title: const Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, left: 18, right: 18),
                                          child: Text('Pilih Negara'),
                                        ),
                                      ),
                                      compareFn: (item, selectedItem) =>
                                          item.id == selectedItem.id,
                                      // Menampilkan nama country pada field dropdown
                                      itemAsString: (CountryModel? item) =>
                                          item?.name ?? '',
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: countryLabel,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            borderSide: BorderSide(
                                                width: 0.6,
                                                color: Color(0xFFD2D2D2)),
                                          ),
                                        ),
                                      ),
                                      onChanged: (CountryModel? j) {
                                        if (j != null && j.id != countryId) {
                                          setState(() {
                                            countryId = j.id;
                                            countryLabel = j.name;
                                            provinceId = null;
                                            provinceLabel = "Province";
                                            cityId = null;
                                            cityLabel = "City";
                                            // Reset city
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownSearch<ProvinceModel>(
                                key: ValueKey(provinceId ?? UniqueKey()),
                                asyncItems: (filter) => getDataProvinci(filter),
                                popupProps:
                                    PopupPropsMultiSelection.modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _customPopupProvince,
                                  showSearchBox: true,
                                  title: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 18, right: 18),
                                    child: Text('Pilih Provinsi'),
                                  ),
                                ),
                                compareFn: (item, selectedItem) =>
                                    item.id == selectedItem.id,
                                // Pastikan menampilkan nama province
                                itemAsString: (ProvinceModel? item) =>
                                    item?.name ?? '',
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: provinceLabel,
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                      borderSide: BorderSide(
                                          width: 0.6, color: Color(0xFFD2D2D2)),
                                    ),
                                  ),
                                ),
                                onChanged: (ProvinceModel? j) {
                                  if (j != null && j.id != provinceId) {
                                    setState(() {
                                      provinceId = int.tryParse(j.id);
                                      provinceLabel = j.name;
                                      cityId = null;
                                      cityLabel = "City";
                                    });
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownSearch<CityModel>(
                                key: ValueKey(cityId ?? UniqueKey()),
                                asyncItems: (filter) => getDataCity(filter),
                                popupProps:
                                    PopupPropsMultiSelection.modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _customPopupCity,
                                  showSearchBox: true,
                                  title: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 18, right: 18),
                                    child: Text('Pilih Kota'),
                                  ),
                                ),
                                compareFn: (item, selectedItem) =>
                                    item.id == selectedItem.id,
                                // Menampilkan nama city pada field dropdown
                                itemAsString: (CityModel? item) =>
                                    item?.name ?? '',
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: cityLabel,
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                      borderSide: BorderSide(
                                          width: 0.6, color: Color(0xFFD2D2D2)),
                                    ),
                                  ),
                                ),
                                onChanged: (CityModel? j) {
                                  if (j != null && j.id != cityId) {
                                    setState(() {
                                      cityId = int.tryParse(j.id);
                                      cityLabel = j.name;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                title: 'Simpan Place',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            : const SizedBox();
      }),
    );
  }
}
