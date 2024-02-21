import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/shared/theme.dart';

class DropdownLocation2 extends StatefulWidget {
  const DropdownLocation2({
    super.key,
  });

  @override
  State<DropdownLocation2> createState() => _DropdownLocationState();
}

class _DropdownLocationState extends State<DropdownLocation2> {
  List categoryItemlist = [];
  var googleController = Get.find<GoogleController>();

  String? sel;
  @override
  void initState() {
    super.initState();

    // if (googleController.geoCode.isEmpty) {
    //   return;
    // } else {
    //   var jsonData = googleController.geoCode;

    //   setState(() {
    //     categoryItemlist = jsonData;

    //     print(categoryItemlist[0].formattedAddress);
    //   });
    // }

    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: kPrimarySurface,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 30,
      child: DropdownButton(
        isExpanded: true,
        hint: Text('hooseNumber'),
        itemHeight: 48,
        value: sel,
        icon: Icon(
          Icons.expand_more,
          color: kBlackColor,
          size: 17,
        ),
        style: blackTextStyle.copyWith(
          fontSize: 12,
          color: kBlackColor,
          fontWeight: bold,
        ),
        items: categoryItemlist.map((item) {
          return DropdownMenuItem(
            value: item.formattedAddress.toString(),
            child: Text(
              item.formattedAddress.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            sel = newValue;
            // widget.valueReturned(newValue!);
          });
        },
        underline: const SizedBox(),
        dropdownColor: kWhiteColor,
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    print(permission);
    print(serviceEnabled);
    print(await Geolocator.getCurrentPosition());
    return await Geolocator.getCurrentPosition();
  }
}
