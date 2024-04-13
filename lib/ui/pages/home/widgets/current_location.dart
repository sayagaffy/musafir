import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    var locationController = Get.find<LocationController>();
    locationController.getCurrentPosition();

    return Column(
      children: [
        GetBuilder<LocationController>(builder: (location) {
          return ListTile(
            onTap: () async {
              var homeC = Get.find<HomeController>();
              await location.getCurrentPosition();

              var usersUpdate = {
                'address': location.address,
                'lat': location.latlng!.latitude.toString(),
                'long': location.latlng!.longitude.toString()
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
