class Geocode {
  late List<GeocodeModel> _results;
  // ignore: unused_field
  String? _status;

  //public class
  List<GeocodeModel> get results => _results;

  Geocode({required results, required status}) {
    // ignore: unnecessary_this
    this._results = results;
    // ignore: unnecessary_this
    this._status = status;
  }

  Geocode.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _results = <GeocodeModel>[];
      json['results'].forEach((v) {
        _results.add(GeocodeModel.fromJson(v));
      });
    }
    _status = json['status'];
  }
}

class GeocodeModel {
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<AddressComponents>? addressComponents;
  List<String>? types;

  GeocodeModel(
      {this.formattedAddress,
      this.geometry,
      this.placeId,
      this.addressComponents,
      this.types});

  GeocodeModel.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        // ignore: unnecessary_new
        addressComponents!.add(new AddressComponents.fromJson(v));
      });
    }

    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        // ignore: unnecessary_new
        ? new Geometry.fromJson(json['geometry'])
        : null;
    placeId = json['place_id'];
    types = json['types'].cast<String>();
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

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        // ignore: unnecessary_new
        ? new Location.fromJson(json['location'])
        : null;
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
