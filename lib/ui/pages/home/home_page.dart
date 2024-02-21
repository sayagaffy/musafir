import 'package:get/get.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:musafir/ui/widgets/custom_search_button.dart';
import 'package:musafir/ui/widgets/custom_title.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/rekomendasi_title.dart';
import 'package:musafir/ui/widgets/tile_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          }),
    );
  }

  Widget rekomendasi(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getHomeDetailPage(
                    01, 'Shinju Ramen', 'homePage'));
              },
              child: const RekomendasiCard(
                name: 'Shinju Ramen',
                city: 'Tokyo, Jepang',
                imgUrl: 'assets/image_destination1.png',
                rating: 4.7,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getHomeDetailPage(
                    02, 'Burger Boss', 'homePage'));
              },
              child: const RekomendasiCard(
                name: 'Burger Boss',
                city: 'Nagasaki, Jepang',
                imgUrl: 'assets/image_destination2.png',
                rating: 4.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getHomeDetailPage(
                    03, 'The Halal Guys', 'homePage'));
              },
              child: const RekomendasiCard(
                name: 'The Halal Guys',
                city: 'Jakarta, Indonesia',
                imgUrl: 'assets/image_destination3.png',
                rating: 4.8,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getHomeDetailPage(
                    04, 'Pecel Gairah Malam', 'homePage'));
              },
              child: const RekomendasiCard(
                name: 'Pecel Gairah Malam',
                city: 'Tebet, Jakarta',
                imgUrl: 'assets/image_destination4.png',
                rating: 5.0,
              ),
            ),
          ],
        ),
      ),
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
      child: const CustomTitle(title: 'Masjid Tedekat'),
    );
  }

  Widget rekomendasiMasjid() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin, bottom: 50),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            RekomendasiCard(
              name: 'Al-Azhar',
              city: 'Kota Jakarta Selatan',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
              isMasjid: true,
            ),
            RekomendasiCard(
              name: 'Masjid Besar Al-ihsan',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
              isMasjid: true,
            ),
            RekomendasiCard(
              name: 'Ar-Rahman',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
              isMasjid: true,
            ),
            RekomendasiCard(
              name: 'Al-irsyad Satya',
              city: 'Tebet, Bandung',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
              isMasjid: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(),
          titleRekomendasi(),
          rekomendasi(context),
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
