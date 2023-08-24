import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Functions {
  static void onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showErrorMessage(BuildContext context, Object? error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text((error as FirebaseException).message ?? "Error"),
      ),
    );
  }
}
