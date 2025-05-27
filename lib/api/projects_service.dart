import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectsService {
  static Future<String> createProject(
    String name,
    String description,
    String status,
    int userId,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/create-project');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'name': name, 'description': description, 'status': status, 'user_id':userId}),
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
}
