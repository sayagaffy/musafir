// import 'package:intl/intl.dart';
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';

import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/textfield_datetime_pick.dart';
import 'package:musafir/ui/widgets/text_fd_custom.dart';
import 'package:http/http.dart' as http;

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

  TextEditingController placeTextE = TextEditingController();
  TextEditingController startDateTime = TextEditingController();
  TextEditingController endDateTime = TextEditingController();
  TextEditingController startFormat = TextEditingController();
  TextEditingController endFormat = TextEditingController();

  Future addEventToCalendar(String accessToken, dynamic jsonEvent) async {
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-type': 'application/json'
    };

    final response = await http.post(
      Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/primary/events?sendUpdates=all'),
      headers: headers,
      body: jsonEncode(jsonEvent),
    );

    if (response.statusCode == 200) {
      UserStore().explorePlan(
        exploreController.placeIdX.value,
        exploreController.searchPlace.text,
        startDateTime.text,
        endDateTime.text,
      );

      startDateTime.clear();
      endDateTime.clear();
      exploreController.searchPlace.clear();
      exploreController.placeIdX.value = '';
    } else {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar("tidak Berhasil Membuat Rencana Perjalanan",
          title: "Gagal");
      print('event error ${response.statusCode}');
      print('response body ${response.body}');
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> signInWithGoogle2() async {
    try {
      GoogleSignInAccount? googleSignIn = await GoogleSignIn(
        // clientId:
        //     '302306254082-qrdgu8iaoka6evercndmfrtld99n8ajc.apps.googleusercontent.com',
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

    if (tujuan.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tujuanmu",
          title: "Tujuanmu");
    } else if (startDateTime.text.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Berangkat",
          title: "Tanggal Berangkat");
    } else if (endDateTime.text.isEmpty) {
      DialogHelper.showSnackBar("Kamu belum memilih Tanggal Kembali",
          title: "Tanggal Kembali");
    } else {
      final jsonEvent = {
        'summary': 'Rencana Perjalanan',
        'description':
            'Berpergian ke $tujuan  pada tanggal ${startDateTime.text} dan kembali pada saat ${endDateTime.text}.',
        'start': {
          'dateTime': DateTime.parse(startFormat.text).toUtc().toIso8601String()
        },
        'end': {
          'dateTime': DateTime.parse(endFormat.text).toUtc().toIso8601String()
        },
        "location": tujuan,
        // "place_id": exploreController.placeIdX.value,
      };
      String? token = await signInWithGoogle2();

      if (token != null) {
        await addEventToCalendar(token, jsonEvent);
      }
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
                Get.toNamed(RouteHelper.getExploreSearch());
              },
              readOnly: true,
            ),
            const SizedBox(
              height: 20,
            ),
            TextfieldDatetimePick(
              textController: startDateTime,
              labelText: 'Tanggal Berangkat',
              textdatetime: startFormat,
            ),
            const SizedBox(
              height: 20,
            ),
            TextfieldDatetimePick(
              textController: endDateTime,
              labelText: 'Tanggal Kembali',
              textdatetime: endFormat,
            ),
            CustomButton(
              title: 'Buat Perjalanan',
              onPressed: () {
                _posting();
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
