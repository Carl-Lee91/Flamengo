import 'package:flamengo/constants/function.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/passing_screen.dart';
import 'package:flamengo/screens/users/view_models/users_view_models.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  final googleSignInProfile = GoogleSignIn();

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> googleSignIn(BuildContext context) async {
    state = const AsyncValue.loading();

    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signUpWithGoogle();
        String googleName = "Anon";
        final googleSignInAccount = await googleSignInProfile.signIn();
        if (googleSignInAccount != null) {
          googleName = googleSignInAccount.displayName ?? "Anon";
        }
        await users.createProfile(userCredential, googleName);
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

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);
