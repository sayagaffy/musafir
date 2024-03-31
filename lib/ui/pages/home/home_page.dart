import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:flutter/material.dart';
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
  String? name;
  String? address;
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
        name = value['firstName'] ?? value['username'];
        address = value['address'] ?? 'none';
        latlang = value['lat'] != null
            ? '${value['lat']},${value['long']}'
            : locationController.latlng.toString();
      });
    });
  }

  Widget header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: defaultMargin,
        top: 20,
        right: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 300,
                height: 20,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Text(
                        'Assalamualaikum $name',
                        style: blackTextStyle.copyWith(
                          fontWeight: extraBold,
                          fontSize: 20,
                          height: 0.7,
                          color: kBlueColorHover,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var authC = Get.find<AuthController>();
                  authC.logout();
                },
                child: Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: kWarningMain,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.toNamed(RouteHelper.getFavoritePage());
                },
                child: Icon(
                  Icons.filter,
                  size: 20,
                  color: kBlackColor,
                ),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 15,
              ),
              child: address != "none"
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
                            Get.toNamed(RouteHelper.getLocationPage());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  ' $address',
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
                        Get.toNamed(RouteHelper.getLocationPage());
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
          SizedBox(
            height: 32,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getHomeSearchPage());
              },
              child: Container(
                height: 32,
                width: double.infinity,
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
          ),
        ],
      ),
    );
  }

  Widget titleRekomendasi() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: RekomendasiTitle(
        title: 'Rekomendasi Resto Terdekat',
        onTap: () {
          Get.toNamed(RouteHelper.getHomeListPage('filterList_resto', 'none'));
        },
      ),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: EdgeInsets.only(
        left: defaultMargin,
        bottom: 20,
      ),
      width: double.infinity,
      child: GetBuilder<HomeController>(builder: (place) {
        return place.isLoadedFood
            ? SizedBox(
                height: 206,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: place.nearbyFood.isNotEmpty ? 5 : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final item = place.nearbyFood[index];

                      return GestureDetector(
                        onTap: () {
                          var homecontroller = Get.find<HomeController>();
                          homecontroller.placeDetail(item.placeId.toString());

                          Get.toNamed(RouteHelper.getHomeDetailPage(
                              item.placeId.toString(),
                              item.name,
                              'homePage',
                              'food'));
                        },
                        child: RekomendasiCard(
                          name: item.name,
                          city: item.vicinity,
                          imgUrl: item.photos != null
                              ? '${AppConstans.PLACE_PHOTO}${item.photos.first.photoReference}'
                              : 'none',
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
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  Widget titleKategoriMakanan() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: RekomendasiTitle(
        title: 'Kategori',
        onTap: () {},
      ),
    );
  }

  Widget kategoriMakanan() {
    var homeController = Get.find<HomeController>();
    var locationController = Get.find<LocationController>();
    String latLang = latlang ??
        '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}';
    return Container(
      padding: EdgeInsets.only(left: defaultMargin, bottom: 20),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                homeController.getNearbyPlace(
                  keyword: 'algerian+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latLang,
                );

                Get.toNamed(
                  RouteHelper.getHomeListPage('filterList_food', 'Algerian'),
                );
              },
              child: const TileCard(
                title: 'Algerian',
                imgUrl: 'assets/Algerian.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.getNearbyPlace(
                  keyword: 'indian+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latLang,
                );

                Get.toNamed(
                  RouteHelper.getHomeListPage('filterList_food', 'Indian'),
                );
              },
              child: const TileCard(
                title: 'Indian',
                imgUrl: 'assets/Indian.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.getNearbyPlace(
                  keyword: 'japan+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latLang,
                );

                Get.toNamed(
                  RouteHelper.getHomeListPage('filterList_food', 'Japan'),
                );
              },
              child: const TileCard(
                title: 'Japan',
                imgUrl: 'assets/Japanse.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.getNearbyPlace(
                  keyword: 'bakery+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latLang,
                );

                Get.toNamed(
                  RouteHelper.getHomeListPage('filterList_food', 'Bakery'),
                );
              },
              child: const TileCard(
                title: 'Bakery',
                imgUrl: 'assets/Bakery.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.getNearbyPlace(
                  keyword: 'korean+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latLang,
                );

                Get.toNamed(
                  RouteHelper.getHomeListPage('filterList_food', 'Korean'),
                );
              },
              child: const TileCard(
                title: 'Korean',
                imgUrl: 'assets/Korean.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleRekomendasiMasjid() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        top: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: RekomendasiTitle(
        title: 'Masjid Terdekat',
        onTap: () {
          Get.toNamed(RouteHelper.getHomeListPage('filterList_mosque', 'none'));
        },
      ),
    );
  }

  Widget rekomendasiMasjid() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin, bottom: 50),
      width: double.infinity,
      child: GetBuilder<HomeController>(builder: (place) {
        return place.isLoadedMosque
            ? SizedBox(
                height: 206,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: place.nearbyMosque.isNotEmpty ? 5 : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final item = place.nearbyMosque[index];

                      return GestureDetector(
                        onTap: () {
                          var homecontroller = Get.find<HomeController>();
                          homecontroller.placeDetail(item.placeId.toString());

                          Get.toNamed(RouteHelper.getHomeDetailPage(
                              item.placeId.toString(),
                              item.name,
                              'homePage',
                              'mosque'));
                        },
                        child: RekomendasiCard(
                          name: item.name,
                          city: item.vicinity,
                          imgUrl: item.photos != null
                              ? '${AppConstans.PLACE_PHOTO}${item.photos.first.photoReference}'
                              : 'none',
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
