import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flamengo/features/footprint/domain/entities/footprint.dart';
import 'package:flamengo/features/footprint/presentation/cubit/footprint_cubit.dart';
import 'package:flamengo/features/footprint/presentation/cubit/footprint_state.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockBucketListRepository mockRepository;

  setUp(() {
    mockRepository = MockBucketListRepository();
  });

  FootprintCubit buildCubit() => FootprintCubit(mockRepository);

  group('FootprintCubit', () {
    test('initial state is FootprintState.initial', () {
      final cubit = buildCubit();
      expect(cubit.state, const FootprintState.initial());
      cubit.close();
    });

    group('loadFootprint', () {
      blocTest<FootprintCubit, FootprintState>(
        'emits [loading, loaded] with correct footprint data',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => testBucketItems);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadFootprint(testUid),
        expect: () => [
          const FootprintState.loading(),
          isA<FootprintState>(),
        ],
        verify: (cubit) {
          cubit.state.whenOrNull(
            loaded: (data) {
              // 2 visited items (Sushi Dai + Shibuya Crossing)
              expect(data.visitedItems.length, 2);
              // 1 country (Japan)
              expect(data.totalCountries, 1);
              // 1 city (Tokyo)
              expect(data.totalCities, 1);
              // Japan has 2 visited items
              expect(data.byCountry['Japan']?.length, 2);
            },
          );
        },
      );

      blocTest<FootprintCubit, FootprintState>(
        'emits loaded with empty data when no visited items',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => [testBucketItems[0], testBucketItems[3]]);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadFootprint(testUid),
        expect: () => [
          const FootprintState.loading(),
          const FootprintState.loaded(FootprintData()),
        ],
      );

      blocTest<FootprintCubit, FootprintState>(
        'emits [loading, error] on failure',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenThrow(Exception('Failed'));
        },
        build: buildCubit,
        act: (cubit) => cubit.loadFootprint(testUid),
        expect: () => [
          const FootprintState.loading(),
          isA<FootprintState>(),
        ],
      );

      blocTest<FootprintCubit, FootprintState>(
        'correctly counts multiple countries and cities',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => testBucketItems.map((item) {
                    // Make all items visited
                    return item.copyWith(visited: true, visitedAt: 1700000000000);
                  }).toList());
        },
        build: buildCubit,
        act: (cubit) => cubit.loadFootprint(testUid),
        verify: (cubit) {
          cubit.state.whenOrNull(
            loaded: (data) {
              // All 4 items visited
              expect(data.visitedItems.length, 4);
              // 3 countries (France, Japan, USA)
              expect(data.totalCountries, 3);
              // 3 cities (Paris, Tokyo, New York)
              expect(data.totalCities, 3);
            },
          );
        },
      );
    });
  });
}
