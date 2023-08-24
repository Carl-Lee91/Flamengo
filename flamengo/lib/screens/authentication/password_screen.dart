import 'package:flamengo/constants/function.dart';
import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/view_models/signup_view_models.dart';
import 'package:flamengo/screens/authentication/widget/auth_appbar.dart';
import 'package:flamengo/screens/authentication/widget/form_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  static String routeName = "password";
  static String routeUrl = "password";

  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";

  bool _obscureText = true;

  final pattern =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  bool _isPasswordLengthValid() {
    return _password.isNotEmpty &&
        _password.length >= 8 &&
        _password.length <= 20;
  }

  bool _isPasswordPatternValid() {
    return pattern.hasMatch(_password);
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _onCleartap() {
    _passwordController.clear();
  }

  void _onTapToMainNavigationScreen() {
    if (!_isPasswordLengthValid() || !_isPasswordPatternValid()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "password": _password};
    ref.read(signUpProvider.notifier).signUp(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Functions.onScaffoldTap(context),
      child: Scaffold(
        appBar: const AuthAppbar(text: "Create Password"),
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
                  "Create password",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v24,
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  onEditingComplete: _onTapToMainNavigationScreen,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            (_obscureText == true
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash),
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: _onCleartap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                Gaps.v10,
                Text(
                  'Your password must have:',
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v8,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circleCheck,
                      size: Sizes.size16,
                      color:
                          _isPasswordLengthValid() ? Colors.green : Colors.grey,
                    ),
                    Gaps.h4,
                    const Text(
                      '8 to 20 characters',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    )
                  ],
                ),
                Gaps.v8,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circleCheck,
                      size: Sizes.size16,
                      color: _isPasswordPatternValid()
                          ? Colors.green
                          : Colors.grey,
                    ),
                    Gaps.h4,
                    const Text(
                      'Letters, numbers, and special characters',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ],
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onTapToMainNavigationScreen,
                  child: FormBtn(
                    disabled:
                        !_isPasswordLengthValid() || !_isPasswordPatternValid(),
                    text: "Create!",
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
