import 'package:freezed_annotation/freezed_annotation.dart';

part 'bucket_item.freezed.dart';
part 'bucket_item.g.dart';

@freezed
abstract class BucketItem with _$BucketItem {
  const factory BucketItem({
    required String id,
    required String name,
    required String address,
    required double lat,
    required double lng,
    required String country,
    required String city,
    required String category,
    @Default('') String memo,
    @Default(0) double rating,
    @Default(false) bool visited,
    int? visitedAt,
    required int createdAt,
    String? googlePlaceId,
  }) = _BucketItem;

  factory BucketItem.fromJson(Map<String, dynamic> json) =>
      _$BucketItemFromJson(json);
}
