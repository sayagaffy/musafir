// ignore_for_file: unused_field, prefer_final_fields, unnecessary_brace_in_string_interps, avoid_print
import 'package:get/get.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/nearby_model.dart';
import 'package:musafir/models/place_detail_model.dart';

class HomeController extends GetxController implements GetxService {
  GoogleRepo googleRepo;
  HomeController({required this.googleRepo});

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool? loading) => _loading = loading!;

  ///['PARAMETER FOR NEARBY PLACE']
  ///[Restaurant]
  bool _isLoadedFood = false;
  bool get isLoadedFood => _isLoadedFood;

  List<dynamic> _nearbyFood = [];
  List<dynamic> get nearbyFood => _nearbyFood;

  late String _nextPageTokenFood;
  String get nextPageTokenFood => _nextPageTokenFood;

  ///[Food Kategory]
  bool _isLoadedFoodKategory = false;
  bool get isLoadedFoodKategory => _isLoadedFoodKategory;
  set isLoadedFoodKategory(bool? isLoadedFoodKategory) =>
      _isLoadedFoodKategory = isLoadedFoodKategory!;

  List<dynamic> _nearbyFoodKategory = [];
  List<dynamic> get nearbyFoodKategory => _nearbyFoodKategory;

  late String _nextPageTokenFoodKategory;
  String get nextPageTokenFoodKategory => _nextPageTokenFoodKategory;

  ///[Mosque]
  bool _isLoadedMosque = false;
  bool get isLoadedMosque => _isLoadedMosque;

  List<dynamic> _nearbyMosque = [];
  List<dynamic> get nearbyMosque => _nearbyMosque;

  late String _nextPageTokenMosque;
  String get nextPageTokenMosque => _nextPageTokenMosque;

  ///['Place Detail']
  dynamic _placeDtl;
  dynamic get placeDtl => _placeDtl;

  ///['PARAMETER FILTER IN LIST PAGE']
  ///['Filter Default']
  String _filterType = 'default';
  String get filterType => _filterType;
  void setFilterType(String value) {
    _filterType = value;
    update();
  }

  ///['Filter By Rating']
  int _rate = 0;
  int get rate => _rate;

  void setRate(int value) {
    _rate = value;
    update();
  }

  ///['FUNCTION GET NEARBY PLACE']
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
        print('resto');
      }

      if (type == 'mosque') {
        _nearbyMosque = [];
        _nearbyMosque.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenMosque = response.body['next_page_token'] ?? 'none';
        _isLoadedMosque = true;
        print('mosque');
      }

      if (type == 'food') {
        _nearbyFoodKategory = [];
        _nearbyFoodKategory.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenFoodKategory = response.body['next_page_token'] ?? 'none';
        _isLoadedFoodKategory = true;
        print('food');
      }

      // print(query);

      update();
    }
  }

  ///['FUNCTION PLACE DETAIL']
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
