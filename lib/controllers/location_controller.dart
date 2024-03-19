// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, unused_field, prefer_final_fields
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';
import 'package:musafir/models/getplaces_model.dart';

class LocationController extends GetxController implements GetxService {
  GoogleRepo googleRepo;
  LocationController({required this.googleRepo});

  ///[PARAMETER FOR GET PLACE]
  final Debouncer debouncer = Debouncer(duration: const Duration(seconds: 1));
  List<dynamic> _getPlaces = [];
  List<dynamic> get getPlaces => _getPlaces;

  ///[PARAMETER FOR GEO CODE]
  List<dynamic> _geoCode = [];
  List<dynamic> get geoCode => _geoCode;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  ///[PARAMETER GET LOCATION]
  bool _loading = false;

  String _address = 'none';
  String get address => _address;

  LatLng? _latLng;
  LatLng? get latlng => _latLng;

  ///[for Geolocator]
  late Position _position;
  Position get position => _position;

  late bool _serviceEnabled;
  bool get serviceEnabled => _serviceEnabled;

  late LocationPermission _permission;
  LocationPermission get permission => _permission;

  ///[FUNCTION GEO CODE BY LATLANG]
  Future<void> getGeoCodelatLng(LatLng latLng) async {
    Response response = await googleRepo.getGeocode(latLng);

    if (response.statusCode == 200) {
      _geoCode = [];
      _geoCode.addAll(Geocode.fromJson(response.body).results);

      ///[set _latlang]
      _latLng = LatLng(
          geoCode[0].geometry.location.lat, geoCode[0].geometry.location.lng);

      ///[set _address]
      _address = geoCode[0].formattedAddress;

      // for (var i in geoCode[0].addressComponents) {
      //   if (i.types.first == "administrative_area_level_1") {
      //     print("here is the postal code ${i.longName}");
      //   }
      // }

      _isLoaded = true;
      update();
    }
  }

  ///[FUNCTION GEO CODE BY TEXT SEARCH]
  Future<void> getGeoCodeAddress(String address) async {
    Response response = await googleRepo.getGeocodeAddress(address);

    if (response.statusCode == 200) {
      _geoCode = [];
      _geoCode.addAll(Geocode.fromJson(response.body).results);

      ///[set _latlang]
      _latLng = LatLng(
          geoCode[0].geometry.location.lat, geoCode[0].geometry.location.lng);

      ///[set _address]
      _address = geoCode[0].formattedAddress;

      _isLoaded = true;
      update();
    }
  }

  ///[FUNCTION GET CURRENT POSITION]
  Future<void> getCurrentPosition() async {
    final hasPermission = _serviceEnabled;

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _position = position;

      getGeoCodelatLng(LatLng(
        position.latitude,
        position.longitude,
      ));

      _latLng = LatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  ///[FUNCTION GET PLACE]
  Future<void> getPlace(String query) async {
    debouncer.run(() async {
      Response response = await googleRepo.getPlace(query);
      if (response.statusCode == 200) {
        _getPlaces = [];
        _getPlaces.addAll(GetPlaces.fromJson(response.body).predictions);

        _isLoaded = true;
        update();
      }
    });
  }

  ///[FUNCTION GET STARTED POSITION]
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

  ///[FUNCTION SET PERMISION FROM GEOLOCATOR]
  void setPermision(
      bool serviceE, LocationPermission permis, Position position) {
    _serviceEnabled = serviceE;
    _permission = permis;
    _latLng = LatLng(position.latitude, position.longitude);
  }
}

///[CLASS DELAY SEARCH]
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
