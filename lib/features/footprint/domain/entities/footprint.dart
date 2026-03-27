import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';

part 'footprint.freezed.dart';

@freezed
abstract class FootprintData with _$FootprintData {
  const factory FootprintData({
    @Default([]) List<BucketItem> visitedItems,
    @Default({}) Map<String, List<BucketItem>> byCountry,
    @Default(0) int totalCountries,
    @Default(0) int totalCities,
  }) = _FootprintData;
}
