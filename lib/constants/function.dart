import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Functions {
  static void onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showErrorMessage(BuildContext context, Object? error) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text((error as FirebaseException).message ?? "Error"),
      ),
    );
  }
}
