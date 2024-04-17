// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations

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

  Future<Response> getGeocodeAddress(String address) async {
    return await apiGoogle.getData(
        '${AppConstans.GEOCODE}?address=${address}&language=id&key=${AppConstans.API_GKEY}');
  }

  Future<Response> getPlace(String query) async {
    return await apiGoogle.getData(
        '${AppConstans.SEARCH}?input=${query}&language=id&key=${AppConstans.API_GKEY}');
  }

  Future<Response> getNearbyPlace(String query) async {
    return await apiGoogle.getData(
        '${AppConstans.NEARBYSEARCH}?${query}key=${AppConstans.API_GKEY}');
  }

  Future<Response> getPlaceDetail(String placeId) async {
    return await apiGoogle.getData(
        '${AppConstans.PLACE_DETAIL}?place_id=${placeId}&language=id&key=${AppConstans.API_GKEY}');
  }

  Future<Response> getTextSearch(String latlang, String textSearch) async {
    return await apiGoogle.getData(
        '${AppConstans.PLACE_TEXTSEARCH}?location=${latlang}&query=${textSearch}?&language=id&key=${AppConstans.API_GKEY}');
  }

  Future<Response> getDistance(String destinations, String origins) async {
    return await apiGoogle.getData(
        '${AppConstans.DISTANCE}?origins=${origins}&destinations=${destinations}&language=id&key=${AppConstans.API_GKEY}');
  }
}
