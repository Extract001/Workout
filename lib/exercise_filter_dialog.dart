import 'package:flutter/material.dart';

class ExerciseFilterDialog extends StatefulWidget {
  const ExerciseFilterDialog({super.key});

  @override
  State<ExerciseFilterDialog> createState() => _ExerciseFilterDialogState();
}

class _ExerciseFilterDialogState extends State<ExerciseFilterDialog> {
  String selectedDifficulty = "Beginner";
  String selectedType = "Stretches";
  String selectedEquipment = "Cable";
  String selectedMuscle = "Chest";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32), 
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                const Text(
                  "Filter", 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey), 
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Difficulty Row Selector
            const Text("Difficulty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDifficultyItem("Beginner"),
                _buildDifficultyItem("Intermediate"),
                _buildDifficultyItem("Advanced"),
              ],
            ),
            const SizedBox(height: 20),

            // Type Chips
            const Text("Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _buildChipItem("Weights", selectedType, (val) => setState(() => selectedType = val), const Color(0xFFFFEBEA), Colors.redAccent),
                _buildChipItem("Stretches", selectedType, (val) => setState(() => selectedType = val), const Color(0xFFFFEBEA), Colors.redAccent),
                _buildChipItem("Warm-Up", selectedType, (val) => setState(() => selectedType = val), const Color(0xFFFFEBEA), Colors.redAccent),
                _buildChipItem("Yoga", selectedType, (val) => setState(() => selectedType = val), const Color(0xFFFFEBEA), Colors.redAccent),
              ],
            ),
            const SizedBox(height: 20),

            // Equipment Chips
            const Text("Equipments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _buildChipItem("Barbell", selectedEquipment, (val) => setState(() => selectedEquipment = val), const Color(0xFFE8F8F2), const Color(0xFF2EC4B6)),
                _buildChipItem("Cable", selectedEquipment, (val) => setState(() => selectedEquipment = val), const Color(0xFFE8F8F2), const Color(0xFF2EC4B6)),
                _buildChipItem("Band", selectedEquipment, (val) => setState(() => selectedEquipment = val), const Color(0xFFE8F8F2), const Color(0xFF2EC4B6)),
                _buildChipItem("Plate", selectedEquipment, (val) => setState(() => selectedEquipment = val), const Color(0xFFE8F8F2), const Color(0xFF2EC4B6)),
                _buildChipItem("TBar", selectedEquipment, (val) => setState(() => selectedEquipment = val), const Color(0xFFE8F8F2), const Color(0xFF2EC4B6)),
                _buildChipItem("EZBar", selectedEquipment, (val) => setState(() => selectedEquipment = val), const Color(0xFFE8F8F2), const Color(0xFF2EC4B6)),
              ],
            ),
            const SizedBox(height: 20),

            // Muscles Chips
            const Text("Muscles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _buildChipItem("Shoulders", selectedMuscle, (val) => setState(() => selectedMuscle = val), const Color(0xFFF0E6FF), const Color(0xFF9D4EDD)),
                _buildChipItem("Chest", selectedMuscle, (val) => setState(() => selectedMuscle = val), const Color(0xFFF0E6FF), const Color(0xFF9D4EDD)),
                _buildChipItem("Bicep", selectedMuscle, (val) => setState(() => selectedMuscle = val), const Color(0xFFF0E6FF), const Color(0xFF9D4EDD)),
                _buildChipItem("Triceps", selectedMuscle, (val) => setState(() => selectedMuscle = val), const Color(0xFFF0E6FF), const Color(0xFF9D4EDD)),
                _buildChipItem("Lats", selectedMuscle, (val) => setState(() => selectedMuscle = val), const Color(0xFFF0E6FF), const Color(0xFF9D4EDD)),
                _buildChipItem("Abs", selectedMuscle, (val) => setState(() => selectedMuscle = val), const Color(0xFFF0E6FF), const Color(0xFF9D4EDD)),
              ],
            ),
            const SizedBox(height: 32),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  // Pass the selected filters back to the calling screen
                  Navigator.pop(context, {
                    "difficulty": selectedDifficulty,
                    "type": selectedType,
                    "equipment": selectedEquipment,
                    "muscle": selectedMuscle,
                  });
                },
                child: const Text("Apply", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyItem(String title) {
    bool isSelected = selectedDifficulty == title;
    return GestureDetector(
      onTap: () => setState(() => selectedDifficulty = title),
      child: Column(
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.orange : Colors.grey.shade300, 
                width: isSelected ? 6 : 2,
              ),
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title, 
            style: TextStyle(
              fontSize: 13, 
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChipItem(String text, String selectedValue, Function(String) onSelect, Color activeBg, Color activeBorder) {
    bool isSelected = selectedValue == text;
    return ChoiceChip(
      label: Text(text),
      labelStyle: TextStyle(
        color: isSelected ? activeBorder : Colors.grey.shade600,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        fontSize: 13,
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) onSelect(text);
      },
      selectedColor: activeBg,
      backgroundColor: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: isSelected ? activeBorder : Colors.transparent,
          width: 1.2,
        ),
      ),
      showCheckmark: false,
    );
  }
}