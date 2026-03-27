import 'package:flamengo/constants/sizes.dart';
import 'package:flutter/material.dart';

class FormBtn extends StatelessWidget {
  const FormBtn({
    super.key,
    required this.disabled,
    required this.text,
  });

  final bool disabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color:
              disabled ? Colors.grey.shade200 : Theme.of(context).primaryColor,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
