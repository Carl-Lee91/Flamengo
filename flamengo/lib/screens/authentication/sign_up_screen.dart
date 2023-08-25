import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/login_screen.dart';
import 'package:flamengo/screens/authentication/username_screen.dart';
import 'package:flamengo/screens/authentication/view_models/social_auth_view_model.dart';
import 'package:flamengo/screens/authentication/widget/auth_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static String routeName = "signup";
  static String routeUrl = "/signup";

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  void _onTapToLogInScreen() {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onTapToCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 12,
            child: Center(
              child: ClipOval(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      "assets/img/flamengo.png",
                      width: 180,
                      height: 180,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Gaps.v20,
          Text(
            "Sign Up for Flamengo",
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Gaps.v20,
          GestureDetector(
            onTap: _onTapToCreateAccount,
            child: const AuthButton(
              icon: FontAwesomeIcons.userCheck,
              text: 'Create Account by Email',
            ),
          ),
          GestureDetector(
            onTap: () =>
                ref.read(socialAuthProvider.notifier).googleSignIn(context),
            child: const AuthButton(
              icon: FontAwesomeIcons.google,
              text: 'Create Account by Google',
            ),
          ),
          Gaps.v10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Do you have an account?",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.h6,
              GestureDetector(
                onTap: _onTapToLogInScreen,
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
