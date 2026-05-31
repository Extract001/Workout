import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<dynamic> _exercises = [];
  bool _isLoading = true;
  String _errorMessage = '';

  // API dynamic parameter state
  String _currentCategories = '1,2'; 

  // Filter UI states
  String _selectedDifficulty = "Beginner";
  String _selectedType = "Weights";
  String _selectedEquipment = "Barbell";
  String _selectedMuscle = "Chest";

  @override
  void initState() {
    super.initState();
    _fetchExercises(_currentCategories);
  }

  // 1. Fetch multi-category data from the main list API
  Future<void> _fetchExercises(String categoryIds) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    try {
      final url = Uri.parse('https://appy.trycatchtech.com/v3/fit_zone/exercise_list?category_id=1,2');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _exercises = data;
          _isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // 2. Map chosen UI strings to backend category IDs
  void _applySelectedFilters() {
    String targetedCategory = '1,2'; // Default fallback
    
    if (_selectedType == "Weights") {
      
      targetedCategory = '1';
    } else if (_selectedType == "Stretches") {
      targetedCategory = '2';
    } else if (_selectedType == "Warm-Up") {
      targetedCategory = '3';
    } else if (_selectedType == "Yoga") {
      targetedCategory = '4';
    }
    
    _currentCategories = targetedCategory;
    _fetchExercises(_currentCategories);
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          const Text("Filter", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close, color: Colors.black38, size: 26),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text("Difficulty", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ["Beginner", "Intermediate", "Advanced"].map((level) {
                          bool isSelected = _selectedDifficulty == level;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: level,
                                groupValue: _selectedDifficulty,
                                activeColor: Colors.amber,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onChanged: (val) {
                                  setDialogState(() => _selectedDifficulty = val!);
                                },
                              ),
                              const SizedBox(width: 2),
                              Text(level, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
                            ],
                          );
                        }).toList(),
                      ),
                      const Divider(height: 28, thickness: 0.5),

                      const Text("Type", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFilterChip("Weights", _selectedType == "Weights", const Color(0xFFFFEAEA), const Color(0xFFFF6B6B), (val) => setDialogState(() => _selectedType = "Weights")),
                          _buildFilterChip("Stretches", _selectedType == "Stretches", const Color(0xFFFFEAEA), const Color(0xFFFF6B6B), (val) => setDialogState(() => _selectedType = "Stretches")),
                          _buildFilterChip("Warm-Up", _selectedType == "Warm-Up", const Color(0xFFFFEAEA), const Color(0xFFFF6B6B), (val) => setDialogState(() => _selectedType = "Warm-Up")),
                          _buildFilterChip("Yoga", _selectedType == "Yoga", const Color(0xFFFFEAEA), const Color(0xFFFF6B6B), (val) => setDialogState(() => _selectedType = "Yoga")),
                        ],
                      ),
                      const Divider(height: 28, thickness: 0.5),

                      const Text("Equipments", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFilterChip("Barbell", _selectedEquipment == "Barbell", const Color(0xFFE8F5E9), const Color(0xFF4CAF50), (val) => setDialogState(() => _selectedEquipment = "Barbell")),
                          _buildFilterChip("Cable", _selectedEquipment == "Cable", const Color(0xFFE8F5E9), const Color(0xFF4CAF50), (val) => setDialogState(() => _selectedEquipment = "Cable")),
                          _buildFilterChip("Band", _selectedEquipment == "Band", const Color(0xFFE8F5E9), const Color(0xFF4CAF50), (val) => setDialogState(() => _selectedEquipment = "Band")),
                          _buildFilterChip("Plate", _selectedEquipment == "Plate", const Color(0xFFE8F5E9), const Color(0xFF4CAF50), (val) => setDialogState(() => _selectedEquipment = "Plate")),
                        ],
                      ),
                      const Divider(height: 28, thickness: 0.5),

                      const Text("Muscles", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFilterChip("Shoulders", _selectedMuscle == "Shoulders", const Color(0xFFEEEDFF), const Color(0xFF6C63FF), (val) => setDialogState(() => _selectedMuscle = "Shoulders")),
                          _buildFilterChip("Chest", _selectedMuscle == "Chest", const Color(0xFFEEEDFF), const Color(0xFF6C63FF), (val) => setDialogState(() => _selectedMuscle = "Chest")),
                          _buildFilterChip("Bicep", _selectedMuscle == "Bicep", const Color(0xFFEEEDFF), const Color(0xFF6C63FF), (val) => setDialogState(() => _selectedMuscle = "Bicep")),
                        ],
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _applySelectedFilters(); 
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                            elevation: 0,
                          ),
                          child: const Text("Apply", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, Color activeBg, Color activeBorder, ValueChanged<bool> onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: isSelected ? activeBorder : Colors.black45,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        fontSize: 12,
      ),
      backgroundColor: Colors.black.withOpacity(0.03),
      selectedColor: activeBg,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: isSelected ? activeBorder : Colors.transparent, width: 1),
      ),
      showCheckmark: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text("Featured Exercise", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Text("Type here to search something...", style: TextStyle(color: Colors.black26, fontSize: 14)),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _showFilterDialog,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: const Icon(Icons.tune, color: Colors.black87, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(_errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _fetchExercises(_currentCategories),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text("Retry", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }

    if (_exercises.isEmpty) {
      return const Center(child: Text("No exercises found", style: TextStyle(color: Colors.black45)));
    }

    return ListView.builder(
      itemCount: _exercises.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final exercise = _exercises[index];
        final String id = exercise['id'] ?? '0'; // Extracts backend item ID 
        final String title = exercise['name'] ?? 'Exercise';
        final String image = exercise['image'] ?? '';
        final String level = exercise['cat_difficulty'] ?? 'Beginner';

        return GestureDetector(
          onTap: () => Navigator.push(context,
           MaterialPageRoute(builder: 
           (context)=> ExerciseDetailScreen(exerciseId: exercise["id"].toString()),
           ),
          ),
          child: Container(
            height: 140,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              image: image.isNotEmpty
                  ? DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
                  : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black.withOpacity(0.75), Colors.black.withOpacity(0.1)],
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(level, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 54,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// =========================================================================
// NEW: Detail screen requesting unique item statistics via Single Exercise API
// =========================================================================
class ExerciseDetailScreen extends StatefulWidget {
  final String exerciseId;
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  Map<String, dynamic>? _exerciseData;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchSingleExercise();
  }

  Future<void> _fetchSingleExercise() async {
    try {
      final url = Uri.parse('https://appy.trycatchtech.com/v3/fit_zone/single_exercise?id=${widget.exerciseId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            _exerciseData = data[0]; // Stores single data object mapping response
            _isLoading = false;
          });
        } else {
          throw Exception("Exercise data not available");
        }
      } else {
        throw Exception("Failed to load details");
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(_exerciseData?['name'] ?? "Details", style: const TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_exerciseData?['image'] != null)
                        Image.network(_exerciseData!['image'], width: double.infinity, height: 250, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_exerciseData!['name'] ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text("Difficulty: ${_exerciseData!['cat_difficulty'] ?? 'N/A'}", style: const TextStyle(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(_exerciseData!['description'] ?? 'No description layout fields configured for this workout model item.', style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}