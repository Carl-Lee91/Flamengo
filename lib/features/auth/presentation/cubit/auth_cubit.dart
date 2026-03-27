import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/utils/logger.dart';
import 'package:flamengo/features/auth/domain/entities/app_user.dart';
import 'package:flamengo/features/auth/domain/repositories/auth_repository.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.initial());

  final AuthRepository _authRepository;
  StreamSubscription? _authSubscription;

  void checkAuthStatus() {
    _authSubscription?.cancel();
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        log.i('[Auth] authenticated: ${user.email}');
        emit(AuthState.authenticated(user));
      } else {
        log.i('[Auth] unauthenticated');
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.signInWithGoogle();
      log.i('[Auth] Google sign-in success: ${user.email}');
      emit(AuthState.authenticated(user));
    } catch (e, st) {
      log.e('[Auth] Google sign-in failed', error: e, stackTrace: st);
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signInWithApple() async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.signInWithApple();
      log.i('[Auth] Apple sign-in success: ${user.email}');
      emit(AuthState.authenticated(user));
    } catch (e, st) {
      log.e('[Auth] Apple sign-in failed', error: e, stackTrace: st);
      emit(AuthState.error(e.toString()));
    }
  }

  /// Returns the current authenticated user, or null if not authenticated.
  AppUser? get currentUser => state.whenOrNull(
        authenticated: (user) => user,
      );

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      log.i('[Auth] signed out');
      emit(const AuthState.unauthenticated());
    } catch (e, st) {
      log.e('[Auth] sign-out failed', error: e, stackTrace: st);
      emit(const AuthState.unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
