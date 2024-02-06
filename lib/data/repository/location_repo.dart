import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/data/api/api_google.dart';
import 'package:musafir/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiGoogle apiGoogle;
  // final ApiClent apiClent;
  final SharedPreferences sharedPreferences;

  LocationRepo({
    required this.apiGoogle,
    // required this.apiClent,
    required this.sharedPreferences,
  });

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiGoogle.getData('${AppConstants.GEOCODE_URI2}'
        '?latlng=${latLng.latitude},${latLng.longitude}&language=id&key=${AppConstants.API_GKEY}');
  }
}
