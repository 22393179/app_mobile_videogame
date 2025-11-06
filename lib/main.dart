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
const Color kColorBeigeFondo = Color(0xFFFFF8E7);  // Beige más suave
const Color kColorMarronOscuro = Color(0xFF654321); // Marrón más cálido
const Color kColorVerdeClaro = Color(0xFF95C23D);   // Verde más natural
const Color kColorDorado = Color(0xFFFFB74D);       // Dorado para logros
const Color kColorGrisClaro = Color(0xFFE0E0E0);    // Gris para elementos inactivos

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
        fontFamily: 'PixelifySans',
        useMaterial3: true, // Activar Material Design 3
        appBarTheme: AppBarTheme(
          backgroundColor: kColorBeigeFondo,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: kColorMarronOscuro,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'PixelifySans',
          ),
          iconTheme: const IconThemeData(color: kColorMarronOscuro),
          // Efecto de vidrio esmerilado
          surfaceTintColor: Colors.white.withOpacity(0.1),
          shadowColor: Colors.black.withOpacity(0.1),
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