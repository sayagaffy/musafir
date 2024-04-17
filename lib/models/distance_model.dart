class DistanceMod {
  late List<String> _destinationAddresses;
  late List<String> _originAddresses;
  late List<DistanceModel> _results;
  // ignore: unused_field
  String? _status;

  DistanceMod({
    required destinationAddresses,
    required originAddresses,
    required results,
    required status,
  }) {
    _destinationAddresses = destinationAddresses;
    _originAddresses = originAddresses;
    _results = results;
    _status = status;
  }

  List<String> get destinationAddresses => _destinationAddresses;
  List<String> get originAddresses => _originAddresses;
  List<DistanceModel> get results => _results;

  DistanceMod.fromJson(Map<String, dynamic> json) {
    _destinationAddresses = json['destination_addresses'].cast<String>();
    _originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      _results = <DistanceModel>[];
      json['rows'].forEach((v) {
        _results.add(DistanceModel.fromJson(v));
      });
    }
    _status = json['status'];
  }
}

class DistanceModel {
  List<Elements>? elements;

  DistanceModel({this.elements});

  DistanceModel.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(Elements.fromJson(v));
      });
    }
  }
}

class Elements {
  Distance? distance;
  Distance? duration;
  String? status;

  Elements({this.distance, this.duration, this.status});

  Elements.fromJson(Map<String, dynamic> json) {
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    duration =
        json['duration'] != null ? Distance.fromJson(json['duration']) : null;
    status = json['status'];
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }
}
