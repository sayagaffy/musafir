import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  var locationC = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    locationC.determinePosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("WidgetsBinding");
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // print("SchedulerBinding");
    });
  }

  @override
  Widget build(BuildContext context) {
    locationC.getCurrentPosition();

    return Column(
      children: [
        GetBuilder<LocationController>(builder: (location) {
          return ListTile(
            onTap: () async {
              var homeC = Get.find<HomeController>();
              // await location.getCurrentPosition();

              var usersUpdate = {
                'address': location.address,
                'lat': location.latlng!.latitude.toString(),
                'lng': location.latlng!.longitude.toString(),
                'country_id': location.countryId,
                'province_id': location.provinceId,
                'city_id': location.cityId,
              };

              try {
                await UserStore().updateUserData(usersUpdate);

                homeC.isLoadedFood = false;
                homeC.isLoadedMosque = false;

                homeC.refreshHome();

                showCustomSnackBar(
                  isError: false,
                  'Berhasil Mengubah Lokasi',
                  title: 'Succsess',
                  backgroundColor: kGreenHover,
                );

                Get.toNamed(RouteHelper.getInitial());
              } catch (e) {
                showCustomSnackBar(e.toString());
              }
            },
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
            horizontalTitleGap: 8,
            leading: Icon(
              Icons.my_location_rounded,
              size: 25,
              color: kBlueColor,
            ),
            title: Text(
              'Lokasi perangkat kamu saat ini',
              style: blackTextStyle.copyWith(
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              location.address == "none"
                  ? 'Set your address here'
                  : location.address,
              style: greyTextStyle.copyWith(fontSize: 11),
              maxLines: 4,
            ),
          );
        }),
      ],
    );
  }
}
