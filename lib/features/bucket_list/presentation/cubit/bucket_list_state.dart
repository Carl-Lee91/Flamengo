import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';

part 'bucket_list_state.freezed.dart';

@freezed
abstract class BucketListState with _$BucketListState {
  const factory BucketListState({
    @Default([]) List<BucketItem> items,
    @Default([]) List<BucketItem> filteredItems,
    @Default(null) String? selectedCategory,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _BucketListState;
}
