import 'package:flamengo/constants/function.dart';
import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/password_screen.dart';
import 'package:flamengo/screens/authentication/view_models/signup_view_models.dart';
import 'package:flamengo/screens/authentication/widget/auth_appbar.dart';
import 'package:flamengo/screens/authentication/widget/form_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  static String routeName = "email";
  static String routeUrl = "email";

  final String username;

  const EmailScreen({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  void _onTapToPasswordScreen() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "email": _email};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Functions.onScaffoldTap(context),
      child: Scaffold(
        appBar: const AuthAppbar(text: "Write Email"),
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
                  "What is your email? ${widget.username}",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v24,
                TextField(
                  controller: _emailController,
                  onEditingComplete: _onTapToPasswordScreen,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    errorText: _isEmailValid(),
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onTapToPasswordScreen,
                  child: FormBtn(
                    disabled: _email.isEmpty || _isEmailValid() != null,
                    text: "Create password",
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
