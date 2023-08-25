import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/users/models/users_profile_models.dart';
import 'package:flamengo/screens/users/repos/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UsersProfileModel> {
  late final UsersRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UsersProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.findProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UsersProfileModel.fromJson(profile);
      }
    }

    return UsersProfileModel.empty();
  }

  Future<void> createProfile(UserCredential userCredential, String name) async {
    if (userCredential.user == null) {
      throw Exception("Account not created yet.");
    }
    state = const AsyncValue.loading();
    final profile = UsersProfileModel(
      email: userCredential.user!.email ?? "anonymous@anonymous.com",
      name: name,
      uid: userCredential.user!.uid,
    );
    await _userRepo.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UsersProfileModel>(
  () => UsersViewModel(),
);
