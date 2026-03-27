import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';
import 'package:flamengo/features/profile/domain/entities/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final initials = profile.displayName.isNotEmpty
        ? profile.displayName[0].toUpperCase()
        : '?';

    return Column(
      children: [
        CircleAvatar(
          radius: 48.r,
          backgroundColor: AppColors.primary,
          child: Text(
            initials,
            style: AppTypography.displayLarge.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ),
        const Gap(16),
        Text(profile.displayName, style: AppTypography.headlineMedium),
        const Gap(4),
        Text(
          profile.email,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.grey600),
        ),
      ],
    );
  }
}
