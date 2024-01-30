import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/models/autocomplate_prediction.dart';
import 'package:musafir/ui/models/place_auto_complate_response.dart';
import 'package:musafir/ui/widgets/custom_title.dart';
import 'package:musafir/ui/widgets/location_list_tile.dart';
import 'package:musafir/ui/widgets/network_ultility.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/tile_tags_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Debouncer debouncer = Debouncer(duration: const Duration(seconds: 1));
  List<AutocompletePrediction> placePredictions = [];

  void placeAutoComplate(String query) async {
    debouncer.run(() async {
      Uri uri =
          Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
        "input": query, // query Parameters
        "key": "AIzaSyBe_89LiN8WdHYk5mPcmAey5ZyheaskwE0", //Google api key
      });

      String? response = await NetworkUltility.fetchUrl(uri);

      if (response != null) {
        PlaceAutocompleteResponse result =
            PlaceAutocompleteResponse.parseAutoComplateResult(response);
        if (result.predictions != null) {
          setState(() {
            placePredictions = result.predictions!;
          });
        }
      }
    });

    //its time to GET request
  }

  Widget header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 25,
        top: 25,
        bottom: 25,
        right: 19,
      ),
      decoration: BoxDecoration(color: kBackgroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
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
                  placeAutoComplate(value);
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
                    Icons.search,
                    size: 20,
                  ),
                  hintText: 'Cari di musafir,',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     //call the function
          //     placeAutoComplate('kabanjahe');
          //   },
          //   icon: const Icon(Icons.location_pin),
          //   tooltip: 'Use Current Location',
          // ),
        ],
      ),
    );
  }

  Widget listDataSearch() {
    return placePredictions.isNotEmpty
        ? Container(
            margin: const EdgeInsets.only(
              bottom: 30,
            ),
            padding: const EdgeInsets.only(
              left: 25,
              right: 19,
            ),
            child: Column(
              children: [
                const Divider(
                  height: 2,
                  thickness: 1,
                  color: Color.fromARGB(105, 120, 127, 132),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: ListView.builder(
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) => LocationListTile(
                      press: () {},
                      location: placePredictions[index].description!,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox(
            width: 2,
          );
  }

  Widget titleKategori() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
      ),
      child: const CustomTitle(title: 'Kategori Makanan'),
    );
  }

  Widget tags() {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        top: 15,
        bottom: 30,
        right: 19,
      ),
      child: const Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          TileTagsSearch(title: 'Korean'),
          TileTagsSearch(title: 'Japanise'),
          TileTagsSearch(title: 'Middle East'),
          TileTagsSearch(title: 'Chinese'),
          TileTagsSearch(title: 'Indonesia'),
          TileTagsSearch(title: 'Europe'),
        ],
      ),
    );
  }

  Widget titleRekomendasi() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
      ),
      child: const CustomTitle(title: 'Rekomendasi'),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            RekomendasiCard(
              name: 'Shinju Ramen',
              city: 'Tokyo, Jepang',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
            ),
            RekomendasiCard(
              name: 'Burger Boss',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
            ),
            RekomendasiCard(
              name: 'The Halal Guys',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
            ),
            RekomendasiCard(
              name: 'Pecel Gairah Malam',
              city: 'Tebet, Jakarta',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget titlePalingdiCari() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
        top: 30,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
      ),
      child: const CustomTitle(title: 'Paling Banyak di Cari'),
    );
  }

  Widget titleRestoTinggi() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
        top: 30,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 19,
      ),
      child: const CustomTitle(title: 'Rekomendasi Resto Rating TerAtas'),
    );
  }

  Widget rekomendasiResto() {
    return Container(
      padding: const EdgeInsets.only(left: 25, bottom: 50),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            RekomendasiCard(
              name: 'The Halal Guys',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
            ),
            RekomendasiCard(
              name: 'Pecel Gairah Malam',
              city: 'Tebet, Jakarta',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
            ),
            RekomendasiCard(
              name: 'Shinju Ramen',
              city: 'Tokyo, Jepang',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
            ),
            RekomendasiCard(
              name: 'Burger Boss',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          header(context),
          listDataSearch(),
          titleKategori(),
          tags(),
          titleRekomendasi(),
          rekomendasi(),
          titlePalingdiCari(),
          tags(),
          titleRestoTinggi(),
          rekomendasiResto(),
        ],
      ),
    );
  }
}

///delay search
class Debouncer {
  final Duration duration;
  Debouncer({required this.duration});

  Timer? _timer;

  void run(VoidCallback action) {
    bool isActive = _timer?.isActive ?? false;

    if (isActive) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }
}
