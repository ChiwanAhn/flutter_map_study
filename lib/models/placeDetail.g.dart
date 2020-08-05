// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetail _$PlaceDetailFromJson(Map<String, dynamic> json) {
  return PlaceDetail(
    geometry: json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$PlaceDetailToJson(PlaceDetail instance) =>
    <String, dynamic>{
      'geometry': instance.geometry?.toJson(),
      'icon': instance.icon,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    viewport: json['viewport'] == null
        ? null
        : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location?.toJson(),
      'viewport': instance.viewport?.toJson(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) {
  return Viewport(
    northeast: json['northeast'] == null
        ? null
        : Location.fromJson(json['northeast'] as Map<String, dynamic>),
    southwest: json['southwest'] == null
        ? null
        : Location.fromJson(json['southwest'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast?.toJson(),
      'southwest': instance.southwest?.toJson(),
    };
