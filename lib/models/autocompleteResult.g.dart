// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocompleteResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoCompleteResult _$AutoCompleteResultFromJson(Map<String, dynamic> json) {
  return AutoCompleteResult(
    predictions: (json['predictions'] as List)
        ?.map(
            (e) => e == null ? null : Place.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$AutoCompleteResultToJson(AutoCompleteResult instance) =>
    <String, dynamic>{
      'predictions': instance.predictions?.map((e) => e?.toJson())?.toList(),
      'status': instance.status,
    };
