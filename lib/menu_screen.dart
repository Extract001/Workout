import 'package:flutter/material.dart';
import 'package:work_out_project/exercise_screen.dart';
import 'package:work_out_project/food_screen.dart';
import 'package:work_out_project/language_screen.dart';
import 'package:work_out_project/terms_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Method to display the "Rate Us" Popup
  void _showRateUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite, color: Colors.redAccent, size: 60),
                const SizedBox(height: 16),
                const Text("Rate Us", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("Do you really want to exit an application?", 
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(index < 4 ? Icons.star : Icons.star_border, 
                        color: Colors.amber, size: 35);
                  }),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("Exit", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget menuTile(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        title,
        style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  Widget sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    sectionHeader("Features", Colors.white),
                    menuTile(Icons.fitness_center, "Exercise", Colors.white, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseScreen()));
                    }),
                    menuTile(Icons.restaurant, "Diet", Colors.white, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodScreen()));
                    }),
                  ],
                ),
              ),
            ),
            sectionHeader("Communicate", Colors.black),
            menuTile(Icons.reply, "Share", Colors.black, () {}),
            // "Rate Us" now triggers the popup
            menuTile(Icons.star_border, "Rate Us", Colors.black, () => _showRateUsDialog(context)),
            menuTile(Icons.description_outlined, "Privacy Policy", Colors.black, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsScreen()));
            }),
            menuTile(Icons.language, "Language", Colors.black, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen()));
            }),
          ],
        ),
      ),
    );
  }
}