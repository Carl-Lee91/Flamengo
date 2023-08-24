import 'package:flamengo/constants/function.dart';
import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/view_models/login_view_model.dart';
import 'package:flamengo/screens/authentication/widget/auth_appbar.dart';
import 'package:flamengo/screens/authentication/widget/form_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onTapToMainNavigationScreen() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Functions.onScaffoldTap(context),
      child: Scaffold(
        appBar: const AuthAppbar(text: "Login"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              top: Sizes.size48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Gaps.v40,
                Text(
                  "Please Login",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v24,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Plaeas Write Your Email";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData["email"] = newValue;
                          }
                        },
                      ),
                      Gaps.v24,
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Plaeas Write Your Password";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData["password"] = newValue;
                          }
                        },
                      ),
                      Gaps.v24,
                      GestureDetector(
                        onTap: _onTapToMainNavigationScreen,
                        child: FormBtn(
                          disabled: ref.watch(loginProvider).isLoading,
                          text: "Login",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
