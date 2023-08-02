import 'package:flamengo/screens/greeting.dart';
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
        home: const GreetingScreen(),
        theme: ThemeData(
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
        ),
        darkTheme: ThemeData(
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
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
