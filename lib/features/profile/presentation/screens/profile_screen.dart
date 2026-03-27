import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flamengo/features/profile/presentation/cubit/profile_state.dart';
import 'package:flamengo/features/profile/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const AppLoading(),
            loaded: (profile) => SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Gap(24),
                  ProfileHeader(profile: profile),
                  const Gap(32),
                ],
              ),
            ),
            error: (message) => AppErrorState(
              message: message,
              onRetry: () {},
            ),
          );
        },
      ),
    );
  }
}
