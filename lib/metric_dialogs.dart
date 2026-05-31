import 'package:flutter/material.dart';

class MetricDialogs {
  // Shared text controllers to preserve data across popups if needed
  static final TextEditingController caloriesAgeController = TextEditingController();
  static final TextEditingController caloriesHeightController = TextEditingController();
  static final TextEditingController caloriesWeightController = TextEditingController();
  static final TextEditingController bmiHeightController = TextEditingController();
  static final TextEditingController bmiWeightController = TextEditingController();

  /// --- CALORIES POPUP ---
  static Widget buildCaloriesDialog({
    required BuildContext context,
    required StateSetter setDialogState,
    required String selectedGender,
    required String selectedActivity,
    required Function(String) onGenderChanged,
    required Function(String) onActivityChanged,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
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
                  const Text("Calories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black45, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text("Gender", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: "Male",
                        groupValue: selectedGender,
                        activeColor: Colors.amber,
                        onChanged: (val) => onGenderChanged(val!),
                      ),
                      const Text("Male", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Female",
                        groupValue: selectedGender,
                        activeColor: Colors.amber,
                        onChanged: (val) => onGenderChanged(val!),
                      ),
                      const Text("Female", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildPopupTextField("Age", null, Colors.black.withOpacity(0.04), Colors.black26, caloriesAgeController),
              const SizedBox(height: 12),
              _buildPopupTextField("Height", "Cm", const Color(0xFFE8F5E9), const Color(0xFF4CAF50), caloriesHeightController),
              const SizedBox(height: 12),
              _buildPopupTextField("Weight", "Kg", Colors.black.withOpacity(0.02), Colors.black.withOpacity(0.08), caloriesWeightController),
              const SizedBox(height: 12),
              const Text("Activity", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.08)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedActivity,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    items: ["Sedentary", "Lightly Active", "Moderately Active", "Very Active"]
                        .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
                    onChanged: (val) => onActivityChanged(val!),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildPrimaryPopupButton("Calculate", () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// --- BMI POPUP ---
  static Widget buildBmiDialog(BuildContext context, Color themeColor) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      backgroundColor: Colors.white,
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
                const Text("BMI", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black45, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildPopupTextField("Height", "Cm", const Color(0xFFEEEDFF), const Color(0xFF6C63FF), bmiHeightController),
            const SizedBox(height: 16),
            _buildPopupTextField("Weight", "Kg", Colors.black.withOpacity(0.02), Colors.black.withOpacity(0.08), bmiWeightController),
            const SizedBox(height: 24),
            _buildPrimaryPopupButton("Calculate", () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  /// --- WATER POPUP ---
  static Widget buildWaterDialog({
    required BuildContext context,
    required StateSetter setDialogState,
    required int currentCount,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                const Text("Drink Water!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black45, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Add Glass of water", style: TextStyle(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2).withOpacity(0.5), 
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.remove, color: Colors.amber, size: 24),
                  ),
                ),
                const SizedBox(width: 24),
                const Icon(Icons.local_drink, color: Colors.blueAccent, size: 48),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: onIncrement,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("$currentCount${currentCount == 1 ? ' Glass' : ' Glasses'} (${currentCount * 200} ml)", 
                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
            const SizedBox(height: 28),
            _buildPrimaryPopupButton("Add", () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  /// --- REUSABLE HELPERS ---
  static Widget _buildPopupTextField(String label, String? suffix, Color fillColor, Color borderColor, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: suffix,
            suffixStyle: const TextStyle(color: Colors.black38, fontSize: 16),
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildPrimaryPopupButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          elevation: 0,
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  static void disposeControllers() {
    caloriesAgeController.dispose();
    caloriesHeightController.dispose();
    caloriesWeightController.dispose();
    bmiHeightController.dispose();
    bmiWeightController.dispose();
  }
}