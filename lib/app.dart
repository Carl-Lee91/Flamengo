import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:flamengo/core/di/injection.dart';
import 'package:flamengo/core/router/app_router.dart';
import 'package:flamengo/design_system/theme/app_theme.dart';
import 'package:flamengo/features/auth/domain/repositories/auth_repository.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_state.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_cubit.dart';
import 'package:flamengo/features/footprint/presentation/cubit/footprint_cubit.dart';
import 'package:flamengo/features/map/presentation/cubit/map_cubit.dart';
import 'package:flamengo/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flamengo/features/stats/presentation/cubit/stats_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter(getIt<AuthRepository>());
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<AuthCubit>()..checkAuthStatus(),
            ),
            BlocProvider(create: (_) => getIt<ProfileCubit>()),
            BlocProvider(create: (_) => getIt<BucketListCubit>()),
            BlocProvider(create: (_) => getIt<MapCubit>()),
            BlocProvider(create: (_) => getIt<FootprintCubit>()),
            BlocProvider(create: (_) => getIt<StatsCubit>()),
          ],
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              // Create profile on first login
              final user = context.read<AuthCubit>().currentUser;
              if (user != null) {
                context.read<ProfileCubit>().createProfileIfNeeded(
                      uid: user.uid,
                      displayName: user.displayName,
                      email: user.email,
                    );
              }
            },
            child: MaterialApp.router(
              title: 'Flamengo',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              routerConfig: _router,
            ),
          ),
        );
      },
    );
  }
}
