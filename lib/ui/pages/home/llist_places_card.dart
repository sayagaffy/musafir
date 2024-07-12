// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/place_store.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/home/widgets/checkbox.dart';
import 'package:musafir/ui/pages/home/widgets/dropdown.dart';
import 'package:musafir/ui/widgets/card_recom.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/skeleton_card_rekomendasi.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class ListPlacesCard extends StatefulWidget {
  final String type;
  final String search;

  const ListPlacesCard({
    super.key,
    required this.type,
    required this.search,
  });

  @override
  State<ListPlacesCard> createState() => _ListPlacesCardState();
}

class _ListPlacesCardState extends State<ListPlacesCard> {
  final user = FirebaseAuth.instance.currentUser;
  var homeController = Get.find<HomeController>();
  var locationController = Get.find<LocationController>();
  bool isLoad = false;
  String? latlang;
  List placesData = [];

  @override
  void initState() {
    getData();
    getPlacesData();
    super.initState();
  }

  void getData() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        latlang = value['lat'] != null
            ? '${value['lat']},${value['lng']}'
            : locationController.latlng.toString();
      });
    });
  }

  void getPlacesData() async {
    await PlacesStore()
        .placesList(homeController.countryId, homeController.cityId)
        .then((payload) async {
      for (var i in payload.docs) {
        var destination =
            '${homeController.filterDot(i.data()['lat'])},${homeController.filterDot(i.data()['lng'])}';
        await homeController
            .distance(latlang.toString(), destination)
            .then((value) {
          Map<String, dynamic> newdata = {
            "place_id": i.data()['place_id'],
            'title': i.data()['title'],
            'halal_status': i.data()['halal_status'],
            'address': i.data()['address'],
            'jarak': value.replaceAll('km', ''),
          };
          setState(() {
            placesData.add(newdata);
          });
        });
      }
    });

    setState(() {
      isLoad = true;
    });
  }

  void getPlaceHalalStatus(int status) async {
    setState(() {
      isLoad = false;
    });
    await PlacesStore()
        .placesListWhere(
            homeController.countryId, homeController.cityId, status)
        .then((payload) async {
      for (var i in payload.docs) {
        var destination = i.data()['lat'] + ',' + i.data()['lng'];
        await homeController
            .distance(latlang.toString(), destination)
            .then((value) {
          Map<String, dynamic> newdata = {
            "place_id": i.data()['place_id'],
            'title': i.data()['title'],
            'halal_status': i.data()['halal_status'],
            'address': i.data()['address'],
            'jarak': value.replaceAll('km', ''),
          };

          setState(() {
            placesData.add(newdata);
          });
        });
      }
    });

    setState(() {
      isLoad = true;
    });
  }

  List<String> radius = [
    'Jarak',
    'Paling Dekat',
    'Paling Jauh',
  ];

  String selectedRadius = 'Jarak';

  void getPlace(String keyword, String type, int jarak) async {
    await homeController.getNearbyPlace(
      keyword: keyword,
      rankby: 'prominence',
      type: type,
      radius: jarak,
      location: latlang ??
          '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
    );
  }

  _handleValueRadius(String value) {
    selectedRadius = value;

    if (value == 'Paling Jauh') {
      setState(() {
        placesData.sort((a, b) => b['jarak'].compareTo(a['jarak']));
      });
    } else if (value == 'Paling Dekat') {
      setState(() {
        placesData.sort((a, b) => a['jarak'].compareTo(b['jarak']));
      });
    } else {
      setState(() {
        placesData.shuffle();
      });
    }

    print(placesData);
  }

  List<String> ulasan = [
    'Kategori Kehalalan',
    'Halal Certified',
    'Halal Frendly',
    'Halal',
  ];

  String selectedUlasan = 'Kategori Kehalalan';

  _handleValueUlasan(String value) {
    setState(() {
      placesData.clear();
    });
    if (value == 'Halal Certified') {
      getPlaceHalalStatus(1);
    } else if (value == 'Halal Frendly') {
      getPlaceHalalStatus(2);
    } else if (value == 'Halal') {
      getPlaceHalalStatus(4);
    } else {
      getPlacesData();
    }
  }

  Widget header() {
    return SafeArea(
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                top: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getHomeSearchPage(widget.type));
                      },
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kNeutral20,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Cari resto atau ruang shalat di Musafir',
                              style: greyTextStyle.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title() {
    String titleList = 'Rekomendasi Resto Verified';
    if (widget.type == 'filterList_mosque') {
      titleList = 'Masjid Terdekat';
    } else if (widget.type == 'filterList_food') {
      titleList = '${widget.search} Food';
    } else {
      titleList = 'Rekomendasi Resto Verified';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
      child: Text(
        titleList,
        style: blackTextStyle.copyWith(
            fontSize: 16, fontWeight: bold, height: 0.6),
      ),
    );
  }

  Widget filter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 20,
        bottom: 20,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     _showFilter(context);
            //   },
            //   child: Chip(
            //     label: Text(
            //       '',
            //       style: blackTextStyle.copyWith(
            //         fontSize: 12,
            //         height: 0.75,
            //       ),
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     backgroundColor: kNeutral40,
            //     side: BorderSide.none,
            //     avatar: Icon(
            //       Icons.tune_rounded,
            //       color: kBlackColor,
            //     ),
            //     padding: const EdgeInsets.only(
            //         left: 15, right: 0, top: 5, bottom: 5),
            //   ),
            // ),
            // const SizedBox(
            //   width: 20,
            // ),
            DropdownFilter(
              selected: selectedRadius,
              items: radius.map(
                (String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                },
              ).toList(),
              valueReturned: _handleValueRadius,
            ),
            const SizedBox(
              width: 10,
            ),
            DropdownFilter(
              selected: selectedUlasan,
              items: ulasan.map(
                (String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Row(
                      children: [Center(child: Text(items))],
                    ),
                  );
                },
              ).toList(),
              valueReturned: _handleValueUlasan,
            ),
          ],
        ),
      ),
    );
  }

  Widget line() {
    return Container(
      width: double.infinity,
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  Widget chekBox() {
    return const CustomCheckBox();
  }

  Widget card20() {
    return isLoad && latlang != null
        ? Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: placesData.isNotEmpty
                ? GridView.builder(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisExtent: 180,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: placesData.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final item = placesData[index];

                      return GestureDetector(
                        onTap: () {
                          var homecontroller = Get.find<HomeController>();

                          homecontroller
                              .placeDetail(item['place_id'].toString());
                          Get.toNamed(RouteHelper.getHomeDetailPage(
                            item['place_id'].toString(),
                            item['title'],
                            widget.type,
                            'food',
                          ));
                        },
                        child: CardRecom(
                          name: item['title'],
                          city: item['address'],
                          imgUrl: item['image_banner'] != null
                              ? '${AppConstans.PLACE_PHOTO}${item['image_banner'].first}'
                              : 'none',
                          margin: const EdgeInsets.only(right: 0),
                          origin: latlang.toString(),
                          halalStatus: item['halal_status'].toString(),
                          destination: item['jarak'],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Resto tidak di temukan',
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
          )
        : const SkeletonCardRekomendasi(
            type: 'gridView',
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          title(),
          filter(context),
          line(),
          Expanded(child: card20()),
          // chekBox(),
        ],
      ),
    );
  }

  // ignore: unused_element
  Future<void> _showFilter(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // This attribute will auto scale size of Column widget when the keyboard showed
            ),
            child: SizedBox(
              height: 450,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Filter',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                            height: 0.7,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: Text(
                          'Kategori Kehalalan',
                          style: blackTextStyle.copyWith(
                            height: 0.7,
                            fontSize: 15,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, top: 15, bottom: 22),
                        child: Row(
                          children: [
                            Chip(
                              label: Text(
                                'Halal Certified',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  height: 0.75,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: kNeutral40,
                              side: BorderSide.none,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Chip(
                              label: Text(
                                'Muslim Friendly',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  height: 0.75,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: kNeutral40,
                              side: BorderSide.none,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   margin: const EdgeInsets.only(bottom: 16),
                      //   height: 2,
                      //   decoration: const BoxDecoration(
                      //     color: Color(0xFFD9D9D9),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 18, right: 18),
                      //   child: Text(
                      //     'Rating',
                      //     style: blackTextStyle.copyWith(
                      //       height: 0.7,
                      //       fontSize: 15,
                      //       fontWeight: bold,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 18,
                      //     right: 18,
                      //     top: 16,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Chip(
                      //         label: Text(
                      //           '1 - 2',
                      //           style: blackTextStyle.copyWith(
                      //             fontSize: 12,
                      //             height: 0.75,
                      //           ),
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(30),
                      //         ),
                      //         backgroundColor: kNeutral40,
                      //         side: BorderSide.none,
                      //         padding: const EdgeInsets.only(
                      //           left: 10,
                      //           right: 10,
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Chip(
                      //         label: Text(
                      //           '2 - 3',
                      //           style: blackTextStyle.copyWith(
                      //             fontSize: 12,
                      //             height: 0.75,
                      //           ),
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(30),
                      //         ),
                      //         backgroundColor: kNeutral40,
                      //         side: BorderSide.none,
                      //         padding: const EdgeInsets.only(
                      //           left: 10,
                      //           right: 10,
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Chip(
                      //         label: Text(
                      //           '3 - 4',
                      //           style: blackTextStyle.copyWith(
                      //             fontSize: 12,
                      //             height: 0.75,
                      //           ),
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(30),
                      //         ),
                      //         backgroundColor: kNeutral40,
                      //         side: BorderSide.none,
                      //         padding: const EdgeInsets.only(
                      //           left: 10,
                      //           right: 10,
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Chip(
                      //         label: Text(
                      //           '4 - 5',
                      //           style: blackTextStyle.copyWith(
                      //             fontSize: 12,
                      //             height: 0.75,
                      //           ),
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(30),
                      //         ),
                      //         backgroundColor: kNeutral40,
                      //         side: BorderSide.none,
                      //         padding: const EdgeInsets.only(
                      //           left: 10,
                      //           right: 10,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const CustomCheckBox(),
                      CustomButton(
                        title: 'Tampilkan Resto',
                        onPressed: () {},
                        margin: const EdgeInsets.only(
                          top: 30,
                          left: 18,
                          right: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
