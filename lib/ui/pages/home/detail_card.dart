import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/location_text.dart';
import 'package:musafir/utilitis/apps_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailCard extends StatefulWidget {
  final String pageId;
  final String page;
  final String from;
  final String type;

  const DetailCard({
    super.key,
    required this.pageId,
    required this.page,
    required this.from,
    required this.type,
  });

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  bool statusBookmark = false;
  String addressCom = '';
  String? latlang;
  final locationC = Get.find<LocationController>();
  @override
  void initState() {
    super.initState();
    getData();

    // WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction());
  }

  void getData() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        latlang = value['lat'] != null
            ? '${value['lat']},${value['long']}'
            : locationC.latlng.toString();
      });
    });
  }

  void addressComponent(home) {
    var area4 = '';
    var area2 = '';
    var area3 = '';

    for (var i in home.placeDtl.addressComponents) {
      if (i.types.first == "administrative_area_level_2") {
        area2 = i.longName;
      }
      if (i.types.first == "administrative_area_level_3") {
        area3 = i.longName;
      }
      if (i.types.first == "administrative_area_level_4") {
        area4 = i.longName;
      }
    }

    addressCom = '$area4, $area3, $area2';

    // ignore: avoid_print
    print(addressCom);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bookmark() {
    dynamic checkBookmark = UserStore().checkBookmark(widget.pageId);
    bool data = false;
    return FutureBuilder(
      future: checkBookmark,
      builder: ((context, snapshot) {
        checkBookmark.then((value) {
          data = value;
        });

        if (snapshot.connectionState == ConnectionState.done) {
          if (data) {
            return Icon(
              statusBookmark
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_add_rounded,
              size: 30,
              color: kBlueColor,
            );
          }
        }
        return Icon(
          Icons.bookmark_rounded,
          size: 30,
          color: kWhiteColor,
        );
      }),
    );
  }

  Widget backgroundImage(BuildContext context, home) {
    addressComponent(home);
    return Stack(
      children: [
        Container(
          height: 245,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(.1),
                Colors.black.withOpacity(.8),
              ],
            ),
          ),
          decoration: home.placeDtl.photos != null
              ? BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${AppConstans.PLACE_PHOTO}${home.placeDtl.photos.first.photoReference}',
                    ),
                  ),
                )
              : const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  ),
                ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          margin: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.from == 'homePage') {
                    Get.toNamed(RouteHelper.getInitial());
                  } else if (widget.from == 'filterList_resto' ||
                      widget.from == 'filterList_mosque') {
                    Get.toNamed(
                        RouteHelper.getHomeListPage(widget.from, 'none'));
                  } else if (widget.from == 'homePage_search') {
                    Get.toNamed(RouteHelper.getHomeSearchPage('detail'));
                  } else if (widget.from == 'favorite') {
                    Get.toNamed(RouteHelper.getInitial());
                  }
                },
                // onTap: onTap,

                child: Icon(
                  Icons.keyboard_backspace_rounded,
                  size: 35,
                  color: kWhiteColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _dialogBuilder(context);
                },
                child: Icon(
                  Icons.more_horiz,
                  size: 35,
                  color: kWhiteColor,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 18,
          ),
          margin: const EdgeInsets.only(
            top: 150,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      home.placeDtl.name ?? widget.page,
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 20,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: home.placeDtl.types.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            '${home.placeDtl.types[index]}, ',
                            style: whiteTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String latlng =
                      '${home.placeDtl.geometry.location.lat},${home.placeDtl.geometry.location.lng}';
                  String photo =
                      '${home.placeDtl.photos != null ? home.placeDtl.photos.first.photoReference : 'none'}';

                  UserStore().bookmarkPlace(widget.pageId, latlng, widget.page,
                      widget.from, addressCom, 'frendly', widget.type, photo);

                  UserStore().checkBookmark(widget.pageId).then((value) => {
                        setState(() {
                          statusBookmark = value;
                        })
                      });
                },
                child: bookmark(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tileReview(home) {
    return Container(
      height: 67,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        color: kNeutral20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            width: 92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: home.placeDtl.rating ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 1,
                      itemSize: 16,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                      ignoreGestures: true,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      home.placeDtl.rating != null
                          ? home.placeDtl.rating.toString()
                          : '0',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      home.placeDtl.userRatingsTotal != null
                          ? '${home.placeDtl.userRatingsTotal.toString()} ulasan'
                          : 'belum ada rating',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            width: 92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.place,
                      size: 18,
                      color: kRedMain,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    GetLocationText(
                        origin: latlang ?? latlang.toString(),
                        destination:
                            '${home.placeDtl.geometry.location.lat},${home.placeDtl.geometry.location.lng}'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Jarak',
                    style: blackTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            width: 92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                home.placeDtl.priceLevel != null
                    ? Stack(
                        children: List.generate(
                          home.placeDtl.priceLevel ?? 0,
                          (index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: index.toDouble() * 10),
                              child: Icon(
                                Icons.attach_money_rounded,
                                size: 15,
                                color: kBlueColor,
                              ),
                            );
                          },
                        ),
                      )
                    : Text(
                        'Uknown',
                        style: blackTextStyle.copyWith(fontSize: 10),
                      ),
              ],
            ),
          ),
          SizedBox(
            width: 92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage(
                        "assets/icon_prayer.png",
                      ),
                      size: 18,
                      color: kWarningMain,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Prayer Space',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget content(home) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 23),
      margin: const EdgeInsets.only(top: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kehalalan',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              height: 1.5,
              fontWeight: bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kSuccessSurface,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(
                    right: 4,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon_halal.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halal Certified',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          height: 1.4,
                          color: kSuccessHover,
                        ),
                      ),
                      Text(
                        'Update terakhir: 21 Januari 2024',
                        style: blackTextStyle.copyWith(fontSize: 10),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.info_rounded,
                  size: 20,
                  color: kBlackColor,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Alamat',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              height: 1.5,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            home.placeDtl.formattedAddress,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget mapLocation(home) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Marker> _markers = <Marker>[
      Marker(
        markerId: const MarkerId('SomeId'),
        position: LatLng(home.placeDtl.geometry.location.lat,
            home.placeDtl.geometry.location.lng),
        infoWindow: InfoWindow(title: '${home.placeDtl.name}'),
        icon: BitmapDescriptor.defaultMarker,
      )
    ];

    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 30,
      ),
      width: double.infinity,
      height: 188,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image_map.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: GoogleMap(
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(home.placeDtl.geometry.location.lat,
              home.placeDtl.geometry.location.lng),
          zoom: 16,
        ),
        markers: Set<Marker>.of(_markers),
      ),
    );
  }

  Widget titleRekomendasi(home) {
    return home.placeDtl.photos != null
        ? Container(
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            padding: const EdgeInsets.only(left: 25, right: 23),
            child: Text(
              'Foto',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                height: 1.5,
                fontWeight: bold,
              ),
            ),
          )
        : const SizedBox();
  }

  Widget foto(home) {
    return home.placeDtl.photos != null
        ? Container(
            padding: const EdgeInsets.only(left: 25),
            width: double.infinity,
            child: SizedBox(
                height: 121,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 92,
                      height: 121,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF5F5F5),
                        image: home.placeDtl.photos == null
                            ? const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/image_destination1.png'),
                              )
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${AppConstans.PLACE_PHOTO}${home.placeDtl.photos[index].photoReference}'),
                              ),
                      ),
                    );
                  },
                )),
          )
        : const SizedBox();
  }

  Widget rating(home) {
    dynamic checkReview = UserStore().checkUserReview(widget.pageId);
    dynamic data;

    return FutureBuilder(
      future: checkReview,
      builder: ((context, snapshot) {
        checkReview.then((value) => data = value);
        if (snapshot.connectionState == ConnectionState.done) {
          if (data != null) {
            return const SizedBox();
          }
        }
        return Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          margin: const EdgeInsets.only(top: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beri rating dan ulasan',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: kNeutral40,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 31,
                      width: 31,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/image_destination1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        String latlng =
                            '${home.placeDtl.geometry.location.lat},${home.placeDtl.geometry.location.lng}';
                        Get.toNamed(RouteHelper.getHomeReview(
                            widget.pageId, widget.page, latlng, widget.from));
                      },
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        unratedColor: kNeutral40,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget ulasan1(home) {
    dynamic checkReview = UserStore().checkUserReview(widget.pageId);
    dynamic data;

    return FutureBuilder(
        future: checkReview,
        builder: (context, snapshot) {
          checkReview.then((value) => data = value);
          if (snapshot.connectionState == ConnectionState.done) {
            if (data != null) {
              return SizedBox(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 18,
                        bottom: 11,
                      ),
                      child: Column(
                        children: [
                          Divider(
                            height: 0.5,
                            color: kNeutral40,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 31,
                                width: 31,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data['profile_photo_url'] == 'none'
                                          ? 'https://lh3.googleusercontent.com/a-/AOh14GhGGmTmvtD34HiRgwHdXVJUTzVbxpsk5_JnNKM5MA=s128-c0x00000000-cc-rp-mo'
                                          : data['profile_photo_url'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                data['author_name'],
                                style: blackTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                              ignoreGestures: true,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              DateFormat('dd-MMM-yyy hh:mm')
                                  .format(data['creatAt'].toDate())
                                  .toString(),
                              style: blackTextStyle.copyWith(fontSize: 11),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            data['text'],
                            style: blackTextStyle.copyWith(fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }

          return const SizedBox();
        });
  }

  Widget ulasan(home) {
    return home.placeDtl.reviews != null
        ? Container(
            padding: const EdgeInsets.only(
              left: 25,
              right: 23,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ulasan',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: home.placeDtl.rating ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                      ignoreGestures: true,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      home.placeDtl.rating.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'dari ${home.placeDtl.userRatingsTotal.toString()} rating',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Icon(
                      Icons.fiber_manual_record,
                      size: 10,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      '${home.placeDtl.userRatingsTotal.toString()} ulasan',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ulasan1(home),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 120,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: home.placeDtl.reviews.length >= 4
                        ? 4
                        : home.placeDtl.reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      var date = DateTime.fromMillisecondsSinceEpoch(
                          home.placeDtl.reviews[index].time * 1000);

                      String dtFormat =
                          DateFormat('dd-MMM-yyy hh:mm').format(date);

                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 18,
                              bottom: 11,
                            ),
                            child: Column(
                              children: [
                                Divider(
                                  height: 0.5,
                                  color: kNeutral40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 31,
                                      width: 31,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${home.placeDtl.reviews[index].profilePhotoUrl}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      home.placeDtl.reviews[index].authorName,
                                      style: blackTextStyle.copyWith(
                                        fontWeight: bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    initialRating:
                                        home.placeDtl.reviews[index].rating ??
                                            0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                    ignoreGestures: true,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    dtFormat,
                                    style:
                                        blackTextStyle.copyWith(fontSize: 11),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  home.placeDtl.reviews[index].text,
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: kNeutral40,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: kNeutral40,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Lihat Semua Ulasan',
                      style: noColorTextStyle.copyWith(
                          color: kBlueColor, fontSize: 14, fontWeight: bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GetBuilder<HomeController>(builder: (home) {
        return home.loading
            ? Skeletonizer(
                enabled: home.placeDtl.name == null,
                child: ListView(children: [
                  backgroundImage(context, home),
                  tileReview(home),
                  content(home),
                  mapLocation(home),
                  titleRekomendasi(home),
                  foto(home),
                  rating(home),
                  ulasan(home),
                ]),
              )
            : const SizedBox();
      }),
    );
  }

  Future<void> _reportBuilder(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          decoration: BoxDecoration(
            color: kWhiteColor,
          ),
          width: double.infinity,
          child: (Column(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 45,
                color: kBlueColor,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Terima kasih telah memberi tahu kami',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: extraBold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Kami menggunakan laporan ini untuk memberikan informasi yang terbaru dan tepat di masa mendatang.',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButton(
                title: 'Tutup',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )),
        );
      },
    );
  }

  Future<void> _showReportBuilder(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // This attribute will auto scale size of Column widget when the keyboard showed
            ),
            child: SizedBox(
              height: 320,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apa yang ingin Anda laporkan?',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: extraBold,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 230,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _reportBuilder(context);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Restoran sudah tutup',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Color(0xFFF3F3F3),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _reportBuilder(context);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Restoran Tidak Halal',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Color(0xFFF3F3F3),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lainnya',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      hintText: 'Tulis disini',
                                      isDense: true, // Added this
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 339,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _showReportBuilder(context);
                  },
                  child: Text(
                    'Laporkan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                      color: kRedColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 339,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Batalkan',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
