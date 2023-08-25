import 'package:flamengo/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:flamengo/screens/authentication/login_screen.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/authentication/sign_up_screen.dart';
import 'package:flamengo/screens/greeting.dart';
import 'package:flamengo/screens/passing_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    //ref.watch(authState);
    return GoRouter(
      initialLocation: PassingScreen.routeUrl,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != SignUpScreen.routeUrl &&
              state.matchedLocation != LoginScreen.routeUrl) {
            return GreetingScreen.routeUrl;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: GreetingScreen.routeName,
          path: GreetingScreen.routeUrl,
          builder: (context, state) => const GreetingScreen(),
        ),
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeUrl,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeUrl,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: PassingScreen.routeName,
          path: PassingScreen.routeUrl,
          builder: (context, state) => const PassingScreen(),
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
  },
);
