import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Place {
  Place({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  String description;
  List<MatchedSubstrings> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  List<Terms> terms;
  List<String> types;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MatchedSubstrings {
  MatchedSubstrings({this.length, this.offset});

  int length;
  int offset;

  factory MatchedSubstrings.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringsFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedSubstringsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class StructuredFormatting {
  StructuredFormatting({this.mainText, this.secondaryText});

  String mainText;
  String secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Terms {
  Terms({this.offset, this.value});

  int offset;
  String value;

  factory Terms.fromJson(Map<String, dynamic> json) => _$TermsFromJson(json);

  Map<String, dynamic> toJson() => _$TermsToJson(this);
}
