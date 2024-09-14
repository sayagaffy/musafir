import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';
import 'package:musafir/models/nearby_model.dart';

class ExploreController extends GetxController implements GetxService {
  GoogleRepo googleRepo;
  ExploreController({required this.googleRepo});

  RxString placeIdX = ''.obs;
  int? indexUpdate = 0;
  String idDocument = '';
  TextEditingController searchPlace = TextEditingController();
  TextEditingController namePlan = TextEditingController();
  TextEditingController startDtTime = TextEditingController();
  TextEditingController endDtTime = TextEditingController();
  double? latX;
  double? lngX;
  List selectedFood = [];
  List updateSelectedFood = [];
  List selectedMosque = [];
  List updateSelectedMosque = [];

  ///[Restaurant]
  bool _isLoadedFood = false;
  bool get isLoadedFood => _isLoadedFood;
  set isLoadedFood(bool? isLoadedFood) => _isLoadedFood = isLoadedFood!;

  List<dynamic> _nearbyFood = [].obs;
  List<dynamic> get nearbyFood => _nearbyFood;

  late String _nextPageTokenFood;
  String get nextPageTokenFood => _nextPageTokenFood;

  ///[Mosque]
  bool _isLoadedMosque = false;
  bool get isLoadedMosque => _isLoadedMosque;
  set isLoadedMosque(bool? isLoadedMosque) => _isLoadedMosque = isLoadedMosque!;

  List<dynamic> _nearbyMosque = [].obs;
  List<dynamic> get nearbyMosque => _nearbyMosque;

  late String _nextPageTokenMosque;
  String get nextPageTokenMosque => _nextPageTokenMosque;

  ///[PARAMETER FOR GEO CODE]
  List<dynamic> _geoCode = [];
  List<dynamic> get geoCode => _geoCode;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  LatLng? _latLng;
  LatLng? get latlng => _latLng;

  var itemPlans = 0.obs;

  void setTujuan(String description, String placeId) {
    placeIdX.value = placeId;
    searchPlace.text = description;
    update();
  }

  void setLatLng() {
    _latLng = null;
    update();
  }

  void updateLatLng(double lat, double lng) {
    _latLng = LatLng(lat, lng);
    update();
  }

  Future<void> trigerUpdate() async {
    update();
  }

  void clearAll() async {
    searchPlace.clear();
    placeIdX.value = '';
    startDtTime.clear();
    endDtTime.clear();
    namePlan.clear();
    selectedFood.clear();
    selectedMosque.clear();
    setLatLng();
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
    var k = keyword != null ? 'keyword=$keyword&' : '';
    var r = rankby != null ? 'rankby=$rankby&' : '';
    var t = type != null ? 'type=$type&' : '';
    var l = location != null ? 'location=$location&' : '';
    var rd = radius != null ? 'radius=$radius&' : '';
    var pt = pagetoken != null ? 'pagetoken=$pagetoken&' : '';
    var query = k + r + t + l + rd + pt;

    Response response = await googleRepo.getNearbyPlace(query);

    if (response.statusCode == 200) {
      if (type == 'resto') {
        _nearbyFood = [];
        _nearbyFood.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenFood = response.body['next_page_token'] ?? 'none';
        _isLoadedFood = true;
      }

      if (type == 'mosque') {
        _nearbyMosque = [];
        _nearbyMosque.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenMosque = response.body['next_page_token'] ?? 'none';
        _isLoadedMosque = true;
      }

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

      _isLoaded = true;

      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchPlace.dispose();
  }
}
