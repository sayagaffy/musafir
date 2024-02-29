// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/data/repository/location_repo.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  // ignore: unused_field, prefer_final_fields
  bool _loading = false;

  String _address = 'none';
  String get address => _address;

  LatLng? _latLng;
  LatLng? get latlng => _latLng;

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

      _latLng = LatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> startedPosition() async {
    final hasPermission = _serviceEnabled;

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _position = position;

      _latLng = LatLng(position.latitude, position.longitude);

      print(_latLng);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void refreshNearbyPlace() {
    var googleControllers = Get.find<GoogleController>();

    String latLang = '${latlng?.latitude}, ${latlng?.longitude}';

    googleControllers.getNearbyPlace(
      keyword: 'food',
      rankby: 'distance',
      type: 'restaurant',
      location: latLang,
    );

    googleControllers.getNearbyPlace(
      keyword: 'masjid',
      rankby: 'distance',
      type: 'mosque',
      location: latLang,
    );
  }

  void setAddress(String address) {
    _address = address.toString();
    update();
  }

  void setLatlang(double lat, double lng) async {
    _latLng =
        LatLng(double.parse(lat.toString()), double.parse(lng.toString()));

    // print('location');
    // print('${_latLng.latitude.toString()},${_latLng.longitude.toString()}');
  }

  void setPermision(bool serviceE, LocationPermission permis) {
    _serviceEnabled = serviceE;
    _permission = permis;
  }
}
