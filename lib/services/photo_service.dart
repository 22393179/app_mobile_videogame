import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class PhotoService {
  Future<String?> uploadPhoto(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    if (token == null) return null;

    final url = Uri.parse('$apiBaseUrl/auth/upload-photo');

    final request = http.MultipartRequest("POST", url);
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath('photo', imageFile.path),
    );

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return resBody;
    } else {
      print("Error subiendo foto: $resBody");
      return null;
    }
  }
}
