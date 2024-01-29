class AutocompletePrediction {
  ///[description] contains the human-readable name for the returned result the business name.
  final String? description;

  ///[structured Formatting] provides pre-formatted text that can be shown in
  final StructuredFormatting? structuredFormatting;

  /// [placeId] is a textual identifier that uniquely identifies a place. To
  /// pass this identifier in the placeId field of a Places Api request for
  final String? placeId;

  /// [reference] contains reference.
  final String? reference;

  AutocompletePrediction({
    this.description,
    this.structuredFormatting,
    this.placeId,
    this.reference,
  });

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
    ); // AutocompletePrediction
  }
}

class StructuredFormatting {
  final String? mainText;

  final String? secondaryText;
  StructuredFormatting({this.mainText, this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['mainText'] as String?,
      secondaryText: json['secondaryText'] as String?,
    );
  }
}
