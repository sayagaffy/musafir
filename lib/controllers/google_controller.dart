import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';

class GoogleController extends GetxController {
  final GoogleRepo googleRepo;

  GoogleController({required this.googleRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<dynamic> _geoCode = [];
  List<dynamic> get geoCode => _geoCode;

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
}
