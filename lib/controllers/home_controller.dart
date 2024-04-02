// ignore_for_file: unused_field, prefer_final_fields, unnecessary_brace_in_string_interps, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/models/geocode_model.dart';
import 'package:musafir/models/nearby_model.dart';
import 'package:musafir/models/place_detail_model.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class HomeController extends GetxController implements GetxService {
  GoogleRepo googleRepo;
  HomeController({required this.googleRepo});

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///[PARAMETER debouncer]
  final Debouncer debouncer = Debouncer(duration: const Duration(seconds: 1));

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

  ///['Search by address]
  List<dynamic> _addressCollection = [];
  List<dynamic> get addressCollection => _addressCollection;

  bool _isLoadAddress = false;
  bool get isLoadAddress => _isLoadedFood;

  ///['PARAMETER FOR NEARBY PLACE']
  bool _isLoadedSearch = false;
  bool get isLoadedSearch => _isLoadedSearch;

  List<dynamic> _searchPlace = [];
  List<dynamic> get searchPlace => _searchPlace;

  late String _nextPageSearchPlace;
  String get nextPageSearchPlace => _nextPageSearchPlace;

  @override
  void onInit() {
    // Get called when controller is created
    print('on init');
    super.onInit();
  }

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    print('on ready');

    if (_isLoadedFood == false) {
      refreshHome();
    }
    super.onReady();
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    print('on close');
    super.onClose();
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

  ///[FUNCTION GEO CODE BY TEXT SEARCH]
  Future<void> getGeoCodeAddress(String address, String type) async {
    Response response = await googleRepo.getGeocodeAddress(address);

    if (response.statusCode == 200) {
      _addressCollection = [];
      _addressCollection.addAll(Geocode.fromJson(response.body).results);

      if (type == 'setLoc') {
        var usersUpdate = {
          'address': addressCollection[0].formattedAddress,
          'lat': addressCollection[0].geometry.location.lat.toString(),
          'long': addressCollection[0].geometry.location.lng.toString()
        };

        try {
          await UserStore().updateUserData(usersUpdate);

          showCustomSnackBar(
            isError: false,
            'Berhasil Mengubah Lokasi',
            title: 'Succsess',
            backgroundColor: kGreenHover,
          );
          refreshHome();
          update();
          Get.toNamed(RouteHelper.getInitial());
        } catch (e) {
          showCustomSnackBar(e.toString());
        }
      }
    }
  }

  ///['FUNCTION SEAARCH PLACE']
  Future<void> getSearchPlace(
    String textSearch,
    String latlang,
  ) async {
    debouncer.run(() async {
      Response response = await googleRepo.getTextSearch(latlang, textSearch);

      if (response.statusCode == 200) {
        _searchPlace = [];
        _searchPlace.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageSearchPlace = response.body['next_page_token'] ?? 'null';
        _isLoadedSearch = true;

        update();
      }
    });
  }

  void clearSearchPlace() {
    if (_searchPlace.isNotEmpty) {
      _searchPlace.clear();
    }
  }

  Future<void> refreshHome() async {
    var locationController = Get.find<LocationController>();

    try {
      UserStore().getUserDetail().then((val) async {
        String latlang = val['lat'] != null
            ? '${val['lat']},${val['long']}'
            : locationController.latlng.toString();

        await getNearbyPlace(
          keyword: 'food',
          rankby: 'distance',
          type: 'restaurant',
          location: latlang,
        );

        await getNearbyPlace(
          keyword: 'masjid',
          rankby: 'distance',
          type: 'mosque',
          location: latlang,
        );
      });
    } catch (e) {
      print(e);
      rethrow;
    }
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
