import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/utils/logger.dart';
import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/domain/repositories/bucket_list_repository.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_state.dart';

@injectable
class BucketListCubit extends Cubit<BucketListState> {
  BucketListCubit(this._repository) : super(const BucketListState());

  final BucketListRepository _repository;
  String? _uid;

  Future<void> loadItems(String uid) async {
    _uid = uid;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final items = await _repository.getAll(uid);
      log.i('[BucketList] loaded ${items.length} items');
      emit(state.copyWith(
        items: items,
        filteredItems: _applyFilter(items, state.selectedCategory),
        isLoading: false,
      ));
    } catch (e, st) {
      log.e('[BucketList] loadItems failed', error: e, stackTrace: st);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void filterByCategory(String? category) {
    log.i('[BucketList] filter: ${category ?? 'all'}');
    emit(state.copyWith(
      selectedCategory: category,
      filteredItems: _applyFilter(state.items, category),
    ));
  }

  Future<void> addItem(BucketItem item) async {
    if (_uid == null) return;
    try {
      await _repository.addItem(_uid!, item);
      log.i('[BucketList] added: ${item.name}');
      await loadItems(_uid!);
    } catch (e, st) {
      log.e('[BucketList] addItem failed', error: e, stackTrace: st);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> markVisited(String itemId, double rating, String memo) async {
    if (_uid == null) return;
    try {
      final item = state.items.firstWhere((i) => i.id == itemId);
      final updated = item.copyWith(
        visited: true,
        visitedAt: DateTime.now().millisecondsSinceEpoch,
        rating: rating,
        memo: memo,
      );
      await _repository.updateItem(_uid!, updated);
      log.i('[BucketList] markVisited: ${item.name} (rating: $rating)');
      await loadItems(_uid!);
    } catch (e, st) {
      log.e('[BucketList] markVisited failed', error: e, stackTrace: st);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteItem(String itemId) async {
    if (_uid == null) return;
    try {
      await _repository.deleteItem(_uid!, itemId);
      log.i('[BucketList] deleted: $itemId');
      await loadItems(_uid!);
    } catch (e, st) {
      log.e('[BucketList] deleteItem failed', error: e, stackTrace: st);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  List<BucketItem> _applyFilter(List<BucketItem> items, String? category) {
    if (category == null) return items;
    return items.where((item) => item.category == category).toList();
  }
}
