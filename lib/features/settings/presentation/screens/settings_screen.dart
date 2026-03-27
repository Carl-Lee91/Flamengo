import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/settings/presentation/widgets/logout_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: Text('Logout', style: AppTypography.bodyLarge),
            onTap: () async {
              final confirmed = await LogoutDialog.show(context);
              if (confirmed == true && context.mounted) {
                await context.read<AuthCubit>().signOut();
              }
            },
          ),
          const Divider(),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final version = snapshot.data?.version ?? '';
              final buildNumber = snapshot.data?.buildNumber ?? '';
              return ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text('App Version', style: AppTypography.bodyLarge),
                subtitle: Text('v$version ($buildNumber)'),
              );
            },
          ),
        ],
      ),
    );
  }
}
