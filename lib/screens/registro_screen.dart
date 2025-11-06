import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../main.dart';

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

  Future<void> _registrarUsuario() async {
    final nombre = _usuarioController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (password != _confirmController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    setState(() => _loading = true);

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

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario registrado con éxito")),
      );
      Navigator.pop(context);
    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${data['error'] ?? 'Error al registrar'}")),
      );
    }
  }

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
                Text('Crear Cuenta',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kColorMarronOscuro)),
                SizedBox(height: screenHeight * 0.03),

                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                TextField(
                  controller: _confirmController,
                  decoration: const InputDecoration(labelText: 'Confirmar contraseña'),
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.04),

                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _registrarUsuario,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('REGISTRARSE'),
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
