import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/utils/logger.dart';
import 'package:flamengo/features/bucket_list/domain/repositories/bucket_list_repository.dart';
import 'package:flamengo/features/stats/domain/entities/user_stats.dart';
import 'package:flamengo/features/stats/presentation/cubit/stats_state.dart';

@injectable
class StatsCubit extends Cubit<StatsState> {
  StatsCubit(this._bucketListRepository) : super(const StatsState.initial());

  final BucketListRepository _bucketListRepository;

  Future<void> loadStats(String uid) async {
    emit(const StatsState.loading());
    try {
      final items = await _bucketListRepository.getAll(uid);
      final visited = items.where((i) => i.visited).toList();

      final categoryStats = <String, CategoryStat>{};
      for (final item in items) {
        final existing = categoryStats[item.category];
        categoryStats[item.category] = CategoryStat(
          total: (existing?.total ?? 0) + 1,
          visited: (existing?.visited ?? 0) + (item.visited ? 1 : 0),
        );
      }

      final countriesSet = visited.map((i) => i.country).toSet();
      final citiesSet =
          visited.map((i) => '${i.country}_${i.city}').toSet();

      log.i('[Stats] loaded: ${items.length} total, '
          '${visited.length} visited, '
          '${countriesSet.length} countries');

      emit(StatsState.loaded(UserStats(
        totalPlaces: items.length,
        visitedPlaces: visited.length,
        countries: countriesSet.length,
        cities: citiesSet.length,
        categoryStats: categoryStats,
      )));
    } catch (e, st) {
      log.e('[Stats] loadStats failed', error: e, stackTrace: st);
      emit(StatsState.error(e.toString()));
    }
  }
}
