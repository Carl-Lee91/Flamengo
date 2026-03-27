import 'dart:async';

import 'package:flamengo/constants/function.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/passing_screen.dart';
import 'package:flamengo/screens/users/view_models/users_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.emailSignUp(
          form["email"],
          form["password"],
        );
        await users.createProfile(userCredential, form["name"]);
      },
    );
    if (state.hasError) {
      Functions.showErrorMessage(context, state.error);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PassingScreen(),
        ),
      );
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
