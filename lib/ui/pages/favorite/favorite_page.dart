import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/favorite_card.dart';
import 'package:musafir/ui/widgets/skeleton_card_rekomendasi.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future favorite = UserStore().bookmarkList().then((value) {
    if (value != null) {
      return value['place'];
    } else {
      return null;
    }
  });

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Container(
        margin: const EdgeInsets.only(top: 21),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Favorite',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: extraBold,
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: const Icon(Icons.safety_check),
            // )
          ],
        ),
      ),
    );
  }

  Widget listCard() {
    return FutureBuilder(
      future: favorite,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.hasData
              ? Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 70),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 206,
                        mainAxisExtent: 190,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final item = snapshot.data[index];
                        return GestureDetector(
                          onTap: () {
                            var homecontroller = Get.find<HomeController>();
                            homecontroller.placeDetail(item['place_id']);

                            Get.toNamed(RouteHelper.getHomeDetailPage(
                              item['place_id'],
                              item['place_name'],
                              'favorite',
                              item['type'],
                            ));
                          },
                          child: FavoriteCard(
                            name: item['place_name'],
                            city: item['address'],
                            imgUrl:
                                '${AppConstans.PLACE_PHOTO}${item['photo']}',
                            km: index.toDouble(),
                            margin: const EdgeInsets.only(right: 0),
                            isMasjid: item['type'] == 'mosque' ? true : false,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'Kamu belum memiliki favorite place',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                );
        }

        return const SkeletonCardRekomendasi();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          header(),
          listCard(),
        ],
      ),
    );
  }
}
