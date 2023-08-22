import 'package:flamengo/screens/authentication/login_screen.dart';
import 'package:flamengo/screens/authentication/password_screen.dart';
import 'package:flamengo/screens/authentication/sign_up_screen.dart';
import 'package:flamengo/screens/authentication/username_screen.dart';
import 'package:flamengo/screens/dashboard/dashboard_tab.dart';
import 'package:flamengo/screens/greeting.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: GreetingScreen.routeName,
      path: GreetingScreen.routeUrl,
      builder: (context, state) => const GreetingScreen(),
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeUrl,
          builder: (context, state) => const SignUpScreen(),
          routes: [
            GoRoute(
              name: UsernameScreen.routeName,
              path: UsernameScreen.routeUrl,
              builder: (context, state) => const UsernameScreen(),
              routes: [
                GoRoute(
                  name: PasswordScreen.routeName,
                  path: PasswordScreen.routeUrl,
                  builder: (context, state) {
                    final args = state.extra as PasswordScreenArgs;
                    return PasswordScreen(username: args.username);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.pathParameters["username"];
        return DashBoardScreen(username: username!);
      },
    ),
  ],
);
