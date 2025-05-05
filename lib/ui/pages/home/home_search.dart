import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/list_tile_card.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/rekomendasi_title.dart';
import 'package:musafir/ui/widgets/tile_tags_search.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeSearch extends StatefulWidget {
  final String from;
  const HomeSearch({super.key, required this.from});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  String? latlang;
  var homeC = Get.find<HomeController>();
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
            ? '${value['lat']},${value['lng']}'
            : locationController.latlng.toString();
      });
    });
  }

  Widget header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, top: 20, right: 18, bottom: 20),
      decoration: BoxDecoration(color: kBackgroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                homeC.clearSearchPlace();

                if (widget.from == 'homePage') {
                  Get.toNamed(RouteHelper.initial);
                } else if (widget.from == 'filterList_resto') {
                  Get.toNamed(RouteHelper.getHomeListPage(widget.from, 'none'));
                } else if (widget.from == 'filterList_mosque') {
                  Get.toNamed(RouteHelper.getHomeListPage(widget.from, 'none'));
                } else if (widget.from == 'listKategory') {
                  Get.toNamed(RouteHelper.getHomeKategory('homeSearch'));
                } else if (widget.from == 'detail') {
                  Get.toNamed(RouteHelper.initial);
                } else if (widget.from == 'filterList_resto_place') {
                  Get.toNamed(
                      RouteHelper.getHomeListPlacePage(widget.from, 'none'));
                }
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
                  homeC.getSearchPlace(value, latlang.toString());
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
                  hintText: 'Cari resto atau ruang shalat di Musafir,',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      4,
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
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Column(
        children: [
          GetBuilder<HomeController>(builder: (place) {
            return place.isLoadedSearch
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: place.searchPlace.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = place.searchPlace[index];

                      // Check if item is a Map (from Firebase) or NearbyPlaceModel (from Google API)
                      bool isMap = item is Map;

                      String placeId = isMap ? item['place_id'] : item.placeId;
                      String name = isMap ? item['name'] : item.name;
                      String address = isMap
                          ? (item['formatted_address'] ?? '')
                          : (item.formattedAddress ?? '');
                      List<dynamic> types = isMap ? item['types'] : item.types;

                      String type = 'place';
                      if (types.contains('mosque')) {
                        type = 'mosque';
                      } else if (types.contains('food')) {
                        type = 'food';
                      }

                      // Get photo reference
                      String imgUrl = 'none';
                      if (isMap) {
                        if (item['photos'] != null &&
                            item['photos'].isNotEmpty) {
                          imgUrl = item['photos'][0]['photo_reference'];
                        }
                      } else {
                        if (item.photos != null && item.photos.isNotEmpty) {
                          imgUrl = item.photos.first.photoReference;
                        }
                      }

                      // Get location coordinates
                      double? lat, lng;
                      if (isMap) {
                        // Handle potential string values by converting to double
                        var latValue = item['geometry']?['location']?['lat'];
                        var lngValue = item['geometry']?['location']?['lng'];

                        // Convert to double if string
                        if (latValue is String) {
                          lat = double.tryParse(latValue) ?? 0.0;
                        } else {
                          lat = latValue?.toDouble() ?? 0.0;
                        }

                        if (lngValue is String) {
                          lng = double.tryParse(lngValue) ?? 0.0;
                        } else {
                          lng = lngValue?.toDouble() ?? 0.0;
                        }
                      } else {
                        lat = item.geometry?.location?.lat;
                        lng = item.geometry?.location?.lng;
                      }

                      // Get rating and price
                      double rating;
                      if (isMap) {
                        var ratingValue = item['rating'];
                        if (ratingValue is String) {
                          rating = double.tryParse(ratingValue) ?? 0.0;
                        } else {
                          rating = (ratingValue as num?)?.toDouble() ?? 0.0;
                        }
                      } else {
                        rating = item.rating ?? 0.0;
                      }

                      int price;
                      if (isMap) {
                        var priceValue = item['price_level'];
                        if (priceValue is String) {
                          price = int.tryParse(priceValue) ?? 0;
                        } else {
                          price = (priceValue as num?)?.toInt() ?? 0;
                        }
                      } else {
                        price = item.priceLevel ?? 0;
                      }

                      return GestureDetector(
                        onTap: () {
                          place.placeDetail(placeId);

                          Get.toNamed(RouteHelper.getHomeDetailPage(
                            placeId,
                            name,
                            'homePage_search',
                            type,
                          ));
                        },
                        child: ListTileCard(
                          title: name,
                          address: address,
                          placeId: placeId,
                          placeLat: lat,
                          placeLng: lng,
                          imgUrl: imgUrl,
                          rating: rating,
                          price: price,
                        ),
                      );
                    })
                : const SizedBox();
          })
        ],
      ),
    );
  }

  Widget titleKategori() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: RekomendasiTitle(
        title: 'Kategori',
        onTap: () {
          Get.toNamed(RouteHelper.getHomeKategory('homeSearch'));
        },
      ),
    );
  }

  Widget tags() {
    var homeController = Get.find<HomeController>();
    var locationController = Get.find<LocationController>();
    String latLang = latlang ??
        '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}';
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
        bottom: 10,
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          GestureDetector(
            onTap: () async {
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
            child: const TileTagsSearch(title: 'Algerian'),
          ),
          GestureDetector(
            onTap: () async {
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
            child: const TileTagsSearch(title: 'Indian'),
          ),
          GestureDetector(
            onTap: () async {
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
            child: const TileTagsSearch(title: 'Japan'),
          ),
          GestureDetector(
            onTap: () async {
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
            child: const TileTagsSearch(title: 'Bakery'),
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
            child: const TileTagsSearch(title: 'Korean'),
          ),
        ],
      ),
    );
  }

  Widget titleRestoTinggi() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: RekomendasiTitle(
        title: 'Rekomendasi Resto Rating Teratas',
        onTap: () {
          Get.toNamed(RouteHelper.getHomeListPage('filterList_resto', 'none'));
        },
      ),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
      width: double.infinity,
      child: GetBuilder<HomeController>(builder: (place) {
        return place.isLoadedFood
            ? SizedBox(
                height: 230,
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
