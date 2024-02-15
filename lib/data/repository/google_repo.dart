import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/api/api_google.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class GoogleRepo extends GetxService {
  final ApiGoogle apiGoogle;
  GoogleRepo({required this.apiGoogle});

  Future<Response> getGeocode(LatLng latLng) async {
    return await apiGoogle.getData(
        '${AppConstans.GEOCODE}?latlng=${latLng.latitude},${latLng.longitude}&language=id&key=${AppConstans.API_GKEY}');
  }

  Future<Response> getPlace(String query) async {
    return await apiGoogle.getData(
        '${AppConstans.SEARCH}?input=${query}&language=id&key=${AppConstans.API_GKEY}');
  }
}
