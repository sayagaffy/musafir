import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/location_controller.dart';
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
              locationController.getCurrentPosition();
            },
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
            horizontalTitleGap: 8,
            leading: const Icon(
              Icons.my_location_rounded,
              size: 25,
            ),
            title: Text(
              'Lokasimu saat ini',
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
