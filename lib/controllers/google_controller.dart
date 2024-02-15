import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

      print(_geoCode);
      _isLoaded = true;
      update();
    }
  }

  Future<void> getPlace(String query) async {
    debouncer.run(() async {
      Response response = await googleRepo.getPlace(query);
      if (response.statusCode == 200) {
        print(response.body);
        _getPlaces = [];
        _getPlaces.addAll(GetPlaces.fromJson(response.body).predictions);

        print(_getPlaces);
        _isLoaded = true;
        update();
      }
    });
  }
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
