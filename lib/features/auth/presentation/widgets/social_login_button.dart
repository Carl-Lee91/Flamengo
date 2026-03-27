import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.onBackground,
    this.borderColor,
  });

  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  factory SocialLoginButton.google({required VoidCallback onPressed}) {
    return SocialLoginButton(
      text: 'Continue with Google',
      icon: Image.network(
        'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
        width: 24,
        height: 24,
        errorBuilder: (_, e, st) => const Icon(Icons.g_mobiledata, size: 24),
      ),
      onPressed: onPressed,
      backgroundColor: Colors.white,
      borderColor: AppColors.grey300,
    );
  }

  factory SocialLoginButton.apple({required VoidCallback onPressed}) {
    return SocialLoginButton(
      text: 'Continue with Apple',
      icon: const Icon(Icons.apple, size: 24, color: Colors.white),
      onPressed: onPressed,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(
            color: borderColor ?? backgroundColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const Gap(12),
            Text(text, style: AppTypography.labelLarge.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}
