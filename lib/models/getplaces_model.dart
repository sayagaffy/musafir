class GetPlaces {
  late List<GetPlacesModel> _predictions;
  String? _status;

  //public class
  List<GetPlacesModel> get predictions => _predictions;

  GetPlaces({
    required predictions,
    required status,
  }) {
    this._predictions = predictions;
    this._status = status;
  }

  GetPlaces.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      _predictions = <GetPlacesModel>[];
      json['predictions'].forEach((v) {
        _predictions!.add(GetPlacesModel.fromJson(v));
      });
    }
    _status = json['status'];
  }
}

class GetPlacesModel {
  String? description;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;

  GetPlacesModel(
      {this.description,
      this.placeId,
      this.reference,
      this.structuredFormatting});

  GetPlacesModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? new StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
  }
}

class StructuredFormatting {
  String? mainText;
  List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  StructuredFormatting(
      {this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      mainTextMatchedSubstrings = <MainTextMatchedSubstrings>[];
      json['main_text_matched_substrings'].forEach((v) {
        mainTextMatchedSubstrings!
            .add(new MainTextMatchedSubstrings.fromJson(v));
      });
    }
    secondaryText = json['secondary_text'];
  }
}

class MainTextMatchedSubstrings {
  int? length;
  int? offset;

  MainTextMatchedSubstrings({this.length, this.offset});

  MainTextMatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }
}
