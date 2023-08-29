import 'package:firebase_core/firebase_core.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/firebase_options.dart';
import 'package:flamengo/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        debugShowCheckedModeBanner: true,
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
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>(
              (states) => const IconThemeData(
                color: Colors.white,
              ),
            ),
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
              color: Colors.grey.shade300,
            ),
            color: const Color(0xFFF93A5B),
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w900,
              fontSize: Sizes.size24,
              letterSpacing: 2.0,
            ),
          ),
          useMaterial3: true,
          textTheme: Typography.whiteCupertino,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade800,
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
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>(
              (states) => IconThemeData(
                color: Colors.grey.shade300,
              ),
            ),
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
