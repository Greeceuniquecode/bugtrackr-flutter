import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectsService {
  static Future<String> createProject(
    String name,
    String description,
    String status,
    String userId,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/create-project');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'description': description,
          'status': status,
          'user_id': userId,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Project Created successfully!';
      } else {
        return data['message'] ?? 'Project Creation failed';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  static Future<Object?> getProjects() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/get-projects');
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
        return data['message'] ?? 'Error fetching projects';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
  static Future<String> editProject(
    String name,
    String description,
    String status,
    String userId,
    String id,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/edit-project');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id':id,
          'name': name,
          'description': description,
          'status': status,
          'user_id': userId,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Project edited successfully!';
      } else {
        return data['message'] ?? 'Project edit failed';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

}
