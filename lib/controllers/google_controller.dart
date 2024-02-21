import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';
import 'package:musafir/models/getplaces_model.dart';

class GoogleController extends GetxController {
  final GoogleRepo googleRepo;
  final Debouncer debouncer = Debouncer(duration: const Duration(seconds: 1));

  GoogleController({required this.googleRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<dynamic> _geoCode = [];
  List<dynamic> get geoCode => _geoCode;

  List<dynamic> _getPlaces = [];
  List<dynamic> get getPlaces => _getPlaces;

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
  var locationController = Get.find<LocationController>();
  double latitude = lat;
  double longitude = lang;
  locationController.setAddress(address);
  locationController.setLatlang(latitude, longitude);

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
