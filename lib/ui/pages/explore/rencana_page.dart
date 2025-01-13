// import 'package:intl/intl.dart';
// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';

import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/textfield_datetime_pick.dart';
import 'package:musafir/ui/widgets/text_fd_custom.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class RencanaPage extends StatefulWidget {
  const RencanaPage({super.key});

  @override
  State<RencanaPage> createState() => _RencanaPageState();
}

class _RencanaPageState extends State<RencanaPage> {
  // ignore: unused_field
  GoogleSignInAccount? _currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var exploreController = Get.find<ExploreController>();
  var authController = Get.find<AuthController>();

  TextEditingController startDateTime = TextEditingController();
  TextEditingController endDateTime = TextEditingController();
  TextEditingController startFormat = TextEditingController();
  TextEditingController endFormat = TextEditingController();

  // Future addEventToCalendar(String accessToken, dynamic jsonEvent) async {
  //   final headers = {
  //     'Authorization': 'Bearer $accessToken',
  //     'Content-type': 'application/json'
  //   };

  //   print(headers);

  //   final response = await http.post(
  //     Uri.parse(
  //         'https://www.googleapis.com/calendar/v3/calendars/primary/events?sendUpdates=all'),
  //     headers: headers,
  //     body: jsonEncode(jsonEvent),
  //   );

  //   if (response.statusCode == 200) {
  //     UserStore().explorePlan(
  //       exploreController.placeIdX.value,
  //       exploreController.searchPlace.text,
  //       startDateTime.text,
  //       endDateTime.text,
  //     );

  //     startDateTime.clear();
  //     endDateTime.clear();
  //     exploreController.searchPlace.clear();
  //     exploreController.placeIdX.value = '';
  //   } else {
  //     DialogHelper.hideLoading();
  //     DialogHelper.showSnackBar("tidak Berhasil Membuat Rencana Perjalanan",
  //         title: "Gagal");
  //     print('event error ${response.statusCode}');
  //     print('response body ${response.body}');
  //   }
  // }
  void addPlace(String type) async {
    String nameplan = exploreController.namePlan.text.trim();
    String search = exploreController.searchPlace.text.trim();
    String start = exploreController.startDtTime.text.trim();
    String end = exploreController.endDtTime.text.trim();

    if (nameplan.isEmpty) {
      DialogHelper.showSnackBar('Nama Rencana Perjalanan tidak boleh kosong',
          title: 'Nama');
    } else if (search.isEmpty) {
      DialogHelper.showSnackBar(
          'Tempat Atau Tujuan Rencana Perjalanan tidak boleh kosong',
          title: 'Tujuan/Tempat');
    } else if (start.isEmpty) {
      DialogHelper.showSnackBar('Tanggal Berangkat tidak boleh kosong',
          title: 'Tanggal Berangkat');
    } else if (end.isEmpty) {
      DialogHelper.showSnackBar('Tanggal Kembali tidak boleh kosong',
          title: 'Tanggal Kembali');
    } else {
      if (type == 'resto') {
        await exploreController.getNearbyPlace(
          keyword: 'resto+food',
          rankby: 'distance',
          type: type,
          location:
              '${exploreController.latlng!.latitude.toString()}, ${exploreController.latlng!.longitude.toString()}',
        );

        Get.offNamed(RouteHelper.getSearchPlaceExplore(type));
      } else {
        await exploreController.getNearbyPlace(
          keyword: 'mosque',
          rankby: 'distance',
          type: type,
          location:
              '${exploreController.latlng!.latitude.toString()}, ${exploreController.latlng!.longitude.toString()}',
        );

        Get.offNamed(RouteHelper.getSearchPlaceExplore2(type));
      }
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> signInWithGoogle2() async {
    try {
      GoogleSignInAccount? googleSignIn = await GoogleSignIn(
        clientId:
            '335848098890-tlfac39k149ape15nr3g784u11n9svft.apps.googleusercontent.com',
        scopes: <String>[
          'https://www.googleapis.com/auth/calendar',
          'https://www.googleapis.com/auth/calendar.events',
        ],
      ).signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication? googleAuth =
          await googleSignIn?.authentication;

      // Create a new credential
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        return googleAuth?.accessToken;
      }
    } catch (e) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(
          "Tidak berhasil melakukan Sign ke akun Google anda",
          title: "Gagal");
      print(e.toString());
      return null;
    }
  }

  Future<void> _posting() async {
    DialogHelper.showLoading('Posting Rencana Perjalanan');
    String tujuan = exploreController.searchPlace.text.trim();
    String nameplan = exploreController.namePlan.text.trim();
    String startdtTime = exploreController.startDtTime.text.trim();
    String enddtTime = exploreController.endDtTime.text.trim();

    if (tujuan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tujuanmu",
          title: "Tujuanmu");
    } else if (nameplan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum mengisi nama perjalananmu ",
          title: "Nama perjalanan");
    } else if (startdtTime.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Berangkat",
          title: "Tanggal Berangkat");
    } else if (enddtTime.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Kembali",
          title: "Tanggal Kembali");
    } else {
      // final jsonEvent = {
      //   'summary': 'Rencana Perjalanan',
      //   'description':
      //       'Berpergian ke $tujuan  pada tanggal ${startDateTime.text} dan kembali pada saat ${endDateTime.text}.',
      //   'start': {
      //     'dateTime': DateTime.parse(startFormat.text).toUtc().toIso8601String()
      //   },
      //   'end': {
      //     'dateTime': DateTime.parse(endFormat.text).toUtc().toIso8601String()
      //   },
      //   "location": tujuan,
      //   // "place_id": exploreController.placeIdX.value,
      // };
      String? token = authController.tokenGoogle;

      if (token != null) {
        // await addEventToCalendar(token, jsonEvent);
      }
    }
  }

  Future<void> _posting2() async {
    String tujuan = exploreController.searchPlace.text.trim();
    String nameplan = exploreController.namePlan.text.trim();
    String startdtTime = exploreController.startDtTime.text.trim();
    String enddtTime = exploreController.endDtTime.text.trim();

    if (tujuan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tujuanmu",
          title: "Tujuanmu");
    } else if (nameplan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum mengisi nama perjalananmu ",
          title: "Nama perjalanan");
    } else if (startdtTime.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Berangkat",
          title: "Tanggal Berangkat");
    } else if (enddtTime.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Kembali",
          title: "Tanggal Kembali");
    } else {
      DialogHelper.showLoading('Posting Rencana Perjalanan');

      await UserStore().explorePlan(
        exploreController.placeIdX.value,
        exploreController.searchPlace.text,
        exploreController.startDtTime.text,
        exploreController.endDtTime.text,
        exploreController.namePlan.text,
        exploreController.selectedFood,
        exploreController.selectedMosque,
        exploreController.latlng!.latitude,
        exploreController.latlng!.longitude,
      );
    }
  }

  Widget header(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 21,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 18,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.offNamed(RouteHelper.getInitial());
              // Navigator.of(context).pop();
              // Get.back();
            },
            icon: const Icon(Icons.keyboard_backspace_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Rencana Perjalanan',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: extraBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget contentPlan(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          top: 34,
        ),
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFdCustom(
              textController: exploreController.searchPlace,
              labelText: 'Ketik Tujuanmu',
              icon: Icons.search_rounded,
              onTap: () {
                Get.offNamed(RouteHelper.getExploreSearch());
              },
              readOnly: true,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFdCustom(
              textController: exploreController.namePlan,
              labelText: 'Nama Rencana Perjalanan',
              icon: Icons.store,
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextfieldDatetimePick(
              textController: exploreController.startDtTime,
              labelText: 'Tanggal Berangkat',
              textdatetime: startFormat,
            ),
            const SizedBox(
              height: 20,
            ),
            TextfieldDatetimePick(
              textController: exploreController.endDtTime,
              labelText: 'Tanggal Kembali',
              textdatetime: endFormat,
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Restoran Tujuan ${exploreController.selectedFood.length}',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          addPlace('resto');
                        },
                        child: Text(
                          'Tambahkan lainnya',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                            color: kBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                exploreController.selectedFood.isNotEmpty
                    ? SizedBox(
                        height: exploreController.selectedFood.length == 1
                            ? 80
                            : 200,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    exploreController.selectedFood.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: contactItem(
                                      exploreController.selectedFood[index]
                                          ['title'],
                                      exploreController.selectedFood[index]
                                          ['address'],
                                      exploreController.selectedFood[index]
                                          ['halalStatus'],
                                      exploreController.selectedFood[index]
                                          ['jarak'],
                                      exploreController.selectedFood[index]
                                          ['photos'],
                                      exploreController.selectedFood[index]
                                          ['place_id'],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          addPlace('resto');
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kNeutral40,
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Masjid / Ruang Sholat ${exploreController.selectedMosque.length}',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          addPlace('mosque');
                        },
                        child: Text(
                          'Tambahkan lainnya',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                            color: kBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                exploreController.selectedMosque.isNotEmpty
                    ? SizedBox(
                        height: exploreController.selectedMosque.length == 1
                            ? 80
                            : 200,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    exploreController.selectedMosque.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: contactItem2(
                                      exploreController.selectedMosque[index]
                                          ['title'],
                                      exploreController.selectedMosque[index]
                                          ['address'],
                                      exploreController.selectedMosque[index]
                                          ['jarak'],
                                      exploreController.selectedMosque[index]
                                          ['photos'],
                                      exploreController.selectedMosque[index]
                                          ['place_id'],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          addPlace('mosque');
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kNeutral40,
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
              ],
            ),
            CustomButton(
              title: 'Buat Perjalanan',
              onPressed: () {
                _posting2();
              },
              margin: const EdgeInsets.only(top: 57),
            )
          ],
        ));
  }

  Widget line() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 42, bottom: 26),
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  Widget contactItem(String title, String address, String halalStatus,
      String destination, String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(
                    right: 3,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(halalStatus == '1'
                          ? 'assets/icon_halal.png'
                          : halalStatus == '2'
                              ? 'assets/icon_halal_blue.png'
                              : 'assets/icon_halal_black.png'),
                    ),
                  ),
                ),
                Text(
                  halalStatus == '1'
                      ? 'Halal Certified'
                      : halalStatus == '2'
                          ? 'Halal Friendly'
                          : 'Halal',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                    color: halalStatus == '1'
                        ? kGreenHover
                        : halalStatus == '2'
                            ? kBlueColorHover
                            : kBlackColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget contactItem2(String title, String address, String destination,
      String photos, String placeId) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(context),
          contentPlan(context),
          line(),
        ],
      ),
    );
  }
}
