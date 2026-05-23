import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://appy.trycatchtech.com/v3/fit_zone';

  // 1. Get Category List (Beginner, Intermediate, Advanced)
  static Future<List<dynamic>> getCategories() async {
    final url = Uri.parse('$_baseUrl/category_list');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load categories');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 2. Get Exercises by Category IDs (e.g., '1,2')
  static Future<List<dynamic>> getExercisesByCategories(String categoryIds) async {
    final url = Uri.parse('$_baseUrl/exercise_list?category_id=$categoryIds');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load exercises');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 3. Get Details of a Single Exercise by its ID
  static Future<Map<String, dynamic>> getSingleExercise(String id) async {
    final url = Uri.parse('$_baseUrl/single_exercise?id=$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        // If the API returns a list with one item, extract it safely
        return decoded is List ? decoded.first : decoded;
      }
      throw Exception('Failed to load exercise details');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 4. Get All Foods List
  static Future<List<dynamic>> getFoodList() async {
    final url = Uri.parse('$_baseUrl/food_list');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load food list');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 5. Get Details of a Single Food Item by its ID
  static Future<Map<String, dynamic>> getSingleFood(String id) async {
    final url = Uri.parse('$_baseUrl/single_food?id=$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        return decoded is List ? decoded.first : decoded;
      }
      throw Exception('Failed to load food details');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}