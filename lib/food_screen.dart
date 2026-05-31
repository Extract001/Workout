import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:work_out_project/food_macro_filter%20dialog.dart';
import 'dart:convert';
 

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<dynamic> _foodList = [];
  List<dynamic> _filteredFoodList = []; 
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFoodList();
  }

  Future<void> _fetchFoodList() async {
    try {
      final response = await http.get(Uri.parse("https://appy.trycatchtech.com/v3/fit_zone/food_list"));
      if (response.statusCode == 200) {
        setState(() {
          _foodList = json.decode(response.body);
          _filteredFoodList = _foodList; 
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _filteredFoodList = _foodList
          .where((food) => food["name"] // SYNCED: Using "name" from API
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showMacroFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const FoodMacroFilterDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Featured Food", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSearch, 
                    decoration: InputDecoration(
                      hintText: "Type here to search something",
                      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
                      fillColor: const Color(0xFFF7F7F9),
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: _showMacroFilter,
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFF7F7F9), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.black))
                  : _filteredFoodList.isEmpty
                      ? const Center(child: Text("No items found matching your search."))
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.82, // Adjusted slightly to prevent text clipping
                          ),
                          itemCount: _filteredFoodList.length,
                          itemBuilder: (context, index) {
                            final food = _filteredFoodList[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodDetailScreen(foodId: food["id"].toString()),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withOpacity(0.03),
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                          child: Image.network(
                                            food["image"] ?? '', // SYNCED: Using "image" from API
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            food["name"] ?? '', // SYNCED: Using "name" from API
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text("Calories: ${food["calories"]} Kcal", style: const TextStyle(color: Colors.black54, fontSize: 12)),
                                          const SizedBox(height: 2),
                                          Text("Fats: ${food["fats"]}g | Carbs: ${food["carbs"]}g", style: const TextStyle(color: Colors.black38, fontSize: 11)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchFoodDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Error fetching item profile details."));
          }

          final detail = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 220,
                    padding: const EdgeInsets.all(16),
                    child: Image.network(
                      detail["image"] ?? '', // SYNCED: Using "image" from API
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        detail["name"] ?? '', // SYNCED: Using "name" from API
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      detail["sodium"]?.toString().trim() ?? '0mg', 
                      style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600)
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Total Energy: ${detail["calories"]} Kcal", 
                  style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold, fontSize: 14)
                ),
                const SizedBox(height: 16),
                const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(
                  detail["description"] ?? 'No detailed data profile provided for this item recipe.', 
                  style: const TextStyle(color: Colors.black54, height: 1.4, fontSize: 14)
                ),
                const SizedBox(height: 28),
                const Text("Macronutrients Breakdown", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _buildMacroProgressRow("Fats", detail["fats"].toString(), Colors.green),
                _buildMacroProgressRow("Carbohydrates", detail["carbs"].toString(), Colors.amber.shade700),
                _buildMacroProgressRow("Proteins", detail["protein"].toString(), Colors.redAccent),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMacroProgressRow(String label, String value, Color color) {
    double parsedVal = double.tryParse(value) ?? 0.0;
    double progressPercent = (parsedVal / 100).clamp(0.0, 1.0); 

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
              Text("${value}g", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progressPercent, 
            color: color, 
            backgroundColor: Colors.black.withOpacity(0.05), 
            minHeight: 7,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}