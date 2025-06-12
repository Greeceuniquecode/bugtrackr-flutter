import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class AuthService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String> signup(
    String name,
    String email,
    String password,
    String address,
    String dob,
    String gender,
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
          'address': address,
          'dob': dob,
          'gender': gender,
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

  static Future login(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.body.isEmpty) {
        return 'Empty response from server';
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = data["user"];
        await _storage.write(key: 'email', value: user['email']);
        await _storage.write(key: 'role', value: user['role']);
        return {'message':'Logged in successfully!','user':user};
      } else {
        return {'message':data['message']
        //  ??
            // 'message':'Login failed with status ${response.statusCode}';
     };
      }
    } catch (e) {
      return 'Error during login: ${e.toString()}';
    }
  }

static Future<Map<String, String>?> getLoginInfo() async {
  try {
    final email = await _storage.read(key:'email');
    final role = await _storage.read(key:'role');

    if (email != null && role != null) {
      return {'email': email, 'role': role};
    }

    return null;
  } catch (e) {
    return null;
  }
}


  static Future<String> logout() async {
    try {
      await _storage.delete(key: "email");
      return "Logged out successfully";
    } catch (e) {
      return "Error during logout: ${e.toString()}";
    }
  }
}
