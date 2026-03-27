import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/domain/repositories/bucket_list_repository.dart';
import 'package:flamengo/features/footprint/domain/entities/footprint.dart';
import 'package:flamengo/features/footprint/presentation/cubit/footprint_state.dart';

@injectable
class FootprintCubit extends Cubit<FootprintState> {
  FootprintCubit(this._bucketListRepository)
      : super(const FootprintState.initial());

  final BucketListRepository _bucketListRepository;

  Future<void> loadFootprint(String uid) async {
    emit(const FootprintState.loading());
    try {
      final allItems = await _bucketListRepository.getAll(uid);
      final visited = allItems.where((item) => item.visited).toList();

      final byCountry = <String, List<BucketItem>>{};
      for (final item in visited) {
        byCountry.putIfAbsent(item.country, () => []).add(item);
      }

      final totalCities =
          visited.map((item) => '${item.country}_${item.city}').toSet().length;

      emit(FootprintState.loaded(FootprintData(
        visitedItems: visited,
        byCountry: byCountry,
        totalCountries: byCountry.keys.length,
        totalCities: totalCities,
      )));
    } catch (e) {
      emit(FootprintState.error(e.toString()));
    }
  }
}
