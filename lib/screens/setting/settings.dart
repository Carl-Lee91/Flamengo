import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Log Out"),
            textColor: Theme.of(context).primaryColor,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are You Sure?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          ref.read(authRepo).signOut();
                          context.go("/");
                        },
                        child: const Text("Yes"))
                  ],
                ),
              );
            },
          ),
          const AboutListTile(
            applicationVersion: "1.0",
          )
        ],
      ),
    );
  }
}
