import 'dart:convert';

import 'package:http/http.dart' as http;

class BugsService {
  static Future<Object?> registerBug(
    final String title,
    final String code,
    final String description,
    final String userId,
    final String projectId,
    final String status,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/register-bug');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "code": code,
          "description": description,
          "user_id": userId,
          "project_id": projectId,
          "status": status,
        }),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Bugs registered successfully!';
      } else {
        return data['message'] ?? 'Failed to register bug';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  static Future<Object?> getBugs(id) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/get-all-bugs/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Error fetching bugs';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
