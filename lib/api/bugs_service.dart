
import 'dart:convert';

import 'package:http/http.dart' as http;

class BugsService {
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
