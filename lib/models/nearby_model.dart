// ignore_for_file: unnecessary_this, unused_field
class NearbyPlace {
  String? _nextPageToken;
  late List<NearbyPlaceModel> _results;
  String? _status;

  //public class
  List<NearbyPlaceModel> get results => _results;

  NearbyPlace({required nextPageToken, required results, required status}) {
    this._nextPageToken = nextPageToken;
    this._results = results;
    this._status = status;
  }

  NearbyPlace.fromJson(Map<String, dynamic> json) {
    _nextPageToken = json['next_page_token'];
    if (json['results'] != null) {
      _results = <NearbyPlaceModel>[];
      json['results'].forEach((v) {
        _results.add(NearbyPlaceModel.fromJson(v));
      });
    }
    _status = json['status'];
  }
}

class NearbyPlaceModel {
  String? formattedAddress;
  String? businessStatus;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  String? placeId;
  double? rating;
  String? reference;
  String? scope;
  List<String>? types;
  int? userRatingsTotal;
  String? vicinity;
  List<Photos>? photos;
  PlusCode? plusCode;
  int? priceLevel;
  int? halal_status;

  NearbyPlaceModel({
    this.formattedAddress,
    this.businessStatus,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.placeId,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
    this.photos,
    this.plusCode,
    this.priceLevel,
  });

  NearbyPlaceModel.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    businessStatus = json['business_status'] ?? 'null';
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    placeId = json['place_id'];
    rating = json['rating'] != null ? json['rating'].toDouble() : 0;
    reference = json['reference'];
    scope = json['scope'] ?? 'null';
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'] ?? 0;
    vicinity = json['vicinity'] ?? 'null';
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    priceLevel = json['price_level'] ?? 0;
    halal_status = json['halal_status'] != null
        ? int.tryParse(json['halal_status'].toString())
        : 0;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport =
        json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast =
        json['northeast'] != null ? Location.fromJson(json['northeast']) : null;
    southwest =
        json['southwest'] != null ? Location.fromJson(json['southwest']) : null;
  }
}

class OpeningHours {
  bool? openNow;

  OpeningHours({this.openNow});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }
}
