import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(80.h),
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            Icons.travel_explore,
            size: 56.w,
            color: AppColors.onPrimary,
          ),
        ),
        const Gap(24),
        Text(
          'Flamengo',
          style: AppTypography.displayLarge.copyWith(
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
        const Gap(8),
        Text(
          'Your Travel Bucket List',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }
}
