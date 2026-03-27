import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_api_response.freezed.dart';
part 'place_api_response.g.dart';

@freezed
abstract class NearbySearchResponse with _$NearbySearchResponse {
  const factory NearbySearchResponse({
    @Default([]) List<PlaceResult> results,
    String? status,
  }) = _NearbySearchResponse;

  factory NearbySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbySearchResponseFromJson(json);
}

@freezed
abstract class PlaceResult with _$PlaceResult {
  const factory PlaceResult({
    String? name,
    String? vicinity,
    @JsonKey(name: 'place_id') String? placeId,
    @JsonKey(name: 'business_status') String? businessStatus,
    PlaceGeometry? geometry,
    num? rating,
    @JsonKey(name: 'price_level') num? priceLevel,
  }) = _PlaceResult;

  factory PlaceResult.fromJson(Map<String, dynamic> json) =>
      _$PlaceResultFromJson(json);
}

@freezed
abstract class PlaceGeometry with _$PlaceGeometry {
  const factory PlaceGeometry({
    PlaceLocation? location,
  }) = _PlaceGeometry;

  factory PlaceGeometry.fromJson(Map<String, dynamic> json) =>
      _$PlaceGeometryFromJson(json);
}

@freezed
abstract class PlaceLocation with _$PlaceLocation {
  const factory PlaceLocation({
    @Default(0) double lat,
    @Default(0) double lng,
  }) = _PlaceLocation;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationFromJson(json);
}
