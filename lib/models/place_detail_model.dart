// ignore_for_file: unused_field, unnecessary_this

class PlaceDetail {
  late PlaceDetailModel _result;
  String? _status;

  PlaceDetailModel? get result => _result;

  PlaceDetail({PlaceDetailModel? result, String? status}) {
    if (result != null) {
      this._result = result;
    }
    if (status != null) {
      this._status = status;
    }
  }

  PlaceDetail.fromJson(Map<String, dynamic> json) {
    _result = (json['result'] != null
        ? PlaceDetailModel.fromJson(json['result'])
        : null)!;
    _status = json['status'];
  }
}

class PlaceDetailModel {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  bool? curbsidePickup;
  bool? delivery;
  bool? dineIn;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<Photos>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? priceLevel;
  double? rating;
  String? reference;
  bool? reservable;
  List<Reviews>? reviews;
  bool? servesBeer;
  bool? servesBreakfast;
  bool? servesBrunch;
  bool? servesDinner;
  bool? servesLunch;
  bool? servesWine;
  bool? takeout;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  String? website;

  PlaceDetailModel(
      {this.addressComponents,
      this.adrAddress,
      this.businessStatus,
      this.curbsidePickup,
      this.delivery,
      this.dineIn,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.iconBackgroundColor,
      this.iconMaskBaseUri,
      this.name,
      this.openingHours,
      this.photos,
      this.placeId,
      this.plusCode,
      this.priceLevel,
      this.rating,
      this.reference,
      this.reservable,
      this.reviews,
      this.servesBeer,
      this.servesBreakfast,
      this.servesBrunch,
      this.servesDinner,
      this.servesLunch,
      this.servesWine,
      this.takeout,
      this.types,
      this.url,
      this.userRatingsTotal,
      this.utcOffset,
      this.vicinity,
      this.website});

  PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    businessStatus = json['business_status'];
    curbsidePickup = json['curbside_pickup'];
    delivery = json['delivery'];
    dineIn = json['dine_in'];
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    priceLevel = json['price_level'];
    rating = json['rating'];
    reference = json['reference'];
    reservable = json['reservable'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    servesBeer = json['serves_beer'];
    servesBreakfast = json['serves_breakfast'];
    servesBrunch = json['serves_brunch'];
    servesDinner = json['serves_dinner'];
    servesLunch = json['serves_lunch'];
    servesWine = json['serves_wine'];
    takeout = json['takeout'];
    types = json['types'].cast<String>();
    url = json['url'];
    userRatingsTotal = json['user_ratings_total'];
    utcOffset = json['utc_offset'];
    vicinity = json['vicinity'];
    website = json['website'];
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
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
  List<Periods>? periods;
  List<String>? weekdayText;

  OpeningHours({this.openNow, this.periods, this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(Periods.fromJson(v));
      });
    }
    weekdayText = json['weekday_text'].cast<String>();
  }
}

class Periods {
  Close? close;
  Close? open;

  Periods({this.close, this.open});

  Periods.fromJson(Map<String, dynamic> json) {
    close = json['close'] != null ? Close.fromJson(json['close']) : null;
    open = json['open'] != null ? Close.fromJson(json['open']) : null;
  }
}

class Close {
  int? day;
  String? time;

  Close({this.day, this.time});

  Close.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
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

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;
  bool? translated;

  Reviews(
      {this.authorName,
      this.authorUrl,
      this.language,
      this.originalLanguage,
      this.profilePhotoUrl,
      this.rating,
      this.relativeTimeDescription,
      this.text,
      this.time,
      this.translated});

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    language = json['language'];
    originalLanguage = json['original_language'];
    profilePhotoUrl = json['profile_photo_url'];
    rating = json['rating'];
    relativeTimeDescription = json['relative_time_description'];
    text = json['text'];
    time = json['time'];
    translated = json['translated'];
  }
}
