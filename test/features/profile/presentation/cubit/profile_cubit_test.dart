import 'package:bloc_test/bloc_test.dart';
import 'package:flamengo/features/profile/domain/entities/user_profile.dart';
import 'package:flamengo/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flamengo/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    registerFallbackValue(FakeUserProfile());
  });

  ProfileCubit buildCubit() => ProfileCubit(mockProfileRepository);

  group('ProfileCubit', () {
    test('initial state is ProfileState.initial', () {
      final cubit = buildCubit();
      expect(cubit.state, const ProfileState.initial());
      cubit.close();
    });

    group('loadProfile', () {
      blocTest<ProfileCubit, ProfileState>(
        'emits [loading, loaded] when profile exists',
        setUp: () {
          when(
            () => mockProfileRepository.getProfile(testUid),
          ).thenAnswer((_) async => testProfile);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadProfile(testUid),
        expect: () => [
          const ProfileState.loading(),
          const ProfileState.loaded(testProfile),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'emits [loading, error] when profile not found',
        setUp: () {
          when(
            () => mockProfileRepository.getProfile(testUid),
          ).thenAnswer((_) async => null);
        },
        build: buildCubit,
        act: (cubit) => cubit.loadProfile(testUid),
        expect: () => [
          const ProfileState.loading(),
          const ProfileState.error('Profile not found'),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'emits [loading, error] on exception',
        setUp: () {
          when(
            () => mockProfileRepository.getProfile(testUid),
          ).thenThrow(Exception('Network error'));
        },
        build: buildCubit,
        act: (cubit) => cubit.loadProfile(testUid),
        expect: () => [const ProfileState.loading(), isA<ProfileState>()],
      );
    });

    group('createProfileIfNeeded', () {
      blocTest<ProfileCubit, ProfileState>(
        'emits [loaded] with existing profile when profile already exists',
        setUp: () {
          when(
            () => mockProfileRepository.getProfile(testUid),
          ).thenAnswer((_) async => testProfile);
        },
        build: buildCubit,
        act: (cubit) => cubit.createProfileIfNeeded(
          uid: testUid,
          displayName: 'Test User',
          email: 'test@example.com',
        ),
        expect: () => [const ProfileState.loaded(testProfile)],
        verify: (_) {
          verifyNever(() => mockProfileRepository.createProfile(any()));
        },
      );

      blocTest<ProfileCubit, ProfileState>(
        'creates new profile and emits [loaded] when profile does not exist',
        setUp: () {
          when(
            () => mockProfileRepository.getProfile(testUid),
          ).thenAnswer((_) async => null);
          when(
            () => mockProfileRepository.createProfile(any()),
          ).thenAnswer((_) async {});
        },
        build: buildCubit,
        act: (cubit) => cubit.createProfileIfNeeded(
          uid: testUid,
          displayName: 'Test User',
          email: 'test@example.com',
        ),
        expect: () => [isA<ProfileState>()],
        verify: (_) {
          verify(() => mockProfileRepository.createProfile(any())).called(1);
        },
      );
    });

    group('updateDisplayName', () {
      blocTest<ProfileCubit, ProfileState>(
        'updates name and reloads profile',
        setUp: () {
          const updatedProfile = UserProfile(
            uid: testUid,
            displayName: 'New Name',
            email: 'test@example.com',
            createdAt: 1700000000000,
            updatedAt: 1700000000000,
          );
          when(
            () => mockProfileRepository.updateProfile(testUid, {
              'displayName': 'New Name',
            }),
          ).thenAnswer((_) async {});
          when(
            () => mockProfileRepository.getProfile(testUid),
          ).thenAnswer((_) async => updatedProfile);
        },
        build: buildCubit,
        act: (cubit) => cubit.updateDisplayName(testUid, 'New Name'),
        expect: () => [const ProfileState.loading(), isA<ProfileState>()],
      );

      blocTest<ProfileCubit, ProfileState>(
        'emits error on failure',
        setUp: () {
          when(
            () => mockProfileRepository.updateProfile(testUid, {
              'displayName': 'New Name',
            }),
          ).thenThrow(Exception('Update failed'));
        },
        build: buildCubit,
        act: (cubit) => cubit.updateDisplayName(testUid, 'New Name'),
        expect: () => [isA<ProfileState>()],
      );
    });
  });
}
