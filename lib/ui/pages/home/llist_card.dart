// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/home/widgets/checkbox.dart';
import 'package:musafir/ui/pages/home/widgets/dropdown.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/textfield_google.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCard extends StatefulWidget {
  final String type;
  final String search;
  const ListCard({super.key, required this.type, required this.search});

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  final user = FirebaseAuth.instance.currentUser;
  var homeController = Get.find<HomeController>();
  var locationController = Get.find<LocationController>();
  String? latlang;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var locationController = Get.find<LocationController>();
    UserStore().getUserDetail().then((value) {
      setState(() {
        latlang = value['lat'] != null
            ? '${value['lat']},${value['long']}'
            : locationController.latlng.toString();
      });
    });
  }

  List<String> ratings = [
    'Rating',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  String selectedRating = 'Rating';
  int? rate;
  List<String> radius = [
    'Jarak',
    '< 2 km',
    '> 2 km',
  ];

  String selectedRadius = 'Jarak';

  void getPlace(String keyword, String type, int jarak) {
    homeController.getNearbyPlace(
      keyword: keyword,
      rankby: 'prominence',
      type: type,
      radius: jarak,
      location: latlang ??
          '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
    );
  }

  _handleValueRating(String value) {
    if (value == 'Rating') {
      homeController.setFilterType('default');
    } else {
      homeController.setFilterType('rating');
      if (value != 'Rating') {
        selectedRating = value;
        homeController.setRate(int.parse(value));
      }
    }
  }

  _handleValueRadius(String value) {
    selectedRadius = value;

    if (widget.type == 'filterList_resto' && value == '< 2 km') {
      getPlace('food', 'restaurant', 2000);
    } else if (widget.type == 'filterList_resto' && value == '> 2 km') {
      getPlace('food', 'restaurant', 10000);
    } else if (widget.type == 'filterList_resto' && value == 'Jarak') {
      homeController.getNearbyPlace(
        keyword: 'food',
        rankby: 'distance',
        type: 'restaurant',
        location: latlang ??
            '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
      );
    }

    if (widget.type == 'filterList_mosque' && value == '< 2 km') {
      getPlace('masjid', 'mosque', 2000);
    } else if (widget.type == 'filterList_mosque' && value == '> 2 km') {
      getPlace('masjid', 'mosque', 10000);
    } else if (widget.type == 'filterList_mosque' && value == 'Jarak') {
      homeController.getNearbyPlace(
        keyword: 'masjid',
        rankby: 'distance',
        type: 'mosque',
        location: latlang ??
            '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
      );
    }

    if (widget.type == 'filterList_food' && value == '< 2 km') {
      getPlace('${widget.search}+food', 'food', 2000);
    } else if (widget.type == 'filterList_food' && value == '> 2 km') {
      getPlace('${widget.search}+food', 'food', 10000);
    } else if (widget.type == 'filterList_food' && value == 'Jarak') {
      homeController.getNearbyPlace(
        keyword: '${widget.search}+food',
        rankby: 'distance',
        type: 'food',
        location: latlang ??
            '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
      );
    }

    print(value);
  }

  List<String> ulasan = [
    'Ulasan',
    'Paling Tinggi',
    'Paling Rendah',
  ];

  String selectedUlasan = 'Ulasan';

  _handleValueUlasan(String value) {
    if (value == 'Ulasan') {
      homeController.setFilterType('default');

      if (widget.type == 'filterList_resto') {
        homeController.getNearbyPlace(
          keyword: 'food',
          rankby: 'distance',
          type: 'restaurant',
          location: latlang ??
              '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
        );
      } else if (widget.type == 'filterList_mosque') {
        homeController.getNearbyPlace(
          keyword: 'masjid',
          rankby: 'distance',
          type: 'mosque',
          location: latlang ??
              '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
        );
      } else if (widget.type == 'filterList_food') {
        homeController.getNearbyPlace(
          keyword: '${widget.search}+food',
          rankby: 'distance',
          type: 'food',
          location: latlang ??
              '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}',
        );
      }
    } else if (value == 'Paling Tinggi') {
      homeController.setFilterType('ulasan_1');
    } else if (value == 'Paling Rendah') {
      homeController.setFilterType('ulasan_0');
    }

    selectedUlasan = value;
  }

  Widget header(BuildContext context) {
    return TextfieldGoogle(
        hintText: 'Cari resto atau ruang shalat di Musafir',
        onTap: () {
          if (widget.type == 'filterList_food') {
            homeController.isLoadedFoodKategory = false;
          }

          homeController.setFilterType('default');
          Get.toNamed(RouteHelper.getInitial());
        });
  }

  Widget title() {
    String titleList = 'Rekomendasi Resto Terdekat';
    if (widget.type == 'filterList_mosque') {
      titleList = 'Masjid Terdeka';
    } else if (widget.type == 'filterList_food') {
      titleList = '${widget.search} Food';
    } else {
      titleList = 'Rekomendasi Resto Terdekat';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
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
            GestureDetector(
              onTap: () {
                _showFilter(context);
              },
              child: Chip(
                label: Text(
                  '',
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
                avatar: Icon(
                  Icons.tune_rounded,
                  color: kBlackColor,
                ),
                padding: const EdgeInsets.only(
                    left: 15, right: 0, top: 5, bottom: 5),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
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
              selected: selectedRating,
              items: ratings.map(
                (String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Row(
                      children: [Center(child: Text(items))],
                    ),
                  );
                },
              ).toList(),
              valueReturned: _handleValueRating,
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
      height: 1,
      decoration: BoxDecoration(
        color: const Color(0xFFC8C9CA),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC8C9CA).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget chekBox() {
    return const CustomCheckBox();
  }

  Widget listCard() {
    return GetBuilder<HomeController>(builder: (place) {
      var defaultList = [];
      void defaults() {
        if (widget.type == 'filterList_resto') {
          defaultList = place.nearbyFood;
        } else if (widget.type == 'filterList_mosque') {
          defaultList = place.nearbyMosque;
        } else {
          defaultList = place.nearbyFoodKategory;
        }
      }

      defaults();

      if (place.filterType == 'default') {
        defaults();
      } else if (place.filterType == 'rating') {
        defaultList = defaultList
            .where((a) => a.rating >= place.rate && a.rating <= place.rate + .9)
            .toList();
      } else if (place.filterType == 'ulasan_1') {
        defaultList
            .sort((a, b) => b.userRatingsTotal.compareTo(a.userRatingsTotal));
      } else if (place.filterType == 'ulasan_0') {
        defaultList
            .sort((a, b) => a.userRatingsTotal.compareTo(b.userRatingsTotal));
      }

      return widget.type == 'filterList_resto'
          ? card20(defaultList, place.isLoadedFood)
          : widget.type == 'filterList_mosque'
              ? card20(defaultList, place.isLoadedMosque)
              : card20(defaultList, place.isLoadedFoodKategory);
    });
  }

  Widget card20(defaultList, bool load) {
    return load
        ? Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: defaultList.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 206,
                      mainAxisExtent: 206,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: defaultList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final item = defaultList[index];
                      return GestureDetector(
                        onTap: () {
                          var homecontroller = Get.find<HomeController>();

                          homecontroller.placeDetail(item.placeId.toString());
                          Get.toNamed(RouteHelper.getHomeDetailPage(
                              item.placeId.toString(), item.name, widget.type));
                        },
                        child: RekomendasiCard(
                          name: item.name,
                          city: item.vicinity,
                          imgUrl: item.photos != null
                              ? '${AppConstans.PLACE_PHOTO}${item.photos.first.photoReference}'
                              : 'none',
                          rating: item.rating,
                          ulasan: item.userRatingsTotal,
                          km: index.toDouble(),
                          margin: const EdgeInsets.only(right: 0),
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
        : Padding(
            padding: const EdgeInsets.only(top: 26, bottom: 26),
            child: SizedBox(
              height: 206,
              width: double.infinity,
              child: Skeletonizer(
                ignorePointers: false,
                child: GridView.builder(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 206,
                    mainAxisExtent: 206,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return const RekomendasiCard(
                      name: 'item.name',
                      city: 'item.vicinity',
                      rating: 0,
                      ulasan: 0,
                      margin: EdgeInsets.only(right: 0),
                    );
                  },
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          title(),
          filter(context),
          line(),
          Expanded(child: listCard()),
          // chekBox(),
        ],
      ),
    );
  }

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
