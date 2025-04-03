import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000'; // Android Emulator
  // final String baseUrl = 'http://localhost:5000'; // iOS Emulator or Physical Device

  // Signup user
  Future<Map<String, dynamic>> signupUser(Map<String, String> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      print("Signup Response Code: ${response.statusCode}");
      print("Signup Response Body: ${response.body}");

      if (response.statusCode == 201) {
        // 201 for successful user creation
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return {'error': 'Invalid request data'};
      } else if (response.statusCode == 409) {
        return {'error': 'User already exists'};
      } else {
        throw Exception('Signup Failed: ${response.body}');
      }
    } catch (e) {
      print("Signup Exception: $e");
      throw Exception('Error: $e');
    }
  }

  // Login user
  Future<Map<String, dynamic>> loginUser(
      Map<String, String> credentials) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials),
      );

      print("Login Response Code: ${response.statusCode}");
      print("Login Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        return {'error': 'Invalid email or password'};
      } else {
        throw Exception('Login Failed: ${response.body}');
      }
    } catch (e) {
      print("Login Exception: $e");
      throw Exception('Error: $e');
    }
  }
}
