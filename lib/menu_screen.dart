import 'package:flutter/material.dart';
import 'package:work_out_project/exercise_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget menuTile(
      IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap, // This is where the magic happens!
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  Widget sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
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
                          icon: const Icon(Icons.close,
                              color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    sectionHeader("Features", Colors.white),
                    
                    // FIXED: Removed TextButton, passed navigation straight to menuTile
                    menuTile(
                      Icons.fitness_center, 
                      "Exercise",
                      Colors.white, 
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExerciseScreen()),
                        );
                      },
                    ),
                    
                    menuTile(
                      Icons.restaurant, 
                      "Diet", 
                      Colors.white, 
                      () {
                        // Add Diet routing here later
                      },
                    ),
                  ],
                ),
              ),
            ),

            sectionHeader("Communicate", Colors.black),

            menuTile(Icons.reply, "Share", Colors.black, () {}),
            menuTile(Icons.star_border, "Rate Us", Colors.black, () {}),
            menuTile(Icons.description_outlined, "Privacy Policy", Colors.black, () {}),
            menuTile(Icons.language, "Language", Colors.black, () {}),
          ],
        ),
      ),
    );
  }
}