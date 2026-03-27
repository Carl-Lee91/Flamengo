import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  AuthCubit buildCubit() => AuthCubit(mockAuthRepository);

  group('AuthCubit', () {
    test('initial state is AuthState.initial', () {
      final cubit = buildCubit();
      expect(cubit.state, const AuthState.initial());
      cubit.close();
    });

    group('checkAuthStatus', () {
      blocTest<AuthCubit, AuthState>(
        'emits [authenticated] when user is logged in',
        setUp: () {
          when(
            () => mockAuthRepository.authStateChanges,
          ).thenAnswer((_) => Stream.value(testUser));
        },
        build: buildCubit,
        act: (cubit) => cubit.checkAuthStatus(),
        wait: const Duration(milliseconds: 100),
        expect: () => [const AuthState.authenticated(testUser)],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [unauthenticated] when user is not logged in',
        setUp: () {
          when(
            () => mockAuthRepository.authStateChanges,
          ).thenAnswer((_) => Stream.value(null));
        },
        build: buildCubit,
        act: (cubit) => cubit.checkAuthStatus(),
        wait: const Duration(milliseconds: 100),
        expect: () => [const AuthState.unauthenticated()],
      );
    });

    group('signInWithGoogle', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, authenticated] on success',
        setUp: () {
          when(
            () => mockAuthRepository.signInWithGoogle(),
          ).thenAnswer((_) async => testUser);
        },
        build: buildCubit,
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] on failure',
        setUp: () {
          when(
            () => mockAuthRepository.signInWithGoogle(),
          ).thenThrow(Exception('Google sign in failed'));
        },
        build: buildCubit,
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => [const AuthState.loading(), isA<AuthState>()],
      );
    });

    group('signInWithApple', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, authenticated] on success',
        setUp: () {
          when(
            () => mockAuthRepository.signInWithApple(),
          ).thenAnswer((_) async => testUser);
        },
        build: buildCubit,
        act: (cubit) => cubit.signInWithApple(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] on failure',
        setUp: () {
          when(
            () => mockAuthRepository.signInWithApple(),
          ).thenThrow(Exception('Apple sign in failed'));
        },
        build: buildCubit,
        act: (cubit) => cubit.signInWithApple(),
        expect: () => [const AuthState.loading(), isA<AuthState>()],
      );
    });

    group('signOut', () {
      blocTest<AuthCubit, AuthState>(
        'emits [unauthenticated] on sign out',
        setUp: () {
          when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});
        },
        build: buildCubit,
        act: (cubit) => cubit.signOut(),
        expect: () => [const AuthState.unauthenticated()],
      );
    });

    group('currentUser', () {
      test('returns null when not authenticated', () {
        final cubit = buildCubit();
        expect(cubit.currentUser, isNull);
        cubit.close();
      });

      blocTest<AuthCubit, AuthState>(
        'returns user when authenticated',
        setUp: () {
          when(
            () => mockAuthRepository.signInWithGoogle(),
          ).thenAnswer((_) async => testUser);
        },
        build: buildCubit,
        act: (cubit) => cubit.signInWithGoogle(),
        verify: (cubit) {
          expect(cubit.currentUser, testUser);
        },
      );
    });
  });
}
