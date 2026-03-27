import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flamengo/features/stats/domain/entities/user_stats.dart';

part 'stats_state.freezed.dart';

@freezed
abstract class StatsState with _$StatsState {
  const factory StatsState.initial() = _Initial;
  const factory StatsState.loading() = _Loading;
  const factory StatsState.loaded(UserStats stats) = _Loaded;
  const factory StatsState.error(String message) = _Error;
}
