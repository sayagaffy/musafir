/// Halaman ini menampilkan daftar item yang diambil dari API.
///
/// Pada bagian awal, terdapat inisialisasi variabel dan fungsi untuk mengambil data dari API.
/// Fungsi `fetchItems` digunakan untuk mengambil data dari API dan menyimpannya dalam variabel `items`.
///
/// Setelah data berhasil diambil, halaman ini akan menampilkan daftar item dalam bentuk ListView.
/// Setiap item dalam daftar ditampilkan menggunakan widget ListTile yang berisi judul dan deskripsi item.
///
/// Jika terjadi kesalahan saat mengambil data dari API, halaman ini akan menampilkan pesan kesalahan.
///
/// Selain itu, terdapat juga indikator loading yang ditampilkan saat data sedang diambil dari API.
/// Indikator loading ini akan hilang setelah data berhasil diambil atau terjadi kesalahan.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:map_launcher/map_launcher.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List dataPlans = [];

  var authController = Get.find<AuthController>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    UserStore().exploreList().then((value) {
      setState(() {
        for (var i in value.docs) {
          Map<String, dynamic> payload = {
            "place_id": i.data()['place_id'],
            'place_name': i.data()['place_name'],
            'start_time': i.data()['start_time'],
            'end_time': i.data()['end_time'],
            'name_plan': i.data()['name_plan'],
            'lat': i.data()['lat'],
            'lng': i.data()['lng'],
            'resto': i.data()['resto'],
            'mosque': i.data()['mosque'],
            'id': i.id
          };
          dataPlans.add(payload);
        }
      });
    });
  }

  void navigasiPeta(int indexParent) async {
    final availableMaps = await MapLauncher.installedMaps;

    String lat = dataPlans[indexParent]['lat'].toString();
    String lng = dataPlans[indexParent]['lng'].toString();

    await availableMaps.first.showMarker(
      coords: Coords(double.parse(lat), double.parse(lng)),
      title: "${dataPlans[indexParent]['place_name']}",
    );
  }

  void edit(int indexParent) async {
    var explorC = Get.find<ExploreController>();
    // print(dataPlans[indexParent]);
    explorC.namePlan.text = dataPlans[indexParent]['name_plan'];
    explorC.searchPlace.text = dataPlans[indexParent]['place_name'];
    explorC.startDtTime.text = dataPlans[indexParent]['start_time'];
    explorC.endDtTime.text = dataPlans[indexParent]['end_time'];
    explorC.placeIdX.value = dataPlans[indexParent]['place_id'];
    explorC.updateLatLng(
        dataPlans[indexParent]['lat'], dataPlans[indexParent]['lng']);
    explorC.selectedFood = dataPlans[indexParent]['resto'];
    explorC.selectedMosque = dataPlans[indexParent]['mosque'];
    explorC.idDocument = dataPlans[indexParent]['id'];

    Get.offNamed(RouteHelper.getRencanaPageEdit());
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.only(top: 21, bottom: 20),
      width: double.infinity,
      child: Center(
        child: Text(
          'Explore',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: extraBold,
          ),
        ),
      ),
    );
  }

  Widget cardPerjalanan() {
    return Container(
      margin: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 13,
        left: 15,
        right: 15,
      ),
      height: 154,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Temukan & simpan resto dan tempat shalat di kota tujuanmu, di seluruh dunia!',
            style: blackTextStyle.copyWith(
              fontWeight: extraBold,
              fontSize: 16,
              height: 1.3,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            width: 80,
            child: TextButton(
              onPressed: () {
                authController.checkUserSignin();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF9E9E9E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Buat',
                style: whiteTextStyle.copyWith(
                  fontSize: 10,
                  fontWeight: bold,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleRencana() {
    return Text(
      'Rencana Perjalananmu',
      style: blackTextStyle.copyWith(
        fontSize: 16,
        fontWeight: bold,
      ),
    );
  }

  Widget listPerjalanan(
      String place, String placeId, String startTime, String endTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 0,
          ),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      place.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      'Berangkat',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      startTime,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text(
                      'Kembali',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      endTime,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listPlan(int indexParent) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          dataPlans[indexParent]['name_plan'],
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
        subtitle: Column(
          children: [
            Text(
              "${dataPlans[indexParent]['place_name']}, ${dataPlans[indexParent]['start_time']} - ${dataPlans[indexParent]['end_time']}",
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        trailing: const Icon(Icons.expand_more),
        backgroundColor: kNeutral20,
        collapsedBackgroundColor: kNeutral20,
        collapsedShape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  width: 80,
                  child: TextButton(
                    onPressed: () {
                      edit(indexParent);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF9E9E9E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Edit ',
                      style: whiteTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          dataPlans[indexParent]['resto'].isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 18,
                    right: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restoran Tujuan ${dataPlans[indexParent]['resto'].length}',
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: bold),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: dataPlans[indexParent]['resto'].length > 1
                            ? 200
                            : 110,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    dataPlans[indexParent]['resto'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return contactItem(
                                    indexParent,
                                    dataPlans[indexParent]['resto'][index]
                                        ['title'],
                                    dataPlans[indexParent]['resto'][index]
                                        ['address'],
                                    dataPlans[indexParent]['resto'][index]
                                        ['halalStatus'],
                                    dataPlans[indexParent]['resto'][index]
                                        ['jarak'],
                                    dataPlans[indexParent]['resto'][index]
                                        ['photos'],
                                    dataPlans[indexParent]['resto'][index]
                                        ['place_id'],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tidak Ada persinggahan',
                    style: blackTextStyle.copyWith(fontSize: 15),
                  ),
                ),
          dataPlans[indexParent]['mosque'].isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 18,
                    right: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Masjid Tujuan ${dataPlans[indexParent]['mosque'].length}',
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: bold),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: dataPlans[indexParent]['mosque'].length > 1
                            ? 200
                            : 110,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    dataPlans[indexParent]['mosque'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return contactItem2(
                                    indexParent,
                                    dataPlans[indexParent]['mosque'][index]
                                        ['title'],
                                    dataPlans[indexParent]['mosque'][index]
                                        ['address'],
                                    dataPlans[indexParent]['mosque'][index]
                                        ['jarak'],
                                    dataPlans[indexParent]['mosque'][index]
                                        ['photos'],
                                    dataPlans[indexParent]['mosque'][index]
                                        ['place_id'],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget contactItem(int indexParent, String title, String address,
      String halalStatus, String destination, String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: _getImageDecoration(photos),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(
                    right: 3,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(halalStatus == '1'
                          ? 'assets/icon_halal.png'
                          : halalStatus == '2'
                              ? 'assets/icon_halal_blue.png'
                              : 'assets/icon_halal_black.png'),
                    ),
                  ),
                ),
                Text(
                  halalStatus == '1'
                      ? 'Halal Certified'
                      : halalStatus == '2'
                          ? 'Halal Friendly'
                          : 'Halal',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                    color: halalStatus == '1'
                        ? kGreenHover
                        : halalStatus == '2'
                            ? kBlueColorHover
                            : kBlackColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () async {
                    final availableMaps = await MapLauncher.installedMaps;
                    await availableMaps.first.showMarker(
                      coords: Coords(
                          double.parse(dataPlans[indexParent]['lat']),
                          double.parse(dataPlans[indexParent]['lng'])),
                      title: title,
                    );
                  },
                  child: Text(
                    'Lihat Tujuan',
                    style: TextStyle(color: kBlueColor),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  DecorationImage _getImageDecoration(String photos) {
    if (photos == 'none' || photos.isEmpty) {
      return const DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/image_destination1.png'),
      );
    }

    try {
      // Validate photo reference before constructing URL
      final photoUrl = '${AppConstans.PLACE_PHOTO}$photos';
      return DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(photoUrl),
        onError: (exception, stackTrace) {
          print('Error loading photo: $exception');
        },
      );
    } catch (e) {
      print('Invalid photo reference: $photos');
      return const DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/image_destination1.png'),
      );
    }
  }

  Widget contactItem2(int indexParent, String title, String address,
      String destination, String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                    onError: (exception, stackTrace) {
                      print('Error loading mosque photo: $exception');
                    },
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(
                    right: 3,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon_halal_black.png'),
                    ),
                  ),
                ),
                Text(
                  'Masjid',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                    color: kBlackColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () async {
                    final availableMaps = await MapLauncher.installedMaps;
                    await availableMaps.first.showMarker(
                      coords: Coords(
                          double.parse(dataPlans[indexParent]['lat']),
                          double.parse(dataPlans[indexParent]['lng'])),
                      title: title,
                    );
                  },
                  child: Text(
                    'Lihat Tujuan',
                    style: TextStyle(color: kBlueColor),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(),
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: dataPlans.isNotEmpty
                ? SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleRencana(),
                        const SizedBox(
                          height: 21,
                        ),
                        SizedBox(
                          height: 500,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataPlans.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: listPlan(index),
                              );
                            },
                          ),
                        ),
                        dataPlans.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomButton(
                                    title: 'Buat Rencana lainnya ',
                                    onPressed: () {
                                      Get.offNamed(
                                          RouteHelper.getRencanaPage());
                                    },
                                    width: 207,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                : cardPerjalanan(),
          ),
        ],
      ),
    );
  }
}
