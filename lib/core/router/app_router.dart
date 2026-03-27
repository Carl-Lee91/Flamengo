import 'package:go_router/go_router.dart';

import 'package:flamengo/features/auth/domain/repositories/auth_repository.dart';
import 'package:flamengo/features/auth/presentation/screens/login_screen.dart';
import 'package:flamengo/features/bucket_list/presentation/screens/add_bucket_item_screen.dart';
import 'package:flamengo/features/bucket_list/presentation/screens/bucket_item_detail_screen.dart';
import 'package:flamengo/features/bucket_list/presentation/screens/bucket_list_screen.dart';
import 'package:flamengo/features/footprint/presentation/screens/footprint_screen.dart';
import 'package:flamengo/features/map/presentation/screens/map_screen.dart';
import 'package:flamengo/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flamengo/features/profile/presentation/screens/profile_screen.dart';
import 'package:flamengo/features/settings/presentation/screens/settings_screen.dart';
import 'package:flamengo/features/stats/presentation/screens/stats_screen.dart';
import 'package:flamengo/shell/main_shell_screen.dart';
import 'package:flamengo/core/router/route_names.dart';

GoRouter createRouter(AuthRepository authRepository) {
  return GoRouter(
    initialLocation: RoutePaths.bucketList,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final isLoginRoute = state.matchedLocation == RoutePaths.login;

      if (!isLoggedIn && !isLoginRoute) return RoutePaths.login;
      if (isLoggedIn && isLoginRoute) return RoutePaths.bucketList;
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          // Bucket List tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.bucketList,
                builder: (context, state) => const BucketListScreen(),
                routes: [
                  GoRoute(
                    path: 'add',
                    builder: (context, state) => const AddBucketItemScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return BucketItemDetailScreen(itemId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Map tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.map,
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),
          // Footprint tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.footprint,
                builder: (context, state) => const FootprintScreen(),
              ),
            ],
          ),
          // Stats tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.stats,
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
          // Profile tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Settings (outside shell - full screen)
      GoRoute(
        path: RoutePaths.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
