import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodDetailScreen extends StatelessWidget {
  final String foodId;
  const FoodDetailScreen({super.key, required this.foodId});

  Future<Map<String, dynamic>> _fetchFoodDetails() async {
    final response = await http.get(Uri.parse("https://appy.trycatchtech.com/v3/fit_zone/single_food?id=$foodId"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.isNotEmpty ? data.first : {};
    }
    throw Exception("Failed to load details");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchFoodDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Detail processing error"));
          }

          final detail = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 200,
                    child: Image.network(detail["food_image"] ?? '', fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(detail["food_name"] ?? '', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    Text("${detail["weight"]} gm", style: const TextStyle(color: Colors.black54, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(detail["description"] ?? 'No description provided.', style: const TextStyle(color: Colors.black54, height: 1.4)),
                const SizedBox(height: 24),
                _buildMacroProgressRow("Fats", detail["fats"].toString(), Colors.green),
                _buildMacroProgressRow("Carbs", detail["carbs"].toString(), Colors.amber),
                _buildMacroProgressRow("Protein", detail["protein"].toString(), Colors.red),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMacroProgressRow(String label, String value, Color color) {
    double parsedVal = double.tryParse(value) ?? 0.0;
    double progressPercent = (parsedVal / 150).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("${value} g", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(value: progressPercent, color: color, backgroundColor: Colors.black12, minHeight: 8),
        ],
      ),
    );
  }
}