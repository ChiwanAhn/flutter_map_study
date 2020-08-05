import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'placeDetail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PlaceDetail {
  PlaceDetail({
    this.geometry,
    this.icon,
  });

  Geometry geometry;
  String icon;

  factory PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  LatLng get latlng => LatLng(this.lat, this.lng);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);

  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}
