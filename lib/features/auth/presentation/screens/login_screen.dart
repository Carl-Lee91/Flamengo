import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_state.dart';
import 'package:flamengo/features/auth/presentation/widgets/login_header.dart';
import 'package:flamengo/features/auth/presentation/widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routePath = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              AppSnackbar.show(context, message: message, isError: true);
            },
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),
                const LoginHeader(),
                const Spacer(flex: 3),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                    return _LoginButtons(isLoading: isLoading);
                  },
                ),
                const Gap(48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButtons extends StatelessWidget {
  const _LoginButtons({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          const AppLoading()
        else ...[
          SocialLoginButton.google(
            onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
          ),
          const Gap(12),
          if (Platform.isIOS)
            SocialLoginButton.apple(
              onPressed: () => context.read<AuthCubit>().signInWithApple(),
            ),
        ],
      ],
    );
  }
}
