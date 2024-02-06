import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Favorite PAGE',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const GetxDemo(),
          ],
        ),
      ),
    );
  }
}

class GetxDemo extends StatefulWidget {
  const GetxDemo({super.key});

  @override
  State<GetxDemo> createState() => _GetxDemoState();
}

class _GetxDemoState extends State<GetxDemo> {
  final _connect = GetConnect();

  void _sendGetRequest() async {
    // final response =
    //     await _connect.get('https://jsonplaceholder.typicode.com/users');
    final response = await _connect.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=-6.233636722968254,106.85436441421344&language=id&key=AIzaSyBe_89LiN8WdHYk5mPcmAey5ZyheaskwE0');
    if (kDebugMode) {
      print(response.body['results'][0]['formatted_address']);
    }
  }

  Future<String> _sendGetRequest2() async {
    String _address = "Unkow Loaction Found";

    Response response = await _connect.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=-6.233636722968254,106.85436441421344&language=id&key=AIzaSyBe_89LiN8WdHYk5mPcmAey5ZyheaskwE0');

    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]['formatted_address'];

      // ignore: avoid_print
      print("printing addres " +
          response.body["results"][0]['formatted_address'].toString());
    } else {
      print("Error getting the google api");
    }
    return _address;
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Fetch Data',
      onPressed: () {
        _sendGetRequest2();
      },
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 200,
    );
  }
}
