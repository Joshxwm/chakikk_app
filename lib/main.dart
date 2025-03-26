import 'package:chakikk_app/Start/HomeScreen.dart';
import 'package:chakikk_app/Start/OnboardingScreen.dart';
import 'package:chakikk_app/Start/logScreen.dart';
import 'package:chakikk_app/UI/Account/loginScreen.dart';
import 'package:chakikk_app/UI/Account/regScreen.dart';
import 'package:chakikk_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chak iik’',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 113, 192, 216),
        ),
        useMaterial3: true,
      ),
      routerConfig: _router, // Configuración del enrutador
      debugShowCheckedModeBanner: false,
    );
  }
}

// Configuración de GoRouter
final GoRouter _router = GoRouter(
  initialLocation: '/log',
  routes: [
    GoRoute(path: '/log', builder: (context, state) => const LogScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
