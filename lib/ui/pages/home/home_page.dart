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
import 'package:musafir/ui/widgets/skeleton_card_rekomendasi.dart';
import 'package:musafir/ui/widgets/skeleton_text.dart';
import 'package:musafir/ui/widgets/tile_card.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? address;
  String? latlang;
  final locationC = Get.find<LocationController>();
  final homeC = Get.find<HomeController>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        name = value['firstName'] ?? value['username'];
        address = value['address'] ?? 'none';
        latlang = value['lat'] != null
            ? '${value['lat']},${value['long']}'
            : locationC.latlng.toString();
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
                      name != null
                          ? Text(
                              'Assalamualaikum $name',
                              style: blackTextStyle.copyWith(
                                fontWeight: extraBold,
                                fontSize: 20,
                                height: 0.7,
                                color: kBlueColorHover,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          : const SkeletonText(
                              size: 20,
                            )
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
                  Icons.settings_power_rounded,
                  size: 20,
                  color: kBlackColor,
                ),
              ),
              // GestureDetector(
              //   onTap: () async {
              //     var homeC = Get.find<HomeController>();
              //     homeC.clearList();
              //   },
              //   child: Icon(
              //     Icons.filter,
              //     size: 20,
              //     color: kBlackColor,
              //   ),
              // )
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
                Get.toNamed(RouteHelper.getHomeSearchPage('homePage'));
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
      child: GetBuilder<HomeController>(
        builder: (place) {
          if (place.isLoadedFood) {
            return SizedBox(
              height: 206,
              width: double.infinity,
              child: place.nearbyFood.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemCount: place.nearbyFood.isNotEmpty ? 5 : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final item = place.nearbyFood[index];

                        return GestureDetector(
                          onTap: () {
                            homeC.placeDetail(item.placeId.toString());

                            Get.toNamed(RouteHelper.getHomeDetailPage(
                              item.placeId.toString(),
                              item.name,
                              'homePage',
                              'food',
                            ));
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
                      },
                    )
                  : Center(
                      child: Text(
                        'Tidak di temukan resto di sekitar anda\nperbaharui lokasi kamu',
                        style: blackTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
            );
          }

          return const SkeletonCardRekomendasi();
        },
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

  Widget titleKategoriMakanan() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: RekomendasiTitle(
        title: 'Kategori',
        onTap: () {
          Get.toNamed(RouteHelper.getHomeKategory('homePage'));
        },
      ),
    );
  }

  Widget kategoriMakanan() {
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
                homeC.getNearbyPlace(
                  keyword: 'algerian+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latlang,
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
                homeC.getNearbyPlace(
                  keyword: 'indian+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latlang,
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
                homeC.getNearbyPlace(
                  keyword: 'japan+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latlang,
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
                homeC.getNearbyPlace(
                  keyword: 'bakery+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latlang,
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
                homeC.getNearbyPlace(
                  keyword: 'korean+food',
                  rankby: 'distance',
                  type: 'food',
                  location: latlang,
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
      child: GetBuilder<HomeController>(
        builder: (place) {
          if (place.isLoadedMosque) {
            return SizedBox(
              height: 206,
              width: double.infinity,
              child: place.nearbyMosque.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemCount: place.nearbyMosque.isNotEmpty ? 5 : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final item = place.nearbyMosque[index];

                        return GestureDetector(
                          onTap: () {
                            homeC.placeDetail(item.placeId.toString());

                            Get.toNamed(RouteHelper.getHomeDetailPage(
                              item.placeId.toString(),
                              item.name,
                              'homePage',
                              'mosque',
                            ));
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
                      },
                    )
                  : Center(
                      child: Text(
                        'Tidak di temukan Masjid di sekitar anda\nperbaharui lokasi kamu',
                        style: blackTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
            );
          }
          return const SkeletonCardRekomendasi();
        },
      ),
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
