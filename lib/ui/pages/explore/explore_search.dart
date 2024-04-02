import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/location_list_tile.dart';

class ExploreSearch extends StatefulWidget {
  const ExploreSearch({super.key});

  @override
  State<ExploreSearch> createState() => _ExploreSearchState();
}

class _ExploreSearchState extends State<ExploreSearch> {
  String? address;
  var locationController = Get.find<LocationController>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        address = value['address'] ?? 'none';
      });
    });
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
                    Get.back();
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
                      hintText: 'Cari tujuan kamu disini,',
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
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 18,
                            right: 18,
                          ),
                          child: Text(
                            'Pencarian Terakhir',
                            style: greyTextStyle.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: place.getPlaces.length,
                        itemBuilder: (BuildContext context, int index) =>
                            LocationListTile(
                          press: () {
                            var exploreController =
                                Get.find<ExploreController>();

                            exploreController.setTujuan(
                              place.getPlaces[index].description,
                              place.getPlaces[index].placeId,
                            );

                            Get.offNamed(RouteHelper.getRencanaPage());
                          },
                          location: place.getPlaces[index].description,
                        ),
                      ),
                    ],
                  )
                : const SizedBox();
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
          listDataSearch(),
        ],
      ),
    );
  }
}
