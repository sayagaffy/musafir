import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/data/repository/location_repo.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  bool _loading = false;

  String _address = 'none';
  String get address => _address;

  late LatLng _latLng;
  LatLng get latlng => _latLng;

  late Position _position;
  Position get position => _position;

  late bool _serviceEnabled;
  bool get serviceEnabled => _serviceEnabled;

  late LocationPermission _permission;
  LocationPermission get permission => _permission;

  Future<void> getCurrentPosition() async {
    final hasPermission = _serviceEnabled;
    var googleController = Get.find<GoogleController>();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _position = position;

      googleController.getGeoCodelatLng(LatLng(
        position.latitude,
        position.longitude,
      ));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void setAddress(String address) {
    _address = address.toString();
    update();
  }

  void setLatlang(double lat, double lng) async {
    _latLng =
        LatLng(double.parse(lat.toString()), double.parse(lng.toString()));
  }

  void setPermision(bool serviceE, LocationPermission permis) {
    _serviceEnabled = serviceE;
    _permission = permis;
  }
}
