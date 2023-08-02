import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  void onTapLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapLoginScreen(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 12,
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: 300,
                    height: 300,
                    color: Colors.white,
                    child: Center(
                      child: Image.asset(
                        "assets/img/flamengo.png",
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v32,
            const Text(
              "Flamengo",
              style: TextStyle(
                fontSize: Sizes.size28,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 3.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
