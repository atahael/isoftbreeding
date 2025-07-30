import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/splash_screen.dart';
import 'screens/accueil_screen.dart';
import 'screens/animals/mes_animaux_screen.dart';
import 'screens/vaccines/vaccines_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 🔥 Initialisation Firebase ici
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
        '/animaux': (context) => const MesAnimauxScreen(),
        '/vaccins': (context) => const VaccinsScreen(),
      },
    );
  }
}
