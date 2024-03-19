// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';
import 'package:musafir/models/getplaces_model.dart';
import 'package:musafir/models/nearby_model.dart';

class GoogleController extends GetxController {
  final GoogleRepo googleRepo;
  final Debouncer debouncer = Debouncer(duration: const Duration(seconds: 1));

  GoogleController({required this.googleRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoadedFood = false;
  bool get isLoadedFood => _isLoadedFood;

  bool _isLoadedMosque = false;
  bool get isLoadedMosque => _isLoadedMosque;

  List<dynamic> _geoCode = [];
  List<dynamic> get geoCode => _geoCode;

  List<dynamic> _getPlaces = [];
  List<dynamic> get getPlaces => _getPlaces;

  // ignore: prefer_final_fields
  List<dynamic> _nearbyPlaces = [];
  List<dynamic> get nearbyPlaces => _nearbyPlaces;

  List<dynamic> _nearbyMosque = [];
  List<dynamic> get nearbyMosque => _nearbyMosque;

  late String _nextPageTokenMosque;
  String get nextPageTokenMosque => _nextPageTokenMosque;

  List<dynamic> _nearbyFood = [];
  List<dynamic> get nearbyFood => _nearbyFood;

  late String _nextPageTokenFood;
  String get nextPageTokenFood => _nextPageTokenFood;

  String _filterType = 'default';
  String get filterType => _filterType;

  void setFilterType(String value) {
    _filterType = value;

    update();
  }

  int _rate = 0;
  int get rate => _rate;

  void setRate(int value) {
    _rate = value;
    update();
  }

  Future<void> getGeoCode() async {
    Response response = await googleRepo
        .getGeocode(const LatLng(-6.233636722968254, 106.85436441421344));

    if (response.statusCode == 200) {
      //print(response.body['results'][0]['formatted_address']);

      _geoCode = [];
      _geoCode.addAll(Geocode.fromJson(response.body).results);

      // print(_geoCode);
      _isLoaded = true;
      update();
    }
  }

  Future<void> getGeoCodelatLng(LatLng latLng) async {
    Response response = await googleRepo.getGeocode(latLng);

    if (response.statusCode == 200) {
      _geoCode = [];
      _geoCode.addAll(Geocode.fromJson(response.body).results);

      setAddressAndLatlng(geoCode[0].formattedAddress,
          geoCode[0].geometry.location.lat, geoCode[0].geometry.location.lng);

      // for (var i in geoCode[0].addressComponents) {
      //   if (i.types.first == "administrative_area_level_1") {
      //     print("here is the postal code ${i.longName}");
      //   }
      // }

      _isLoaded = true;
      update();
    }
  }

  Future<void> getGeoCodeAddress(String address) async {
    Response response = await googleRepo.getGeocodeAddress(address);

    if (response.statusCode == 200) {
      _geoCode = [];
      _geoCode.addAll(Geocode.fromJson(response.body).results);

      setAddressAndLatlng(geoCode[0].formattedAddress,
          geoCode[0].geometry.location.lat, geoCode[0].geometry.location.lng);

      _isLoaded = true;
      update();
    }
  }

  Future<void> getNearbyPlace({
    String? keyword,
    String? rankby,
    String? type,
    String? pagetoken,
    String? location,
    int? radius,
  }) async {
    var k = keyword != null ? 'keyword=${keyword}&' : '';
    var r = rankby != null ? 'rankby=${rankby}&' : '';
    var t = type != null ? 'type=${type}&' : '';
    var l = location != null ? 'location=${location}&' : '';
    var rd = radius != null ? 'radius=${radius}&' : '';
    var pt = pagetoken != null ? 'pagetoken=${pagetoken}&' : '';
    var query = k + r + t + l + rd + pt;

    Response response = await googleRepo.getNearbyPlace(query);

    if (response.statusCode == 200) {
      if (type == 'restaurant') {
        _nearbyFood = [];
        _nearbyFood.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenFood = response.body['next_page_token'];

        _isLoadedFood = true;
        print('food');
      }

      if (type == 'mosque') {
        _nearbyMosque = [];
        _nearbyMosque.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenMosque = response.body['next_page_token'] ?? 'none';
        _isLoadedMosque = true;
        print('mosque');
      }

      // print(query);

      update();
    }
  }

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
}

void setAddressAndLatlng(String address, double lat, double lang) {
  // locationController.setAddress(address);
  // locationController.setLatlang(latitude, longitude);

  // print(locationController.address);
  // print(locationController.latlng);
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
