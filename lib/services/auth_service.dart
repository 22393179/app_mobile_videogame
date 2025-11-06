import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class AuthService {
  /// Obtiene el perfil del usuario desde el backend
  Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('idToken');
    if (token == null) return null;

    final url = Uri.parse('$apiBaseUrl/auth/me');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error perfil: ${response.body}');
      return null;
    }
  }

  /// Cierra sesión (borra el token y notifica al backend)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('idToken');

    if (token != null) {
      final url = Uri.parse('$apiBaseUrl/auth/logout');
      await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
    }

    await prefs.remove('idToken');
    await prefs.remove('uid');
  }
}
