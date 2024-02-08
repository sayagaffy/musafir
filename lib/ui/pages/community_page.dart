import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            title: 'Get Address',
            onPressed: () {
              Get.find<GoogleController>().getGeoCode();
            },
            width: 200,
          ),
          GetBuilder<GoogleController>(
            builder: (geocode) {
              return geocode.isLoaded
                  ? Container(
                      width: 200,
                      margin: EdgeInsets.all(10),
                      child: Text(geocode.geoCode[0].formattedAddress),
                    )
                  : CircularProgressIndicator(color: kRedColor);
            },
          ),
        ],
      ),
    );
  }
}
