import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/view_models/signup_view_models.dart';
import 'package:flamengo/screens/authentication/widget/form_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PassingScreen extends ConsumerStatefulWidget {
  static String routeName = "tutorial";
  static String routeUrl = "/tutorial";

  const PassingScreen({super.key});

  @override
  ConsumerState<PassingScreen> createState() => _PassingScreenState();
}

class _PassingScreenState extends ConsumerState<PassingScreen> {
  void _onEnterAppTab() {
    context.go("/dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v96,
            const Text(
              "Travel",
              style: TextStyle(
                fontSize: Sizes.size40,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            const Text(
              "More Easily!",
              style: TextStyle(
                fontSize: Sizes.size40,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            Gaps.v28,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/map.png",
                  width: 350,
                  height: 350,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
        child: GestureDetector(
          onTap: _onEnterAppTab,
          child: FormBtn(
            disabled: ref.watch(signUpProvider).isLoading,
            text: "Let's Start!",
          ),
        ),
      ),
    );
  }
}
