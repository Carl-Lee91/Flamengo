import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  void dispose() {
    _userIdEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
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
          const Text(
            "Login for Flamengo",
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gaps.v20,
          FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
                vertical: Sizes.size10,
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  Sizes.size14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: Sizes.size1,
                  ),
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(),
                    ),
                    Text(
                      "dddd",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
