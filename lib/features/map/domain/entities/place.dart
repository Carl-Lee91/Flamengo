import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';

@freezed
abstract class Place with _$Place {
  const factory Place({
    required String name,
    required String address,
    required String placeId,
    required double lat,
    required double lng,
    String? businessStatus,
    @Default(0) double rating,
    @Default(0) int priceLevel,
  }) = _Place;
}
