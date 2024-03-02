// ignore_for_file: unused_field, prefer_final_fields

import 'package:get/get.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/place_detail_model.dart';

class HomeController extends GetxController implements GetxService {
  GoogleRepo googleRepo;
  HomeController({required this.googleRepo});

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool? loading) => _loading = loading!;

  ///['PARAMETER FOR PLACE DETAIL']
  dynamic _placeDtl;
  dynamic get placeDtl => _placeDtl;

  Future<void> placeDetail(String placeId) async {
    Response response = await googleRepo.getPlaceDetail(placeId);

    if (response.statusCode == 200) {
      // _geoCode.addAll(Geocode.fromJson(response.body).results);

      _placeDtl = PlaceDetail.fromJson(response.body).result;

      _loading = true;
      update();
    }
  }
}
