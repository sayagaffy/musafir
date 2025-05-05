import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/data/firestore/place_store.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/models/geocode_model.dart' hide Location, Geometry;
import 'package:musafir/models/nearby_model.dart';

class ExploreController extends GetxController implements GetxService {
  GoogleRepo googleRepo;
  PlacesStore placesStore;
  ExploreController({required this.googleRepo, required this.placesStore});

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
    int? halalStatus,
  }) async {
    // First, try Firebase search
    if (type == 'resto' || type == 'restaurant') {
      try {
        // Get user's country and city IDs from UserStore
        var userStore = UserStore();
        var userDetails = await userStore.getUserDetail();
        int countryId = userDetails['country_id'] ?? 0;
        int cityId = userDetails['city_id'] ?? 0;

        // Use provided halal status or default to all (0)
        int halalStatusFilter = halalStatus ?? 0;

        print(
            'Searching Firebase places with: countryId=$countryId, cityId=$cityId, halalStatus=$halalStatusFilter');

        // Query Firebase with actual parameters
        var firebaseResults = await placesStore.placesListWhere(
            countryId, cityId, halalStatusFilter);

        print('Firebase search returned ${firebaseResults.length} results');

        if (firebaseResults.isNotEmpty) {
          _nearbyFood = firebaseResults.map((doc) {
            // Convert Firebase document to NearbyPlaceModel format
            var model = NearbyPlaceModel(
                placeId: doc['place_id'] ?? '',
                name: doc['title'] ?? doc['name'] ?? '',
                vicinity: doc['address'] ?? '',
                geometry: Geometry(
                    location: Location(
                        lat: doc['lat'] is double
                            ? doc['lat']
                            : (doc['lat'] is String
                                ? double.tryParse(doc['lat']) ?? 0.0
                                : 0.0),
                        lng: doc['lng'] is double
                            ? doc['lng']
                            : (doc['lng'] is String
                                ? double.tryParse(doc['lng']) ?? 0.0
                                : 0.0))),
                photos: doc['photos'] != null
                    ? [Photos(photoReference: doc['photos'].toString())]
                    : null,
                rating: doc['rating'] is double
                    ? doc['rating']
                    : (doc['rating'] is String
                        ? double.tryParse(doc['rating']) ?? 0.0
                        : 0.0),
                userRatingsTotal: doc['user_ratings_total'] ?? 0);

            // Add halal_status to the model
            // Set halal_status directly
            if (doc['halal_status'] != null) {
              model.halal_status =
                  int.tryParse(doc['halal_status'].toString()) ?? 0;
              print(
                  'Setting halal_status for ${model.name}: ${model.halal_status}');
            }

            return model;
          }).toList();
          _nextPageTokenFood = 'none';
          _isLoadedFood = true;
          update();
          print('Successfully loaded Firebase places data');
          return;
        } else {
          print('No Firebase results found, falling back to Google API');
        }
      } catch (e) {
        print('Error searching Firebase places: $e');
        // Continue to Google API as fallback
      }
    }

    // If no Firebase results, fall back to Google API
    var k = keyword != null ? 'keyword=$keyword&' : '';
    var r = rankby != null ? 'rankby=$rankby&' : '';
    var t = type != null ? 'type=$type&' : '';
    var l = location != null ? 'location=$location&' : '';
    var rd = radius != null ? 'radius=$radius&' : '';
    var pt = pagetoken != null ? 'pagetoken=$pagetoken&' : '';
    var query = k + r + t + l + rd + pt;

    // If no Firebase results or not searching for restaurants, fall back to Google API
    print('Executing Google Places API search with query: $query');
    Response response = await googleRepo.getNearbyPlace(query);

    if (response.statusCode == 200) {
      if (type == 'resto' || type == 'restaurant') {
        _nearbyFood = [];
        _nearbyFood.addAll(NearbyPlace.fromJson(response.body).results);
        _nextPageTokenFood = response.body['next_page_token'] ?? 'none';
        _isLoadedFood = true;
        print(
            'Successfully loaded Google API places data: ${_nearbyFood.length} results');
      }

      if (type == 'mosque') {
        // First try to get mosques from Firebase
        try {
          var userStore = UserStore();
          var userDetails = await userStore.getUserDetail();
          int countryId = userDetails['country_id'] ?? 0;
          int cityId = userDetails['city_id'] ?? 0;

          print(
              'Searching Firebase for mosques with: countryId=$countryId, cityId=$cityId');

          // Query Firebase for mosques - assuming mosque type is stored in the 'type' field
          var firebaseMosques = await placesStore.dbPlaces
              .where('country_id', isEqualTo: countryId)
              .where('city_id', isEqualTo: cityId)
              .where('type', isEqualTo: 'mosque')
              .get();

          print(
              'Firebase mosque search returned ${firebaseMosques.docs.length} results');

          if (firebaseMosques.docs.isNotEmpty) {
            _nearbyMosque = firebaseMosques.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              // Convert Firebase document to NearbyPlaceModel format
              return NearbyPlaceModel(
                  placeId: data['place_id'] ?? '',
                  name: data['title'] ?? data['name'] ?? '',
                  vicinity: data['address'] ?? '',
                  geometry: Geometry(
                      location: Location(
                          lat: data['lat'] is double
                              ? data['lat']
                              : (data['lat'] is String
                                  ? double.tryParse(data['lat']) ?? 0.0
                                  : 0.0),
                          lng: data['lng'] is double
                              ? data['lng']
                              : (data['lng'] is String
                                  ? double.tryParse(data['lng']) ?? 0.0
                                  : 0.0))),
                  photos: data['photos'] != null
                      ? [Photos(photoReference: data['photos'].toString())]
                      : null,
                  rating: data['rating'] is double
                      ? data['rating']
                      : (data['rating'] is String
                          ? double.tryParse(data['rating']) ?? 0.0
                          : 0.0),
                  userRatingsTotal: data['user_ratings_total'] ?? 0);
            }).toList();
            _nextPageTokenMosque = 'none';
            _isLoadedMosque = true;
            update();
            print('Successfully loaded Firebase mosque data');
            return;
          } else {
            // If no Firebase results, fall back to Google API results
            _nearbyMosque = [];
            _nearbyMosque.addAll(NearbyPlace.fromJson(response.body).results);
            _nextPageTokenMosque = response.body['next_page_token'] ?? 'none';
            _isLoadedMosque = true;
            print(
                'Successfully loaded Google API mosque data: ${_nearbyMosque.length} results');
          }
        } catch (e) {
          print('Error searching Firebase for mosques: $e');
          // Fall back to Google API results
          _nearbyMosque = [];
          _nearbyMosque.addAll(NearbyPlace.fromJson(response.body).results);
          _nextPageTokenMosque = response.body['next_page_token'] ?? 'none';
          _isLoadedMosque = true;
          print(
              'Successfully loaded Google API mosque data: ${_nearbyMosque.length} results');
        }
      }

      update();
    } else {
      print(
          'Google API request failed with status code: ${response.statusCode}');
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
    namePlan.dispose();
    startDtTime.dispose();
    endDtTime.dispose();
    super.dispose();
  }
}
