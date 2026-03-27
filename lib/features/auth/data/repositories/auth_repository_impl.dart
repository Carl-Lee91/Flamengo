import 'package:injectable/injectable.dart';

import 'package:flamengo/features/auth/domain/entities/app_user.dart';
import 'package:flamengo/features/auth/domain/repositories/auth_repository.dart';
import 'package:flamengo/features/auth/data/datasources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSource _dataSource;

  @override
  AppUser? get currentUser {
    final user = _dataSource.currentUser;
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'Traveler',
    );
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return _dataSource.authStateChanges.map((user) {
      if (user == null) return null;
      return AppUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? 'Traveler',
      );
    });
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    final credential = await _dataSource.signInWithGoogle();
    final user = credential.user!;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'Traveler',
    );
  }

  @override
  Future<AppUser> signInWithApple() async {
    final credential = await _dataSource.signInWithApple();
    final user = credential.user!;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'Traveler',
    );
  }

  @override
  Future<void> signOut() => _dataSource.signOut();
}
