import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'menu_screen.dart';
import 'registro_screen.dart';
import '../main.dart'; // Colores globales
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  // --- VALIDACIONES Y MENSAJES BONITOS ---
  void _showMessage(String message, {bool error = false}) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(fontFamily: 'PixelifySans')),
      backgroundColor: error ? Colors.redAccent : kColorVerdeClaro,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // --- VALIDACIÓN DE CAMPOS VACÍOS ---
    if (email.isEmpty || password.isEmpty) {
      _showMessage("Por favor, ingresa tu email y contraseña", error: true);
      return;
    }

    setState(() => _loading = true);

    try {
      final url = Uri.parse('$apiBaseUrl/auth/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      setState(() => _loading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['idToken'] == null || data['uid'] == null) {
          _showMessage("No se recibieron los datos de usuario, intenta de nuevo", error: true);
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('idToken', data['idToken']);
        await prefs.setString('uid', data['uid']);

        _showMessage("¡Bienvenido de nuevo, ${email.split('@')[0]}!");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MenuScreen()),
        );
      } else {
        final data = jsonDecode(response.body);
        final errorMsg = data['error'] ?? "Email o contraseña incorrectos";
        _showMessage(errorMsg, error: true);
      }
    } catch (e) {
      setState(() => _loading = false);
      _showMessage("No se pudo conectar al servidor. Revisa tu conexión", error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kColorBeigeFondo,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- LOGO ---
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kColorDorado.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/thelastfarm.png',
                    height: screenHeight * 0.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // --- TÍTULO ---
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // --- EMAIL ---
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: kColorMarronOscuro.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.email_outlined, color: kColorMarronOscuro),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: kColorMarronOscuro, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // --- CONTRASEÑA ---
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: kColorMarronOscuro.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.lock_outline, color: kColorMarronOscuro),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: kColorMarronOscuro, width: 2),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.05),

                // --- BOTÓN LOGIN ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorMarronOscuro,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: _loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                          )
                        : const Text(
                            'INGRESAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),

                // --- LINK A REGISTRO ---
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistroScreen(),
                    ),
                  ),
                  child: Text(
                    '¿No tienes cuenta? Regístrate aquí',
                    style: TextStyle(color: kColorMarronOscuro.withOpacity(0.9)),
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
