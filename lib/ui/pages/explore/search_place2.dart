import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/rekomendasi_title.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchPlace2 extends StatefulWidget {
  final String type;
  const SearchPlace2({super.key, required this.type});

  @override
  State<SearchPlace2> createState() => _SearchPlace2State();
}

class _SearchPlace2State extends State<SearchPlace2> {
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

    var check = expC.selectedMosque.where((x) => x['place_id'] == placeId);

    if (check.isNotEmpty) {
      status = true;
    } else {
      status = false;
    }

    return status;
  }

  void getPlacesData() async {
    if (expC.nearbyMosque.isNotEmpty) {
      for (var i in expC.nearbyMosque) {
        // Check if i is a Map (from Firebase) or NearbyPlaceModel (from Google API)
        bool isMap = i is Map;

        String placeId = isMap ? i['place_id'] : i.placeId;
        String name = isMap ? i['name'] : i.name;
        String vicinity = isMap
            ? (i['formatted_address'] ?? i['address'] ?? '')
            : (i.vicinity ?? '');

        // Get location coordinates
        String lat, lng;
        if (isMap) {
          var latValue = i['geometry']?['location']?['lat'];
          var lngValue = i['geometry']?['location']?['lng'];

          // Handle different types
          if (latValue is String) {
            lat = latValue;
          } else {
            lat = (latValue?.toString() ?? '0.0');
          }

          if (lngValue is String) {
            lng = lngValue;
          } else {
            lng = (lngValue?.toString() ?? '0.0');
          }
        } else {
          lat = i.geometry?.location?.lat?.toString() ?? '0.0';
          lng = i.geometry?.location?.lng?.toString() ?? '0.0';
        }

        var destination = '${homeC.filterDot(lat)},${homeC.filterDot(lng)}';

        await homeC
            .distance('${expC.latlng!.latitude}, ${expC.latlng!.longitude}',
                destination)
            .then((value) async {
          // Get photo reference
          String photos = 'none';
          if (isMap) {
            if (i['photos'] != null && i['photos'].isNotEmpty) {
              photos = i['photos'][0]['photo_reference'] ?? 'none';
            }
          } else {
            if (i.photos != null && i.photos.isNotEmpty) {
              photos = i.photos.first.photoReference ?? 'none';
            }
          }

          Map<String, dynamic> newdata = {
            "place_id": placeId,
            'title': name,
            'address': vicinity,
            'jarak': value.replaceAll('km', ''),
            'selected': await check(placeId),
            'photos': photos,
            'halal_status': isMap
                ? (i['halal_status'] is String
                    ? i['halal_status']
                    : (i['halal_status']?.toString() ?? '0'))
                : (i.halal_status?.toString() ?? '0'),
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
                title: 'Rekomendasi Masjid Terdekat',
                onTap: () {
                  // Get.offNamed(
                  //     RouteHelper.getHomeListPage('filterList_mosque', 'none'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bxButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20, top: 20),
      child: SizedBox(
        child: CustomButton(
            title: 'Update Masjid',
            onPressed: () {
              var textStatus = widget.type == 'edit' ? 'update' : 'menambahkan';
              DialogHelper.showSnackBar(
                "Berhasil  $textStatus Masjid yang di kunjungi",
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
      String destination, String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
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
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: Colors.green[700],
              )
            : const Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
        onTap: () {
          setState(() {
            placesData[index]['selected'] = !placesData[index]['selected'];

            if (placesData[index]['selected'] == true) {
              expC.selectedMosque.add({
                'place_id': placeId,
                'title': title,
                'address': address,
                'selected': true,
                'jarak': destination,
                'photos': photos,
              });
            } else if (placesData[index]['selected'] == false) {
              expC.selectedMosque.removeWhere(
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
            Expanded(
              child: ListView.builder(
                itemCount: placesData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      left: 18,
                      right: 18,
                    ),
                    child: contactItem(
                      placesData[index]['title'],
                      placesData[index]['address'],
                      placesData[index]['selected'],
                      index,
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
