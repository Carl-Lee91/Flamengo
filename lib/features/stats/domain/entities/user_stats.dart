import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
abstract class UserStats with _$UserStats {
  const factory UserStats({
    @Default(0) int totalPlaces,
    @Default(0) int visitedPlaces,
    @Default(0) int countries,
    @Default(0) int cities,
    @Default({}) Map<String, CategoryStat> categoryStats,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}

@freezed
abstract class CategoryStat with _$CategoryStat {
  const factory CategoryStat({
    @Default(0) int total,
    @Default(0) int visited,
  }) = _CategoryStat;

  factory CategoryStat.fromJson(Map<String, dynamic> json) =>
      _$CategoryStatFromJson(json);
}
