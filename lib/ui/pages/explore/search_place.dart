import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/home/utils/halal_status_util.dart';
import 'package:musafir/ui/widgets/card_recom.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/rekomendasi_title.dart';
import 'package:musafir/ui/widgets/skeleton_card_rekomendasi.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchPlace extends StatefulWidget {
  final String type;
  const SearchPlace({super.key, required this.type});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  String? latlang;
  var homeC = Get.find<HomeController>();
  var expC = Get.find<ExploreController>();
  List placesData = [];
  bool isLoad = false;
  List selectedCard = [];

  @override
  void initState() {
    getData();
    getPlacesData();
    // placesData = expC.selectedFood;
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

  Future<bool?> check(String placeId) async {
    bool status = false;
    var check = expC.selectedFood.where((x) => x['place_id'] == placeId);

    if (check.isNotEmpty) {
      status = true;
    } else {
      status = false;
    }

    return status;
  }

  void getPlacesData() async {
    if (expC.nearbyFood.isNotEmpty) {
      for (var i in expC.nearbyFood) {
        var destination =
            '${homeC.filterDot(i.geometry.location.lat.toString())},${homeC.filterDot(i.geometry.location.lng.toString())}';
        await homeC
            .distance('${expC.latlng!.latitude}, ${expC.latlng!.longitude}',
                destination)
            .then((value) async {
          Map<String, dynamic> newdata = {
            "place_id": i.placeId,
            'title': i.name,
            'address': i.vicinity,
            'jarak': value.replaceAll('km', ''),
            'selected': await check(i.placeId),
            'photos': i.photos != null ? i.photos.first.photoReference : 'none',
          };
          setState(() {
            placesData.add(newdata);
          });
        });
        setState(() {
          isLoad = true;
        });
      }
    }
  }

  Widget header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, top: 10, right: 18, bottom: 10),
      decoration: BoxDecoration(color: kBackgroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () async {
                homeC.clearSearchPlace();
                await expC.trigerUpdate();
                if (widget.type == 'edit') {
                  Get.offNamed(RouteHelper.getRencanaPageEdit());
                } else {
                  Get.offNamed(RouteHelper.getRencanaPage());
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
              child: RekomendasiTitle(
                title: 'Rekomendasi Resto Terdekat',
                onTap: () {
                  // Get.offNamed(
                  //     RouteHelper.getHomeListPage('filterList_resto', 'none'));
                },
              ),
            ),
          ),
        ],
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

  Widget titleRestoTinggi() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: RekomendasiTitle(
        title: 'Rekomendasi Resto Terdekat',
        onTap: () {
          Get.offNamed(RouteHelper.getHomeListPage('filterList_resto', 'none'));
        },
      ),
    );
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
                      final statusInfo = HalalStatusUtil.getStatusInfo(
                          int.tryParse(
                              item['halal_status']?.toString() ?? '0'));

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
                          name: item['title'] ?? '',
                          city: item['address'] ?? '',
                          imgUrl: item['image_banner'] != null
                              ? '${AppConstans.PLACE_PHOTO}${item['image_banner'].first}'
                              : 'none',
                          margin: const EdgeInsets.only(right: 0),
                          halalStatus: item['halal_status']?.toString() ?? '0',
                          destination: item['jarak']?.toString() ?? '0',
                          statusInfo: statusInfo,
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

  Widget bxButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20, top: 20),
      child: SizedBox(
        child: CustomButton(
            title: 'Update Resto',
            onPressed: () {
              var textStatus = widget.type == 'edit' ? 'update' : 'menambahkan';
              DialogHelper.showSnackBar(
                "Berhasil  $textStatus Resto yang di kunjungi",
                title: 'Successfuly',
                backgroundColor: kSuccessMain,
              );

              if (widget.type == 'edit') {
                Get.offNamed(RouteHelper.getRencanaPageEdit());
              } else {
                Get.offNamed(RouteHelper.getRencanaPage());
              }
            }),
      ),
    );
  }

  Widget contactItem(String title, String address, bool isSelected, int index,
      String halalStatus, String destination, String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      margin:
          const EdgeInsets.symmetric(vertical: 4), // Reduced vertical margin
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 4), // Reduced padding
        leading: Container(
          width: 50.0, // Reduced width
          height: 50.0, // Reduced height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                  fontWeight: bold, fontSize: 12 // Reduced font size
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2), // Reduced spacing
            Text(
              address,
              style: blackTextStyle.copyWith(fontSize: 10), // Reduced font size
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2), // Reduced padding
          child: Row(
            children: [
              Container(
                width: 14, // Reduced width
                height: 14, // Reduced height
                margin: const EdgeInsets.only(right: 3),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(halalStatus == '1'
                        ? 'assets/icon_halal.png'
                        : halalStatus == '2'
                            ? 'assets/icon_halal_blue.png'
                            : 'assets/icon_halal_black.png'),
                  ),
                ),
              ),
              Text(
                halalStatus == '1'
                    ? 'Halal Certified'
                    : halalStatus == '2'
                        ? 'Halal Friendly'
                        : 'Halal',
                style: blackTextStyle.copyWith(
                  fontSize: 10, // Reduced font size
                  fontWeight: bold,
                  color: halalStatus == '1'
                      ? kGreenHover
                      : halalStatus == '2'
                          ? kBlueColorHover
                          : kBlackColor,
                ),
              ),
              const SizedBox(width: 6), // Reduced spacing
              destination != 'none' && destination != 'ZERO_RESULTS'
                  ? Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 12, // Reduced icon size
                          color: kRedMain,
                        ),
                        Text(
                          '${destination}Km',
                          style: blackTextStyle.copyWith(
                              fontSize: 9), // Reduced font size
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: Colors.green[700],
                size: 18, // Reduced icon size
              )
            : const Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
                size: 18, // Reduced icon size
              ),
        onTap: () {
          setState(() {
            placesData[index]['selected'] = !placesData[index]['selected'];
            if (placesData[index]['selected'] == true) {
              expC.selectedFood.add({
                'place_id': placeId,
                'title': title,
                'address': address,
                'selected': true,
                'jarak': destination,
                'photos': photos,
                'halalStatus': halalStatus,
              });
            } else if (placesData[index]['selected'] == false) {
              expC.selectedFood.removeWhere(
                (element) =>
                    element['place_id'] == placesData[index]['place_id'],
              );
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(context),

            // Expanded(child: card20()),
            Expanded(
              child: ListView.builder(
                itemCount: placesData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4, // Further reduced bottom padding
                      left: 18,
                      right: 18,
                    ),
                    child: contactItem(
                      placesData[index]['title'],
                      placesData[index]['address'],
                      placesData[index]['selected'],
                      index,
                      '3',
                      placesData[index]['jarak'],
                      placesData[index]['photos'],
                      placesData[index]['place_id'],
                    ),
                  );
                },
              ),
            ),

            bxButton(),
          ],
        ),
      ),
    );
  }
}
