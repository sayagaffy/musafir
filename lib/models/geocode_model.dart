class Geocode {
  late List<GeocodeModel> _results;
  String? _status;

  //public class
  List<GeocodeModel> get results => _results;

  Geocode({required results, required status}) {
    this._results = results;
    this._status = status;
  }

  Geocode.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _results = <GeocodeModel>[];
      json['results'].forEach((v) {
        _results!.add(GeocodeModel.fromJson(v));
      });
    }
    _status = json['status'];
  }
}

class GeocodeModel {
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;

  GeocodeModel({this.formattedAddress, this.geometry, this.placeId});

  GeocodeModel.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    placeId = json['place_id'];
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
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
