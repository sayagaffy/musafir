import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/users.dart';
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
            onTap: () {
              var authController = Get.find<AuthController>();
              var homeController = Get.find<HomeController>();
              final user = authController.auth.currentUser;

              locationController.getCurrentPosition();

              var usersUpdate = {
                'address': location.address,
                'lat': location.latlng!.latitude.toString(),
                'long': location.latlng!.longitude.toString()
              };

              DbUsers()
                  .updateUserData(user!.email.toString(), usersUpdate)
                  .then((value) {
                showCustomSnackBar(
                  isError: false,
                  'Berhasil Mengubah Lokasi',
                  title: 'Succsess',
                  backgroundColor: kGreenHover,
                );
                String latlang =
                    '${usersUpdate['lat'].toString()},${usersUpdate['lang'].toString()}';

                homeController.refreshNearbyPlace(latlang);

                Get.toNamed(RouteHelper.getInitial());
              });
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
