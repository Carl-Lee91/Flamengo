import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flamengo/features/map/presentation/cubit/map_cubit.dart';
import 'package:flamengo/features/map/presentation/cubit/map_state.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockMapRepository mockMapRepository;

  setUp(() {
    mockMapRepository = MockMapRepository();
  });

  MapCubit buildCubit() => MapCubit(mockMapRepository);

  group('MapCubit', () {
    test('initial state has no position and no places', () {
      final cubit = buildCubit();
      expect(cubit.state, const MapState());
      expect(cubit.state.nearbyPlaces, isEmpty);
      expect(cubit.state.markers, isEmpty);
      expect(cubit.state.currentPosition, isNull);
      expect(cubit.state.isLoading, isFalse);
      cubit.close();
    });

    group('searchNearbyPlaces', () {
      blocTest<MapCubit, MapState>(
        'emits loading then loaded with places and markers',
        setUp: () {
          when(() => mockMapRepository.getNearbyPlaces(
                37.5665,
                126.978,
                radius: any(named: 'radius'),
                type: any(named: 'type'),
              )).thenAnswer((_) async => testPlaces);
        },
        build: buildCubit,
        act: (cubit) => cubit.searchNearbyPlaces(37.5665, 126.978),
        expect: () => [
          isA<MapState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MapState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.nearbyPlaces.length, 'places', 2)
              .having((s) => s.markers.length, 'markers', 2),
        ],
      );

      blocTest<MapCubit, MapState>(
        'emits loading then error on failure',
        setUp: () {
          when(() => mockMapRepository.getNearbyPlaces(
                any(),
                any(),
                radius: any(named: 'radius'),
                type: any(named: 'type'),
              )).thenThrow(Exception('API error'));
        },
        build: buildCubit,
        act: (cubit) => cubit.searchNearbyPlaces(37.5665, 126.978),
        expect: () => [
          isA<MapState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MapState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'error', isNotNull),
        ],
      );

      blocTest<MapCubit, MapState>(
        'emits empty places when no results',
        setUp: () {
          when(() => mockMapRepository.getNearbyPlaces(
                any(),
                any(),
                radius: any(named: 'radius'),
                type: any(named: 'type'),
              )).thenAnswer((_) async => []);
        },
        build: buildCubit,
        act: (cubit) => cubit.searchNearbyPlaces(37.5665, 126.978),
        expect: () => [
          isA<MapState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MapState>()
              .having((s) => s.nearbyPlaces, 'places', isEmpty)
              .having((s) => s.markers, 'markers', isEmpty),
        ],
      );
    });

    group('getPlaceById', () {
      test('returns place when found', () {
        final cubit = buildCubit();
        cubit.emit(MapState(nearbyPlaces: testPlaces));
        expect(cubit.getPlaceById('place-1')?.name, 'Test Restaurant');
        cubit.close();
      });

      test('returns null when not found', () {
        final cubit = buildCubit();
        cubit.emit(MapState(nearbyPlaces: testPlaces));
        expect(cubit.getPlaceById('nonexistent'), isNull);
        cubit.close();
      });
    });
  });
}
