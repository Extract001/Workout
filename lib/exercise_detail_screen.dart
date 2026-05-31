import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String exerciseId;
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  Future<Map<String, dynamic>> _fetchExerciseDetails() async {
    final url = "https://appy.trycatchtech.com/v3/fit_zone/single_exercise?id=$exerciseId";
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.isNotEmpty ? data.first : {};
    }
    throw Exception("Failed to load details");
  }

  // Helper widget to display fields uniformly
  Widget _buildInfoSection(String title, String? content) {
    if (content == null || content.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 6),
        Text(content, style: const TextStyle(color: Colors.black54, fontSize: 15)),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Exercise Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchExerciseDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Error: Could not load exercise details."));
          }

          final detail = snapshot.data!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Center(
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        detail["image"] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Icon(Icons.fitness_center, size: 80),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Title and Difficulty
                Text(detail["name"] ?? 'Exercise', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Difficulty: ${detail["cat_difficulty"] ?? 'N/A'}", 
                    style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                
                // Additional Fields from your JSON
                _buildInfoSection("Timing", detail["timimg"]),
                _buildInfoSection("Equipment", detail["exercise_equipments"]),
                _buildInfoSection("Muscles Targeted", detail["exercise_muscles"]),
                _buildInfoSection("Description", detail["description"]),
                
                // Steps using HtmlWidget to handle HTML tags from API
                const Text("Steps", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                HtmlWidget(
                  detail["steps"] ?? 'No steps available',
                  textStyle: const TextStyle(color: Colors.black54, fontSize: 15, height: 1.5),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}