import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/home/widgets/current_location.dart';
import 'package:musafir/ui/widgets/location_list_tile.dart';

class SetLoaction extends StatefulWidget {
  const SetLoaction({super.key});

  @override
  State<SetLoaction> createState() => _SetLoactionState();
}

class _SetLoactionState extends State<SetLoaction> {
  var locationController = Get.find<LocationController>();

  void refreshNearbyPlace() {
    var homeController = Get.find<HomeController>();

    String latLang =
        '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}';

    homeController.getNearbyPlace(
      keyword: 'food',
      rankby: 'distance',
      type: 'restaurant',
      location: latLang,
    );

    homeController.getNearbyPlace(
      keyword: 'masjid',
      rankby: 'distance',
      type: 'mosque',
      location: latLang,
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 18,
        top: 20,
        bottom: 20,
        right: 18,
      ),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(105, 120, 127, 132),
            width: 0.8,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    refreshNearbyPlace();
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
                      hintText: 'Cari Lokasi disini,',
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
        ],
      ),
    );
  }

  Widget currentList() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(105, 120, 127, 132),
            width: 0.8,
          ),
        ),
      ),
      child: const CurrentLocation(),
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
                      press: () {
                        place.getGeoCodeAddress(
                            place.getPlaces[index].description);

                        showCustomSnackBar(
                          isError: false,
                          'Berhasil Mengubah Lokasi',
                          title: 'Succsess',
                          backgroundColor: kGreenHover,
                        );
                      },
                      location: place.getPlaces[index].description,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Perbaharui Lokasimu',
                      style: greyTextStyle.copyWith(fontSize: 12),
                    ),
                  );
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(),
          currentList(),
          listDataSearch(),
        ],
      ),
    );
  }
}
