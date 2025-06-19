import 'dart:convert';

import 'package:complimentsjar/api/auth_service.dart';
import 'package:http/http.dart' as http;

class BugsService {
  static String? userId;
  static Future<String> registerBug(
    final String title,
    final String code,
    final String description,
    final int projectId,
    final String status,
  ) async {
    Future<void> loadLoginInfo() async {
      final storedInfo = await AuthService.getLoginInfo();

      if (storedInfo != null) {
        userId = storedInfo['user_id'];
      }
    }

    loadLoginInfo();
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

  static Future<String> editBug(
    final String title,
    final String code,
    final String description,
    final String status,
    final int projectId,
    final int bugId,
  ) async {
    Future<void> loadLoginInfo() async {
      final storedInfo = await AuthService.getLoginInfo();

      if (storedInfo != null) {
        userId = storedInfo['user_id'];
      }
    }

    loadLoginInfo();
    final url = Uri.parse('http://10.0.2.2:8000/api/edit-bug/$bugId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "code": code,
          "description": description,
          "status": status,
          "user_id": userId,
          "project_id": projectId,
        }),
      );
      final data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200) {
        return 'Bug updated successfully!';
      } else {
        return data['message'] ?? 'Failed to update bug';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
   static Future<String> submitBug(
    final String newCode,
    final int id,

  ) async {
    Future<void> loadLoginInfo() async {
      final storedInfo = await AuthService.getLoginInfo();

      if (storedInfo != null) {
        userId = storedInfo['user_id'];
      }
    }

    loadLoginInfo();
    final url = Uri.parse('http://10.0.2.2:8000/api/submit-bug/$id');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({

          "new_code": newCode,
          "submitted_by": userId,
        }),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Debugged code Submitted successfully!';
      } else {
        return data['message'] ?? 'Failed to submit code';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
  static Future<Object?> rejectBug(id) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/reject-bug/$id');
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
        return data['message'] ?? 'Error';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
