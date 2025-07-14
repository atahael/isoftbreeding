import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/accueil_screen.dart';
import 'screens/animals/mes_animaux_screen.dart'; // <-- à créer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suivi Élevage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/accueil': (context) => const AccueilScreen(),
        '/animaux': (context) => const MesAnimauxScreen(), // <-- définie ici
      },
    );
  }
}
