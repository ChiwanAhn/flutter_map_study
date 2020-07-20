// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    description: json['description'] as String,
    matchedSubstrings: (json['matched_substrings'] as List)
        ?.map((e) => e == null
            ? null
            : MatchedSubstrings.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    placeId: json['place_id'] as String,
    reference: json['reference'] as String,
    structuredFormatting: json['structured_formatting'] == null
        ? null
        : StructuredFormatting.fromJson(
            json['structured_formatting'] as Map<String, dynamic>),
    terms: (json['terms'] as List)
        ?.map(
            (e) => e == null ? null : Terms.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    types: (json['types'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'description': instance.description,
      'matched_substrings':
          instance.matchedSubstrings?.map((e) => e?.toJson())?.toList(),
      'place_id': instance.placeId,
      'reference': instance.reference,
      'structured_formatting': instance.structuredFormatting?.toJson(),
      'terms': instance.terms?.map((e) => e?.toJson())?.toList(),
      'types': instance.types,
    };

MatchedSubstrings _$MatchedSubstringsFromJson(Map<String, dynamic> json) {
  return MatchedSubstrings(
    length: json['length'] as int,
    offset: json['offset'] as int,
  );
}

Map<String, dynamic> _$MatchedSubstringsToJson(MatchedSubstrings instance) =>
    <String, dynamic>{
      'length': instance.length,
      'offset': instance.offset,
    };

StructuredFormatting _$StructuredFormattingFromJson(Map<String, dynamic> json) {
  return StructuredFormatting(
    mainText: json['main_text'] as String,
    secondaryText: json['secondary_text'] as String,
  );
}

Map<String, dynamic> _$StructuredFormattingToJson(
        StructuredFormatting instance) =>
    <String, dynamic>{
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
    };

Terms _$TermsFromJson(Map<String, dynamic> json) {
  return Terms(
    offset: json['offset'] as int,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$TermsToJson(Terms instance) => <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };
