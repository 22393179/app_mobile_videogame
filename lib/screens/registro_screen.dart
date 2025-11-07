import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../main.dart'; // Colores globales

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;

  // --- MENSAJES BONITOS ---
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

  // --- REGISTRO ---
  Future<void> _registrarUsuario() async {
    final nombre = _usuarioController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    // --- VALIDACIONES ---
    if (nombre.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showMessage("Por favor, completa todos los campos", error: true);
      return;
    }

    if (password != confirm) {
      _showMessage("❌ Las contraseñas no coinciden", error: true);
      return;
    }

    setState(() => _loading = true);

    try {
      final url = Uri.parse('$apiBaseUrl/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "displayName": nombre,
        }),
      );

      setState(() => _loading = false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showMessage("✅ Registro exitoso, ahora ingresa con tus credenciales");

        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted) Navigator.pop(context);
      } else {
        final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        final errorMsg = body['error'] ?? "Error al registrar usuario";
        _showMessage("⚠️ $errorMsg", error: true);
      }
    } catch (e) {
      setState(() => _loading = false);
      _showMessage("Error de conexión o servidor: $e", error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kColorBeigeFondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Botón para volver
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: kColorMarronOscuro),
                  onPressed: () {
                    if (!_loading) Navigator.of(context).pop();
                  },
                ),
              ),

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
                  height: screenHeight * 0.15,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // --- TÍTULO ---
              Text(
                'Crear Cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kColorMarronOscuro,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // --- NOMBRE ---
              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  labelStyle: TextStyle(color: kColorMarronOscuro.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.person_outline, color: kColorMarronOscuro),
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
                obscureText: true,
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
              ),
              SizedBox(height: screenHeight * 0.02),

              // --- CONFIRMAR CONTRASEÑA ---
              TextField(
                controller: _confirmController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
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
              ),
              SizedBox(height: screenHeight * 0.04),

              // --- BOTÓN REGISTRARSE ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _registrarUsuario,
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
                          'REGISTRARSE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
