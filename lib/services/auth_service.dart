import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class AuthService {
  /// Obtiene el perfil del usuario desde el backend (JWT)
  Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final url = Uri.parse('$apiBaseUrl/auth/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error perfil: ${response.body}');
      return null;
    }
  }

  /// Cierra sesión (JWT)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    if (token != null) {
      final url = Uri.parse('$apiBaseUrl/auth/logout');
      await http.post(url, headers: {'Authorization': 'Bearer $token'});
    }

    await prefs.remove('jwtToken');
    await prefs.remove('uid');
  }

  Future<String?> uploadProfilePhoto(String filePath) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final url = Uri.parse('$apiBaseUrl/auth/upload-photo');

    final request = http.MultipartRequest("POST", url);
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath("photo", filePath));

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(respStr);
      return data["photoURL"];
    } else {
      print("Error subiendo foto: $respStr");
      return null;
    }
  }

  Future<bool> deleteProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final url = Uri.parse('$apiBaseUrl/auth/delete-photo');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode == 200;
  }
}
