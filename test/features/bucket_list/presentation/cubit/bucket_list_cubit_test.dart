import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_cubit.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_state.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockBucketListRepository mockRepository;

  setUp(() {
    mockRepository = MockBucketListRepository();
    registerFallbackValue(FakeBucketItem());
  });

  BucketListCubit buildCubit() => BucketListCubit(mockRepository);

  group('BucketListCubit', () {
    test('initial state has empty lists and no loading', () {
      final cubit = buildCubit();
      expect(cubit.state, const BucketListState());
      expect(cubit.state.items, isEmpty);
      expect(cubit.state.filteredItems, isEmpty);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.selectedCategory, isNull);
      cubit.close();
    });

    group('loadItems', () {
      blocTest<BucketListCubit, BucketListState>(
        'emits loading then loaded with items',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => testBucketItems);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadItems(testUid),
        expect: () => [
          const BucketListState(isLoading: true),
          BucketListState(
            items: testBucketItems,
            filteredItems: testBucketItems,
          ),
        ],
      );

      blocTest<BucketListCubit, BucketListState>(
        'emits loading then error on failure',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenThrow(Exception('Failed to load'));
        },
        build: buildCubit,
        act: (cubit) => cubit.loadItems(testUid),
        expect: () => [
          const BucketListState(isLoading: true),
          isA<BucketListState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BucketListCubit, BucketListState>(
        'emits empty lists when no items exist',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => []);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadItems(testUid),
        expect: () => [
          const BucketListState(isLoading: true),
          const BucketListState(),
        ],
      );
    });

    group('filterByCategory', () {
      final seedState = BucketListState(
        items: testBucketItems,
        filteredItems: testBucketItems,
      );

      blocTest<BucketListCubit, BucketListState>(
        'filters items by food category',
        build: buildCubit,
        seed: () => seedState,
        act: (cubit) => cubit.filterByCategory('food'),
        expect: () => [
          isA<BucketListState>()
              .having((s) => s.selectedCategory, 'category', 'food')
              .having((s) => s.filteredItems.length, 'count', 1)
              .having(
                  (s) => s.filteredItems.first.name, 'name', 'Sushi Dai'),
        ],
      );

      blocTest<BucketListCubit, BucketListState>(
        'filters items by culture category',
        build: buildCubit,
        seed: () => seedState,
        act: (cubit) => cubit.filterByCategory('culture'),
        expect: () => [
          isA<BucketListState>()
              .having((s) => s.selectedCategory, 'category', 'culture')
              .having((s) => s.filteredItems.length, 'count', 2),
        ],
      );

      blocTest<BucketListCubit, BucketListState>(
        'shows all items when filter is null',
        build: buildCubit,
        seed: () => seedState.copyWith(
          selectedCategory: 'food',
          filteredItems: testBucketItems
              .where((i) => i.category == 'food')
              .toList(),
        ),
        act: (cubit) => cubit.filterByCategory(null),
        expect: () => [
          isA<BucketListState>()
              .having((s) => s.selectedCategory, 'category', isNull)
              .having((s) => s.filteredItems.length, 'count',
                  testBucketItems.length),
        ],
      );

      blocTest<BucketListCubit, BucketListState>(
        'returns empty when no items match category',
        build: buildCubit,
        seed: () => seedState,
        act: (cubit) => cubit.filterByCategory('nightlife'),
        expect: () => [
          isA<BucketListState>()
              .having((s) => s.filteredItems, 'filtered', isEmpty),
        ],
      );
    });

    group('addItem', () {
      final newItem = BucketItem(
        id: 'item-new',
        name: 'New Place',
        address: '789 New St',
        lat: 0,
        lng: 0,
        country: 'Korea',
        city: 'Seoul',
        category: 'food',
        createdAt: 1700000000000,
      );

      blocTest<BucketListCubit, BucketListState>(
        'adds item and reloads list',
        setUp: () {
          when(() => mockRepository.addItem(testUid, any()))
              .thenAnswer((_) async {});
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => [...testBucketItems, newItem]);
        },
        build: buildCubit,
        act: (cubit) async {
          await cubit.loadItems(testUid);
          await cubit.addItem(newItem);
        },
        verify: (_) {
          verify(() => mockRepository.addItem(testUid, any())).called(1);
          verify(() => mockRepository.getAll(testUid)).called(2);
        },
      );

      blocTest<BucketListCubit, BucketListState>(
        'does nothing when uid is null',
        build: buildCubit,
        act: (cubit) => cubit.addItem(newItem),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepository.addItem(any(), any()));
        },
      );
    });

    group('markVisited', () {
      blocTest<BucketListCubit, BucketListState>(
        'marks item as visited and reloads',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => testBucketItems);
          when(() => mockRepository.updateItem(testUid, any()))
              .thenAnswer((_) async {});
        },
        build: buildCubit,
        act: (cubit) async {
          await cubit.loadItems(testUid);
          await cubit.markVisited('item-1', 4.0, 'Great place!');
        },
        verify: (_) {
          verify(() => mockRepository.updateItem(testUid, any())).called(1);
        },
      );
    });

    group('deleteItem', () {
      blocTest<BucketListCubit, BucketListState>(
        'deletes item and reloads',
        setUp: () {
          when(() => mockRepository.getAll(testUid))
              .thenAnswer((_) async => testBucketItems);
          when(() => mockRepository.deleteItem(testUid, 'item-1'))
              .thenAnswer((_) async {});
        },
        build: buildCubit,
        act: (cubit) async {
          await cubit.loadItems(testUid);
          await cubit.deleteItem('item-1');
        },
        verify: (_) {
          verify(() => mockRepository.deleteItem(testUid, 'item-1')).called(1);
        },
      );

      blocTest<BucketListCubit, BucketListState>(
        'does nothing when uid is null',
        build: buildCubit,
        act: (cubit) => cubit.deleteItem('item-1'),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepository.deleteItem(any(), any()));
        },
      );
    });
  });
}
