import 'dart:io';

import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/users/repos/user_repo.dart';
import 'package:flamengo/screens/users/view_models/users_view_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UsersRepository _userRepo;

  @override
  FutureOr<void> build() {
    _userRepo = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _userRepo.uploadAvater(file, fileName);
        await ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
