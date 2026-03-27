import 'package:flamengo/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FaIcon(icon),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
