// ignore_for_file: unused_field, prefer_final_fields, unnecessary_brace_in_string_interps, avoid_print, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/firestore/geo_store.dart';
import 'package:musafir/data/firestore/place_store.dart';
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
  set isLoadedFood(bool? isLoadedFood) => _isLoadedFood = isLoadedFood!;

  List<dynamic> _nearbyFood = [].obs;
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
  set isLoadedMosque(bool? isLoadedMosque) => _isLoadedMosque = isLoadedMosque!;

  List<dynamic> _nearbyMosque = [].obs;
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
  bool get isLoadAddress => _isLoadAddress;

  ///['PARAMETER FOR NEARBY PLACE']
  bool _isLoadedSearch = false;
  bool get isLoadedSearch => _isLoadedSearch;

  List<dynamic> _searchPlace = [];
  List<dynamic> get searchPlace => _searchPlace;

  late String _nextPageSearchPlace;
  String get nextPageSearchPlace => _nextPageSearchPlace;

  var locationC = Get.find<LocationController>();

  int countryId = 0;
  int provinceId = 0;
  int cityId = 0;

  List<dynamic> _localPlace = [].obs;
  List<dynamic> get localPlace => _localPlace;

  bool _isLoadedlocal = false;
  bool get isLoadedlocal => _isLoadedlocal;

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

    if (_nearbyFood.isEmpty) {
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

  void clearList() {
    if (_nearbyFood.isNotEmpty) {
      _nearbyFood.clear();
      _isLoadedFood = false;

      print('clear nearby food');
    }

    if (_nearbyMosque.isNotEmpty) {
      _nearbyMosque.clear();
      _isLoadedMosque = false;

      print('clear nearby Mosque');
    }

    if (_nearbyFoodKategory.isNotEmpty) {
      _nearbyFoodKategory.clear();
      _isLoadedFoodKategory = false;

      print('clear nearby Mosque');
    }
    if (_addressCollection.isNotEmpty) {
      _addressCollection.clear();
      _isLoadAddress = false;

      print('clear addressCollection');
    }

    if (_searchPlace.isNotEmpty) {
      _searchPlace.clear();
      _isLoadedSearch = false;

      print('clear _searchPlace');
    }

    if (_localPlace.isNotEmpty) {
      _localPlace.clear();
      _isLoadedlocal = false;

      print('clear _localplace');
    }

    update();
  }

  void clearFoodKategory() {
    if (_nearbyFoodKategory.isNotEmpty) {
      _nearbyFoodKategory.clear();
      update();
      print('clear nearby Food Kategory');
    }
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
    print(query);

    Response response = await googleRepo.getNearbyPlace(query);

    if (response.statusCode == 200) {
      if (type == 'restaurant') {
        _nearbyFood = [];
        _nearbyFood.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenFood = response.body['next_page_token'] ?? 'none';

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

      update();
    }
  }

  void setFalseLoad(String type) {
    if (type == 'filterList_resto') {
      _isLoadedFood = false;
    } else if (type == 'filterList_mosque') {
      _isLoadedMosque = false;
    } else if (type == 'filterList_food') {
      _isLoadedFoodKategory = false;
    }

    update();
  }

  Future<void> testRemoveDuplicate() async {
    for (var lokal in localPlace) {
      nearbyFood.removeWhere((item) => item.placeId == lokal['place_id']);
    }

    print('test duplicate');

    update();
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
        try {
          await setAddress(addressCollection[0].geometry.location.lat,
              addressCollection[0].geometry.location.lng, 'set');
          update();

          var usersUpdate = {
            'address': addressCollection[0].formattedAddress,
            'lat': addressCollection[0].geometry.location.lat.toString(),
            'lng': addressCollection[0].geometry.location.lng.toString(),
            'country_id': countryId,
            'province_id': provinceId,
            'city_id': cityId,
          };

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
    String ltlng = await UserStore().getUserDetail().then((val) async {
      if (locationC.latlng == null) {
        locationC.determinePosition();
      }

      return val['lat'] != null
          ? '${val['lat']},${val['lng']}'
          : locationC.latlng.toString();
    });

    if (ltlng.isNotEmpty || locationC.latlng != null) {
      var lat;
      var lng;

      final split = ltlng
          .replaceAll(RegExp('LatLng'), '')
          .replaceAll(RegExp(r'\(|\)'), '')
          .split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };

      lat = values[0];
      lng = values[1];

      await getNearbyPlace(
        keyword: 'food',
        rankby: 'distance',
        type: 'restaurant',
        location: '${lat},${lng}',
      );

      await getNearbyPlace(
        keyword: 'masjid',
        rankby: 'distance',
        type: 'mosque',
        location: '${lat},${lng}',
      );
    } else {
      print('error latlang null');
    }
  }

  ///['FUNCTION DISTANCE']
  Future<String> distance(String destinations, String origins) async {
    Response response = await googleRepo.getDistance(origins, destinations);

    if (response.statusCode == 200) {
      String isRes =
          response.body['rows'][0]['elements'][0]['status'] == 'ZERO_RESULTS'
              ? 'ZERO_RESULTS'
              : response.body['rows'][0]['elements'][0]['distance']['text'];

      return isRes;
    }

    return 'zero';
  }

  Future<void> getPlaceMarks() async {
    //check address is empty or not then get latlang from firestore, if null get from geolocation and then return
    String ltlng = await UserStore().getUserDetail().then((val) async {
      if (locationC.latlng == null) {
        locationC.determinePosition();
      }

      return val['lat'] != null
          ? '${val['lat']},${val['lng']}'
          : locationC.latlng.toString();
    });

    //process if address is not empty
    if (ltlng.isNotEmpty || locationC.latlng != null) {
      var lat;
      var lng;

      final split = ltlng
          .replaceAll(RegExp('LatLng'), '')
          .replaceAll(RegExp(r'\(|\)'), '')
          .split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };

      lat = values[0];
      lng = values[1];

      setAddress(double.parse(lat), double.parse(lng), 'set');
    } else {
      print('error latlang null');
    }
  }

  Future<void> setAddress(double lat, double lng, String type) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    Placemark plc = placemarks[1];

    // print(placemarks);

    // String? name =
    //     plc.name!.isNotEmpty || plc.name != null ? '${plc.name}, ' : '';
    String? street =
        plc.street!.isNotEmpty || plc.street != null ? '${plc.street}, ' : '';
    String? subLocality = plc.subLocality!.isNotEmpty || plc.subLocality != null
        ? '${plc.subLocality}, '
        : '';
    String? locality = plc.locality!.isNotEmpty || plc.locality != null
        ? '${plc.locality}, '
        : '';
    String? subAdministrativeArea = plc.subAdministrativeArea!.isNotEmpty ||
            plc.subAdministrativeArea != null
        ? '${plc.subAdministrativeArea}, '
        : '';
    String? administrative =
        plc.administrativeArea!.isNotEmpty ? '${plc.administrativeArea}, ' : '';
    String? postalCode = plc.postalCode!.isNotEmpty || plc.postalCode != null
        ? '${plc.postalCode}, '
        : '';
    String? country = plc.country!.isNotEmpty || plc.country != null
        ? '${plc.country}, '
        : '';
    // String? thoroughfare = plc.thoroughfare != '' || plc.thoroughfare != null
    //     ? '${plc.thoroughfare}, '
    //     : '';

    String address = street +
        subLocality +
        postalCode +
        locality +
        subAdministrativeArea +
        administrative +
        country;

    locationC.address = address;

    // print(address);

    String latlang = '${lat},${lng}';
    if (type == 'set') {
      await setIdPlace(plc.isoCountryCode.toString(),
          plc.subAdministrativeArea.toString(), latlang);
    } else {
      locationC.address = address;

      locationC.forceUpdate();
    }
  }

  String filterDot(String payload) {
    String firstCharacterBeforeDot = payload.substring(0, payload.indexOf('.'));
    List<String> wordAfterFirstDot = payload.split(".");

    String word =
        wordAfterFirstDot.sublist(1, wordAfterFirstDot.length).join("");

    return '$firstCharacterBeforeDot.$word';
  }

  Future<void> setIdPlace(
      String isoCountry, String cityName, String latlng) async {
    //get country code province code and city code from firestore with variable from placemarks/place derail
    print(isoCountry);
    print(cityName);
    print(latlng);

    await GeoStore().placesCountry(isoCountry).then((payload) async {
      for (var i in payload.docs) {
        countryId = int.parse(i.data()['id']);
      }
    });

    await GeoStore().placesCity(cityName).then((payload) async {
      if (payload.docs.length != 0) {
        for (var i in payload.docs) {
          cityId = i.data()['id'];
          provinceId = i.data()['province_id'];
        }
      } else {
        cityId = 0;
        provinceId = 0;
      }
    });

    update();

    print(cityId);
    print(provinceId);
    print(countryId);

    print(localPlace);

    _isLoadedlocal = false;

    await PlacesStore().placesList(countryId, cityId).then((payload) async {
      print(countryId);
      print('testTrigger HAHAHAH');
      print(cityId);

      if (payload.docs.length != 0) {
        _localPlace.clear();
        for (var i in payload.docs) {
          var destination =
              '${filterDot(i.data()['lat'])},${filterDot(i.data()['lng'])}';

          await distance(latlng, destination).then((value) {
            Map<String, dynamic> newplace = {
              "place_id": i.data()['place_id'],
              'title': i.data()['title'],
              'halal_status': i.data()['halal_status'],
              'address': i.data()['address'],
              'jarak': value.replaceAll('km', ''),
            };

            _localPlace.add(newplace);
          });
        }

        testRemoveDuplicate();
      } else {
        _localPlace.clear();
      }
      print(payload.docs.length);

      update();
    });

    _isLoadedlocal = true;

    update();
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
