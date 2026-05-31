import 'package:flutter/material.dart';

class FoodMacroFilterDialog extends StatefulWidget {
  const FoodMacroFilterDialog({super.key});

  @override
  State<FoodMacroFilterDialog> createState() => _FoodMacroFilterDialogState();
}

class _FoodMacroFilterDialogState extends State<FoodMacroFilterDialog> {
  double _proteinValue = 50;
  double _fatsValue = 30;
  double _carbsValue = 80;

  Widget _buildMacroSlider(String label, double value, Color color, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: 0,
                max: 150,
                activeColor: color,
                inactiveColor: Colors.black12,
                onChanged: onChanged,
              ),
            ),
            Text("${value.round()}g", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Filter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildMacroSlider("Protein", _proteinValue, Colors.redAccent, (v) => setState(() => _proteinValue = v)),
          _buildMacroSlider("Fats", _fatsValue, Colors.greenAccent.shade700, (v) => setState(() => _fatsValue = v)),
          _buildMacroSlider("Carbs", _carbsValue, Colors.deepPurpleAccent, (v) => setState(() => _carbsValue = v)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () => Navigator.pop(context),
              child: const Text("Apply Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}