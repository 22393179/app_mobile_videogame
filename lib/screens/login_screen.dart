// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import 'registro_screen.dart';
import 'menu_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                    fontFamily: 'PixelifySans',
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // Campo de Email/Usuario
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuario o Email',
                    hintText: 'ej. nombredeusuario o email@example.com',
                    prefixIcon: Icon(Icons.person, color: kColorMarronOscuro),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.03),
                // Campo de Contraseña
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Introduce tu contraseña',
                    prefixIcon: Icon(Icons.lock, color: kColorMarronOscuro),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.05),
                // Botón Iniciar Sesión
                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MenuScreen()),
                      );
                    },
                    child: const Text('INGRESAR'),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Opción para registrarse
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistroScreen()),
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate aquí',
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