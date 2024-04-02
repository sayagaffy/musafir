import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/tile_card.dart';

class ListKategory extends StatefulWidget {
  const ListKategory({super.key});

  @override
  State<ListKategory> createState() => _ListKategoryState();
}

class _ListKategoryState extends State<ListKategory> {
  String? latlang;
  var homeC = Get.find<HomeController>();
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var locationController = Get.find<LocationController>();
    UserStore().getUserDetail().then((value) {
      setState(() {
        latlang = value['lat'] != null
            ? '${value['lat']},${value['long']}'
            : locationController.latlng.toString();
      });
    });
  }

  List kategoryList = [
    {
      'title': 'Algerian',
      'imgUrl': 'assets/Algerian.png',
      'keyword': 'algerian+food'
    },
    {
      'title': 'Indian',
      'imgUrl': 'assets/Indian.png',
      'keyword': 'indian+food'
    },
    {
      'title': 'Japanese',
      'imgUrl': 'assets/Japanse.png',
      'keyword': 'japanese+food'
    },
    {
      'title': 'Korean',
      'imgUrl': 'assets/Indian.png',
      'keyword': 'assets/Korean.png'
    },
    {
      'title': 'Middle East',
      'imgUrl': 'assets/Midleeast.png',
      'keyword': 'middle+east+food'
    },
    {
      'title': 'Western',
      'imgUrl': 'assets/Western.png',
      'keyword': 'western+food'
    },
    {'title': 'Malay', 'imgUrl': 'assets/Malay.png', 'keyword': 'malay+food'},
    {'title': 'Thai', 'imgUrl': 'assets/Thai.png', 'keyword': 'thai+food'},
    {
      'title': 'Turkish',
      'imgUrl': 'assets/Turkish.png',
      'keyword': 'turkish+food'
    },
    {
      'title': 'Bakery',
      'imgUrl': 'assets/Bakery.png',
      'keyword': 'bakery+food'
    },
  ];

  Widget header() {
    return SafeArea(
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                top: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        homeC.clearSearchPlace();
                        Get.back();
                      },
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getHomeSearchPage());
                      },
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kNeutral20,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Cari resto atau ruang shalat di Musafir',
                              style: greyTextStyle.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 18,
              right: 18,
            ),
            child: Text(
              'Kategori',
              style: blackTextStyle.copyWith(
                height: 1.5,
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 18, right: 5),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 124,
                  mainAxisExtent: 124,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 15,
                ),
                itemCount: kategoryList.length,
                itemBuilder: (BuildContext ctx, index) {
                  final item = kategoryList[index];
                  return GestureDetector(
                    onTap: () {
                      var homeC = Get.find<HomeController>();
                      homeC.getNearbyPlace(
                        keyword: item['keyword'],
                        rankby: 'distance',
                        type: 'food',
                        location: latlang,
                      );
                      Get.toNamed(
                        RouteHelper.getHomeListPage(
                          'filterList_food',
                          item['title'],
                        ),
                      );
                    },
                    child: TileCard(
                      title: item['title'],
                      imgUrl: item['imgUrl'],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
