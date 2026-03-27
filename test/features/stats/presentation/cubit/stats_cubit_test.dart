import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flamengo/features/stats/domain/entities/user_stats.dart';
import 'package:flamengo/features/stats/presentation/cubit/stats_cubit.dart';
import 'package:flamengo/features/stats/presentation/cubit/stats_state.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockBucketListRepository mockRepository;

  setUp(() {
    mockRepository = MockBucketListRepository();
  });

  StatsCubit buildCubit() => StatsCubit(mockRepository);

  group('StatsCubit', () {
    test('initial state is StatsState.initial', () {
      final cubit = buildCubit();
      expect(cubit.state, const StatsState.initial());
      cubit.close();
    });

    group('loadStats', () {
      blocTest<StatsCubit, StatsState>(
        'emits [loading, loaded] with correct stats',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => testBucketItems);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadStats(testUid),
        expect: () => [
          const StatsState.loading(),
          isA<StatsState>(),
        ],
        verify: (cubit) {
          cubit.state.whenOrNull(
            loaded: (stats) {
              expect(stats.totalPlaces, 4);
              expect(stats.visitedPlaces, 2);
              // visited: Japan only
              expect(stats.countries, 1);
              expect(stats.cities, 1);
              // category stats
              expect(stats.categoryStats['culture']?.total, 2);
              expect(stats.categoryStats['culture']?.visited, 1);
              expect(stats.categoryStats['food']?.total, 1);
              expect(stats.categoryStats['food']?.visited, 1);
              expect(stats.categoryStats['nature']?.total, 1);
              expect(stats.categoryStats['nature']?.visited, 0);
            },
          );
        },
      );

      blocTest<StatsCubit, StatsState>(
        'emits loaded with zero stats when no items',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => []);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadStats(testUid),
        expect: () => [
          const StatsState.loading(),
          const StatsState.loaded(UserStats()),
        ],
      );

      blocTest<StatsCubit, StatsState>(
        'emits [loading, error] on failure',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenThrow(Exception('DB error'));
        },
        build: buildCubit,
        act: (cubit) => cubit.loadStats(testUid),
        expect: () => [
          const StatsState.loading(),
          isA<StatsState>(),
        ],
      );

      blocTest<StatsCubit, StatsState>(
        'correctly calculates all visited scenario',
        setUp: () {
          when(() => mockRepository.getAll(testUid)).thenAnswer(
            (_) async => testBucketItems.map((item) {
              return item.copyWith(visited: true, visitedAt: 1700000000000);
            }).toList(),
          );
        },
        build: buildCubit,
        act: (cubit) => cubit.loadStats(testUid),
        verify: (cubit) {
          cubit.state.whenOrNull(
            loaded: (stats) {
              expect(stats.totalPlaces, 4);
              expect(stats.visitedPlaces, 4);
              expect(stats.countries, 3); // France, Japan, USA
              expect(stats.cities, 3); // Paris, Tokyo, New York
            },
          );
        },
      );
    });
  });
}
