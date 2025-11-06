// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/inicio_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Forzar orientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

// Colores de la paleta (Públicos y accesibles)
const Color kColorBeigeFondo = Color(0xFFF0E5D4); 
const Color kColorMarronOscuro = Color(0xFF8A5A44);
const Color kColorVerdeClaro = Color(0xFF8BC34A);
const Color kColorGrisBoton = Color(0xFF90A4AE);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Last Farm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: kColorBeigeFondo,
        fontFamily: 'PixelifySans', // Asegúrate de registrar la fuente en pubspec.yaml
        appBarTheme: const AppBarTheme(
          backgroundColor: kColorBeigeFondo,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: kColorMarronOscuro,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'PixelifySans',
          ),
          iconTheme: IconThemeData(color: kColorMarronOscuro),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: kColorVerdeClaro,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: kColorMarronOscuro, width: 3),
            ),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'PixelifySans',
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kColorMarronOscuro, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kColorMarronOscuro, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kColorVerdeClaro, width: 3),
          ),
          labelStyle: const TextStyle(color: kColorMarronOscuro, fontFamily: 'PixelifySans'),
          hintStyle: TextStyle(color: kColorMarronOscuro.withOpacity(0.6), fontFamily: 'PixelifySans'),
        ),
      ),
      home: const InicioScreen(),
    );
  }
}