import 'package:flamengo/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:flamengo/screens/authentication/login_screen.dart';
import 'package:flamengo/screens/authentication/sign_up_screen.dart';
import 'package:flamengo/screens/greeting.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/dashboard",
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
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    ),
    GoRoute(
      path: "/:tab(dashboard|information|recommend|schedule)",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.pathParameters["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
  ],
);
