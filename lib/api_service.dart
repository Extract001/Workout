import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://appy.trycatchtech.com/v3/fit_zone';

  static Future<Map<String, dynamic>> getSingleExercise(String id) async {
    final url = Uri.parse('$_baseUrl/single_exercise?id=$id');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        // Use utf8.decode to ensure characters like '–' or symbols don't crash the app
        final decoded = json.decode(utf8.decode(response.bodyBytes));
        
        if (decoded is List && decoded.isNotEmpty) {
          return Map<String, dynamic>.from(decoded[0]);
        }
        throw Exception('Exercise not found');
      }
      throw Exception('Server error');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}