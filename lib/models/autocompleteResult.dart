import 'package:json_annotation/json_annotation.dart';
import 'package:map_study/models/place.dart';

part 'autocompleteResult.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AutoCompleteResult {
  AutoCompleteResult({
    this.predictions,
    this.status,
  });

  List<Place> predictions;
  String status;

  factory AutoCompleteResult.fromJson(Map<String, dynamic> json) =>
      _$AutoCompleteResultFromJson(json);

  Map<String, dynamic> toJson() => _$AutoCompleteResultToJson(this);
}
