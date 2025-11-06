// lib/screens/registro_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/thelastfarm.png', height: 40),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                    fontFamily: 'PixelifySans',
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                // Campo de Usuario
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de Usuario',
                    hintText: 'ej. agricultorValiente',
                    prefixIcon: Icon(Icons.person_add, color: kColorMarronOscuro),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Campo de Email
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'ej. tuemail@example.com',
                    prefixIcon: Icon(Icons.email, color: kColorMarronOscuro),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.03),
                // Campo de Contraseña
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Crea una contraseña segura',
                    prefixIcon: Icon(Icons.lock, color: kColorMarronOscuro),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.03),
                // Campo de Confirmar Contraseña
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    hintText: 'Repite tu contraseña',
                    prefixIcon: Icon(Icons.lock_reset, color: kColorMarronOscuro),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.05),
                // Botón Registrarse
                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('REGISTRARSE'),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Opción para volver a Login
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '¿Ya tienes cuenta? Inicia sesión',
                    style: TextStyle(
                      color: kColorMarronOscuro,
                      decoration: TextDecoration.underline,
                      fontFamily: 'PixelifySans',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}