import 'dart:async';

import 'package:flamengo/screens/users/models/users_profile_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
