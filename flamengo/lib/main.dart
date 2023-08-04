import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/mainnavigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            color: Color(0xFFF93A5B),
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: Sizes.size24,
              letterSpacing: 2.0,
            ),
          ),
          useMaterial3: true,
          textTheme: Typography.blackCupertino,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          primaryColor: const Color(0xFFF93A5B),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(
              0xFFF93A5B,
            ),
          ),
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.grey.shade700,
            ),
            color: const Color(0xFFF93A5B),
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w900,
              fontSize: Sizes.size24,
              letterSpacing: 2.0,
            ),
          ),
          useMaterial3: true,
          textTheme: Typography.whiteCupertino,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          primaryColor: const Color(0xFFF93A5B),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(
              0xFFF93A5B,
            ),
          ),
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
