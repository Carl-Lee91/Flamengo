import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/login_form_screen.dart';
import 'package:flamengo/screens/authentication/view_models/social_auth_view_model.dart';
import 'package:flamengo/screens/authentication/widget/auth_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routeName = "login";
  static String routeUrl = "/login";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  void _onTapToSignUpScreen() {
    context.pop();
  }

  void _onTapToLoginFromScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
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
            "Login for Flamengo",
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Gaps.v20,
          GestureDetector(
            onTap: _onTapToLoginFromScreen,
            child: const AuthButton(
              icon: FontAwesomeIcons.userCheck,
              text: 'Log In by Email',
            ),
          ),
          GestureDetector(
            onTap: () =>
                ref.read(socialAuthProvider.notifier).googleSignIn(context),
            child: const AuthButton(
              icon: FontAwesomeIcons.google,
              text: 'Log In by Google',
            ),
          ),
          Gaps.v10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't you have an account?",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.h6,
              GestureDetector(
                onTap: _onTapToSignUpScreen,
                child: Text(
                  "Sign In",
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
