import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'menu_screen.dart';
import 'registro_screen.dart';
import '../main.dart';
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

  Future<void> _login() async {
    setState(() => _loading = true);

    final url = Uri.parse('$apiBaseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      }),
    );

    setState(() => _loading = false);

    if (response.statusCode == 200) {
      // Primero decodificamos la respuesta
      final data = jsonDecode(response.body);

      // Luego guardamos el token y uid localmente
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('idToken', data['idToken']);
      await prefs.setString('uid', data['uid']);

      // Mensaje de éxito y navegación
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login exitoso")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MenuScreen()),
      );
    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${data['error']}")));
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kColorMarronOscuro,
                  ),
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
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('INGRESAR'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistroScreen(),
                    ),
                  ),
                  child: const Text('¿No tienes cuenta? Regístrate aquí'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
