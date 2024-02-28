import 'package:get/get.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/custom_search_button.dart';
import 'package:musafir/ui/widgets/custom_title.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/rekomendasi_title.dart';
import 'package:musafir/ui/widgets/tile_card.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _somethingFromApiLoaded = false;

  Widget header() {
    var locationController = Get.find<LocationController>();
    Get.put<GoogleController>(
      GoogleController(googleRepo: Get.find()),
      permanent: true,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: defaultMargin,
        top: 20,
        bottom: 9,
        right: defaultMargin,
      ),
      decoration: BoxDecoration(color: kPrimarySurface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assalamualaikum, Habib',
            style: blackTextStyle.copyWith(
                fontWeight: extraBold, fontSize: 20, height: 0.7),
          ),
          Container(
              margin: const EdgeInsets.only(top: 11, bottom: 11),
              child: locationController.address != "none"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Kamu sedang berada di ',
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: regular),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed(RouteHelper.getLocationPage());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  ' ${locationController.address}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.expand_more_rounded,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getLocationPage());
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.my_location_rounded,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Lokasi kamu belum di perbaharui,',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' ubah disini.',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    )),
          const SizedBox(height: 32, child: CustomSearchButton()),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget titleRekomendasi() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: RekomendasiTitle(
        title: 'Rekomendasi',
        onTap: () {
          Get.offNamed(RouteHelper.getHomeListPage('filterList_food'));
        },
      ),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
      width: double.infinity,
      child: GetBuilder<GoogleController>(builder: (place) {
        return place.isLoadedFood
            ? SizedBox(
                height: 206,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      final sortItems = place.nearbyFood
                        ..sort((a, b) =>
                            b.userRatingsTotal.compareTo(a.userRatingsTotal));
                      final item = sortItems[index];

                      return GestureDetector(
                        onTap: () {
                          Get.offNamed(
                            RouteHelper.getHomeDetailPage(
                                index, '${item.placeId}', 'homePage'),
                          );
                        },
                        //'${AppConstans.BASE_URL_GOOGLE}${AppConstans.PLACE_PHOTO}?maxwidth=400&photo_reference=${item.photos.first.photoReference,}&key=${AppConstans.API_GKEY}',
                        child: RekomendasiCard(
                          name: item.name,
                          city: item.vicinity,
                          // imgUrl:
                          //     '${AppConstans.BASE_URL_GOOGLE}${AppConstans.PLACE_PHOTO}?maxwidth=400&photo_reference=${item.photos.first.photoReference}&key=${AppConstans.API_GKEY}',
                          rating: item.rating,
                          ulasan: item.userRatingsTotal,
                        ),
                      );
                    }),
              )
            : SizedBox(
                height: 206,
                width: double.infinity,
                child: Skeletonizer(
                  ignorePointers: false,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return const RekomendasiCard(
                          name: 'item.name',
                          city: 'item.vicinity',
                          rating: 10,
                          ulasan: 10,
                        );
                      }),
                ),
              );
      }),
    );
  }

  Widget line() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 25),
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  Widget titleKategoriMakanan() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: const CustomTitle(title: 'Kategori Makanan'),
    );
  }

  Widget kategoriMakanan() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            TileCard(
              title: 'Algerian',
              imgUrl: 'assets/image_destination3.png',
            ),
            TileCard(
              title: 'Desert',
              imgUrl: 'assets/image_destination2.png',
            ),
            TileCard(
              title: 'Hindi',
              imgUrl: 'assets/image_destination1.png',
            ),
            TileCard(
              title: 'Bake',
              imgUrl: 'assets/image_destination4.png',
            ),
            TileCard(
              title: 'Pizza',
              imgUrl: 'assets/image_destination2.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget titleRekomendasiMasjid() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: RekomendasiTitle(
        title: 'Masjid Terdekat',
        onTap: () {
          Get.offNamed(RouteHelper.getHomeListPage('filterList_mosque'));
        },
      ),
    );
  }

  Widget rekomendasiMasjid() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin, bottom: 50),
      width: double.infinity,
      child: GetBuilder<GoogleController>(builder: (place) {
        return place.isLoadedMosque
            ? SizedBox(
                height: 206,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      final item = place.nearbyMosque[index];

                      return GestureDetector(
                        onTap: () {
                          Get.offNamed(
                            RouteHelper.getHomeDetailPage(
                                index, '${item.placeId}', 'homePage'),
                          );
                        },
                        child: RekomendasiCard(
                          name: item.name,
                          city: item.vicinity,
                          // imgUrl: item.photos != null
                          //     ? '${AppConstans.BASE_URL_GOOGLE}${AppConstans.PLACE_PHOTO}?maxwidth=400&photo_reference=${item.photos.first.photoReference}&key=${AppConstans.API_GKEY}'
                          //     : 'none',
                          rating: item.rating,
                          ulasan: item.userRatingsTotal,
                          isMasjid: true,
                        ),
                      );
                    }),
              )
            : SizedBox(
                height: 206,
                width: double.infinity,
                child: Skeletonizer(
                  ignorePointers: false,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return const RekomendasiCard(
                          name: 'item.name',
                          city: 'item.vicinity',
                          rating: 10,
                          ulasan: 10,
                        );
                      }),
                ),
              );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(),
          titleRekomendasi(),
          rekomendasi(),
          line(),
          titleKategoriMakanan(),
          kategoriMakanan(),
          line(),
          titleRekomendasiMasjid(),
          rekomendasiMasjid(),
        ],
      ),
    );
  }
}
