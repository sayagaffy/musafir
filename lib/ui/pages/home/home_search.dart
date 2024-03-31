import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_title.dart';
import 'package:musafir/ui/widgets/location_list_tile.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/tile_tags_search.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  var locationController = Get.find<LocationController>();

  Widget header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 18,
        top: 20,
        bottom: 20,
        right: 18,
      ),
      decoration: BoxDecoration(color: kBackgroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getInitial());
              },
              child: const Icon(Icons.keyboard_backspace_rounded)),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: TextFormField(
                onChanged: (value) {
                  // Get.find<GoogleController>().getPlace(value);
                  locationController.getPlace(value);
                },
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: regular,
                  color: kBlackColor,
                ),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  contentPadding: const EdgeInsets.all(10.0),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 18,
                  ),
                  hintText: 'Cari di musafir,',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listDataSearch() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          GetBuilder<LocationController>(builder: (place) {
            return place.isLoaded
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: place.getPlaces.length,
                    itemBuilder: (BuildContext context, int index) =>
                        LocationListTile(
                      press: () {},
                      location: place.getPlaces[index].description,
                    ),
                  )
                : const SizedBox();
          })
        ],
      ),
    );
  }

  Widget titleKategori() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
      ),
      child: const CustomTitle(title: 'Kategori Makanan'),
    );
  }

  Widget tags() {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
        bottom: 10,
      ),
      child: const Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          TileTagsSearch(title: 'Korean'),
          TileTagsSearch(title: 'Japanise'),
          TileTagsSearch(title: 'Middle East'),
          TileTagsSearch(title: 'Chinese'),
          TileTagsSearch(title: 'Indonesia'),
          TileTagsSearch(title: 'Europe'),
        ],
      ),
    );
  }

  Widget titleRestoTinggi() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
        top: 30,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
      ),
      child: const CustomTitle(title: 'Rekomendasi Resto Rating Teratas'),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
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
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      final sortItems = place.nearbyFood
                        ..sort((a, b) =>
                            b.userRatingsTotal.compareTo(a.userRatingsTotal));
                      final item = sortItems[index];

                      return GestureDetector(
                        onTap: () {
                          var homecontroller = Get.find<HomeController>();
                          homecontroller.placeDetail(item.placeId.toString());

                          Get.offNamed(RouteHelper.getHomeDetailPage(
                              item.placeId.toString(),
                              item.name,
                              'homePage',
                              'NONES'));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(context),
          listDataSearch(),
          titleKategori(),
          tags(),
          titleRestoTinggi(),
          rekomendasi(),
        ],
      ),
    );
  }
}
