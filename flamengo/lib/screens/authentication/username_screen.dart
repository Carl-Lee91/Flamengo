import 'package:flamengo/constants/function.dart';
import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/password_screen.dart';
import 'package:flamengo/screens/authentication/widget/auth_appbar.dart';
import 'package:flamengo/screens/authentication/widget/form_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  static String routeName = "username";
  static String routeUrl = "username";
  const UsernameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  String? _isUsernameValid() {
    if (_username.isEmpty) return null;
    final regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]");
    if (!regExp.hasMatch(_username)) {
      return "Username not valid";
    }
    return null;
  }

  void _onTapToPasswordScreen() {
    if (_username.isEmpty) return;
    context.pushNamed(
      PasswordScreen.routeName,
      extra: PasswordScreenArgs(username: _username),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Functions.onScaffoldTap(context),
      child: Scaffold(
        appBar: const AuthAppbar(text: "Create Username"),
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
                  "Create username",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v24,
                TextField(
                  controller: _usernameController,
                  onEditingComplete: _onTapToPasswordScreen,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    errorText: _isUsernameValid(),
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onTapToPasswordScreen,
                  child: FormBtn(
                    disabled: _username.isEmpty || _isUsernameValid() != null,
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
