import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/location_list_tile.dart';

class TextfieldSearchGoogle extends StatefulWidget {
  const TextfieldSearchGoogle({super.key});

  @override
  State<TextfieldSearchGoogle> createState() => _TextfieldSearchGoogleState();
}

Widget header(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(
      left: 18,
      top: 20,
      bottom: 20,
      right: 18,
    ),
    decoration: BoxDecoration(color: kBackgroundColor),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              // Navigator.of(context).pop();
              Get.offNamed(RouteHelper.getRencanaPage());
              // Get.back();
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
                Get.find<GoogleController>().getPlace(value);
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
                hintText: 'Cari di musafir,',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  ),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget listDataSearch() {
  Get.put<GoogleController>(
    GoogleController(googleRepo: Get.find()),
    permanent: true,
  );
  return Container(
    margin: const EdgeInsets.only(
      bottom: 30,
    ),
    padding: const EdgeInsets.only(),
    child: Column(
      children: [
        const Divider(
          height: 2,
          thickness: 1,
          color: Color.fromARGB(105, 120, 127, 132),
        ),
        GetBuilder<GoogleController>(builder: (place) {
          return place.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: place.getPlaces.length,
                  itemBuilder: (BuildContext context, int index) =>
                      LocationListTile(
                    press: () {
                      var exploreController = Get.find<ExploreController>();
                      // dynamic data = jsonEncode(<String, String>{
                      //   'description': place.getPlaces[index].description,
                      //   'placeId': place.getPlaces[index].placeId,
                      // });
                      exploreController.setTujuan(
                        place.getPlaces[index].description,
                        place.getPlaces[index].placeId,
                      );

                      Get.offNamed(RouteHelper.getRencanaPage());
                    },
                    location: place.getPlaces[index].description,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Cari apa saja !!',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                );
        })
      ],
    ),
  );
}

class _TextfieldSearchGoogleState extends State<TextfieldSearchGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(context),
          listDataSearch(),
        ],
      ),
    );
  }
}
