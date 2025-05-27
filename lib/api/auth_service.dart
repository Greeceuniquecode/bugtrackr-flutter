import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<String> signup(
    String name,
    String email,
    String password,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Signed up successfully!';
      } else {
        return data['message'] ?? 'Signup failed';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }


    static Future<String> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Logged in successfully!';
      } else {
        return data['message'] ?? 'Login failed';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}