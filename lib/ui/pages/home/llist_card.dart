import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/home/widgets/checkbox.dart';
import 'package:musafir/ui/pages/home/widgets/dropdown.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';

import 'package:musafir/ui/widgets/textfield_google.dart';

class ListCard extends StatelessWidget {
  final String type;
  const ListCard({super.key, required this.type});

  Widget header(BuildContext context) {
    return TextfieldGoogle(
        hintText: 'Ketik lokasi disini',
        onTap: () {
          Get.offNamed(RouteHelper.getInitial());
        });
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Text(
        'Rekomendasi Resto Terdekat',
        style: blackTextStyle.copyWith(
            fontSize: 16, fontWeight: bold, height: 0.6),
      ),
    );
  }

  Widget filter(BuildContext context) {
    List<String> radius = [
      'Jarak',
      '< 2 km',
      '> 2 km',
    ];

    String selectedRadius = 'Jarak';
    _handleValueRadius(String value) {
      selectedRadius = value;
    }

    List<String> ratings = [
      'Rating',
      '1 - 2',
      '2 - 3',
      '3 - 4',
      '4 - 5',
    ];

    String selectedRating = 'Rating';
    _handleValueRating(String value) {
      selectedRating = value;
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _showFilter(context);
            },
            child: Chip(
              label: Text(
                'Filtter',
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
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                  child: Text(items),
                );
              },
            ).toList(),
            valueReturned: _handleValueRating,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget chekBox() {
    return CustomCheckBox();
  }

  Widget listCard() {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 26, bottom: 26),
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        children: [
          GestureDetector(
            onTap: () {
              Get.offNamed(RouteHelper.getHomeDetailPage(
                  01, 'Shinju Ramen', 'filterList_food'));
            },
            child: const RekomendasiCard(
              name: 'Shinju Ramen',
              city: 'Tokyo, Jepang',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
              margin: EdgeInsets.only(right: 0),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offNamed(RouteHelper.getHomeDetailPage(
                  02, 'Burger Boss', 'filterList_food'));
            },
            child: const RekomendasiCard(
              name: 'Burger Boss',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
              margin: EdgeInsets.only(right: 0),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offNamed(RouteHelper.getHomeDetailPage(
                  03, 'The Halal Guys', 'filterList_food'));
            },
            child: const RekomendasiCard(
              name: 'The Halal Guys',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
              margin: EdgeInsets.only(right: 0),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offNamed(RouteHelper.getHomeDetailPage(
                  04, 'Pecel Gairah Malam', 'filterList_food'));
            },
            child: const RekomendasiCard(
              name: 'Pecel Gairah Malam',
              city: 'Tebet, Jakarta',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
              margin: EdgeInsets.only(right: 0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(context),
          title(),
          filter(context),
          listCard(),
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
                      CustomCheckBox(),
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
