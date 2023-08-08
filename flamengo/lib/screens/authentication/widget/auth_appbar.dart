import 'package:flutter/material.dart';

class AuthAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String text;
  const AuthAppbar({
    super.key,
    required this.text,
  });

  @override
  State<AuthAppbar> createState() => _AuthAppbarState();
}

class _AuthAppbarState extends State<AuthAppbar> {
  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.text),
    );
  }
}
