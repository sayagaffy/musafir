// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/firestore/geo_store.dart';
import 'package:musafir/data/firestore/user_store.dart';
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

  int countryId = 0;
  int provinceId = 0;
  int cityId = 0;

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

      _latLng = LatLng(position.latitude, position.longitude);

      setAddress(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getPlaceMarks() async {
    //check address is empty or not then get latlang from firestore, if null get from geolocation and then return
    String address = await UserStore().getUserDetail().then((val) async {
      return val['lat'] != null
          ? '${val['lat']},${val['lng']}'
          : latlng.toString();
    });
    //process if address is not empty
    if (address.isNotEmpty || latlng != null) {
      var lat;
      var lng;

      final split = address.split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };

      lat = values[0];
      lng = values[1];

      setAddress(double.parse(lat), double.parse(lng));
    } else {
      print('error latlang null');
    }
  }

  Future<void> setAddress(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    // print(placemarks[1]);

    Placemark plc = placemarks[1];

    // String? name =
    //     plc.name!.isNotEmpty || plc.name != null ? '${plc.name}, ' : '';
    String? street =
        plc.street!.isNotEmpty || plc.street != null ? '${plc.street}, ' : '';
    String? subLocality = plc.subLocality!.isNotEmpty || plc.subLocality != null
        ? '${plc.subLocality}, '
        : '';
    String? locality = plc.locality!.isNotEmpty || plc.locality != null
        ? '${plc.locality}, '
        : '';
    String? subAdministrativeArea = plc.subAdministrativeArea!.isNotEmpty ||
            plc.subAdministrativeArea != null
        ? '${plc.subAdministrativeArea}, '
        : '';
    String? administrative =
        plc.administrativeArea!.isNotEmpty ? '${plc.administrativeArea}, ' : '';
    String? postalCode = plc.postalCode!.isNotEmpty || plc.postalCode != null
        ? '${plc.postalCode}, '
        : '';
    String? country = plc.country!.isNotEmpty || plc.country != null
        ? '${plc.country}, '
        : '';
    String? thoroughfare = plc.thoroughfare != '' || plc.thoroughfare != null
        ? '${plc.thoroughfare}, '
        : '';

    String address = street +
        thoroughfare +
        subLocality +
        postalCode +
        locality +
        subAdministrativeArea +
        administrative +
        country;

    _address = address;
    setIdPlace(
        plc.isoCountryCode.toString(), plc.subAdministrativeArea.toString());
  }

  void setIdPlace(String isoCountry, String cityName) async {
    //get country code province code and city code from firestore with variable from placemarks/place derail

    await GeoStore().placesCountry(isoCountry).then((payload) async {
      for (var i in payload.docs) {
        countryId = int.parse(i.data()['id']);
      }
    });

    await GeoStore().placesCity(cityName).then((payload) async {
      for (var i in payload.docs) {
        cityId = i.data()['id'];
        provinceId = i.data()['province_id'];
      }
    });

    // var usersUpdate = {
    //   'country_id': countryId,
    //   'province_id': cityId,
    //   'city_id': provinceId
    // };

    // await UserStore().updateUserPlace(usersUpdate);

    update();

    // print(address);
    // print(countryId);
    // print(provinceId);
    // print(cityId);
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
      position = position;

      _latLng = LatLng(position.latitude, position.longitude);
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

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition();
    setPermision(serviceEnabled, permission, position);
    startedPosition();
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
