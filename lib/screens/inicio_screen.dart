// lib/screens/inicio_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import 'login_screen.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            decoration: BoxDecoration(
              border: Border.all(color: kColorMarronOscuro, width: 8.0), 
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // LOGO
                Image.asset(
                  'assets/images/thelastfarm.png', 
                  height: screenHeight * 0.25,
                ),
                SizedBox(height: screenHeight * 0.08),
                // Botón INICIO
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('INICIO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}