import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/users.dart';
import 'package:musafir/shared/theme.dart';

class CurrentSetLocation extends StatefulWidget {
  const CurrentSetLocation({super.key});

  @override
  State<CurrentSetLocation> createState() => _CurrentSetLocationState();
}

class _CurrentSetLocationState extends State<CurrentSetLocation> {
  String? address;

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    final user = authController.auth.currentUser;

    DbUsers().getUserDetail(user!.email.toString()).then((val) {
      setState(() {
        address = val.data()['address'] ?? 'none';
      });
    });

    return Column(
      children: [
        GetBuilder<LocationController>(builder: (location) {
          return ListTile(
            onTap: () {},
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
            horizontalTitleGap: 8,
            leading: Icon(
              Icons.my_location_rounded,
              size: 25,
              color: kWarningMain,
            ),
            title: Text(
              'Lokasi yang kamu set sekarang',
              style: blackTextStyle.copyWith(
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              address ?? 'perbaharui terlebih dahulu lokasi kamu',
              style: greyTextStyle.copyWith(fontSize: 11),
              maxLines: 4,
            ),
          );
        }),
      ],
    );
  }
}
