// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';
import 'package:musafir/models/getplaces_model.dart';
import 'package:musafir/utilitis/device_compatibility.dart';
import 'package:permission_handler/permission_handler.dart';

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
  set address(String? address) => _address = address!;

  LatLng? _latLng;
  LatLng? get latlng => _latLng;

  ///[for Geolocator]
  late Position _position;
  Position get position => _position;

  late bool _serviceEnabled;
  bool get serviceEnabled => _serviceEnabled;

  late LocationPermission _permission;
  LocationPermission get permission => _permission;

  void forceUpdate() {
    update();
  }

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
      print(
          '${geoCode[0].geometry.location.lat}, ${geoCode[0].geometry.location.lng}');
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

      final homeC = Get.find<HomeController>();

      homeC.setAddress(position.latitude, position.longitude, 'get');
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

  Future<void> determinePosition() async {
    bool isSpecialDevice = await DeviceCompatibility.needsSpecialHandling();

    if (isSpecialDevice) {
      print('Special device detected, using enhanced location handling');
      await _handleSpecialDeviceLocation();
    } else {
      await _handleStandardLocation();
    }
  }

  Future<void> _handleSpecialDeviceLocation() async {
    try {
      // Check if location service is enabled
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        await _showLocationServiceDialog();
        return;
      }

      // For Xiaomi devices, use permission_handler
      PermissionStatus locationStatus = await Permission.location.status;

      if (locationStatus.isDenied) {
        locationStatus = await Permission.location.request();
      }

      if (locationStatus.isPermanentlyDenied) {
        await _showPermissionDialog();
        return;
      }

      if (locationStatus.isGranted) {
        await _getCurrentPositionSafely();
      }
    } catch (e) {
      print('Location error on special device: $e');
      await _handleLocationError(e);
    }
  }

  Future<void> _handleStandardLocation() async {
    try {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (_permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (_permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      await _getCurrentPositionSafely();
    } catch (e) {
      print('Location error: $e');
      await _handleLocationError(e);
    }
  }

  Future<void> _getCurrentPositionSafely() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10), // Add timeout
      );

      setPermision(_serviceEnabled, _permission, position);
      startedPosition();
    } catch (e) {
      // Fallback to last known position
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        print('Using last known position as fallback');
        setPermision(_serviceEnabled, _permission, lastPosition);
        startedPosition();
      } else {
        rethrow;
      }
    }
  }

  Future<void> _showLocationServiceDialog() async {
    Get.defaultDialog(
      title: "Location Service",
      middleText: "Please enable location service in device settings",
      textConfirm: "Open Settings",
      textCancel: "Cancel",
      onConfirm: () async {
        await Geolocator.openLocationSettings();
        Get.back();
      },
    );
  }

  Future<void> _showPermissionDialog() async {
    Get.defaultDialog(
      title: "Location Permission",
      middleText: "Please grant location permission in app settings",
      textConfirm: "Open Settings",
      textCancel: "Cancel",
      onConfirm: () async {
        await openAppSettings();
        Get.back();
      },
    );
  }

  Future<void> _handleLocationError(dynamic error) async {
    print('Location error: $error');

    // Log device info for debugging
    if (kDebugMode) {
      Map<String, String> deviceInfo =
          await DeviceCompatibility.getDeviceInfo();
      print('Device info: $deviceInfo');
    }

    // Show user-friendly error message
    showCustomSnackBar(
      "Unable to get your location. Please check location settings.",
      title: "Location Error",
    );
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
