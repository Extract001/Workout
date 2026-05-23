import 'package:flutter/material.dart';
import 'package:work_out_project/onboarding_2.dart';
// TODO: Make sure to create onboarding2.dart and import it here
// import 'onboarding2.dart'; 

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/women-barbell.png",
              fit: BoxFit.cover, // Fills the entire screen
            ),
          ),

          // 2. Gradient Overlay (To ensure text readability, matching the dark bottom in the UI)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.8), // Darkens the bottom area
                  ],
                ),
              ),
            ),
          ),

          // 3. UI Content (Text, Button, Dots)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end, // Pushes content to the bottom
                children: [
                  // Title
                  const Text(
                    "Fun Exercises",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle Description
                  const Text(
                    "Discover fun workouts, track your progress, and stay motivated!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Next Button & Page Indicators Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // White "Next" Button
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // FIXED: Capitalized 'B'
                            ),
                          ),
                           onPressed: () {
                    Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context)=> const Onboarding2()
                     ),
                     );
                  },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Page Indicators (Three dots)
                      Row(
                        children: [
                          // Active Dot (Wide pill)
                          Container(
                            width: 24,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3), // FIXED: Capitalized 'B'
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Inactive Dot 1
                          Container(
                            width: 10,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(3), // FIXED: Capitalized 'B'
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Inactive Dot 2
                          Container(
                            width: 10,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(3), // FIXED: Capitalized 'B'
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Small spacing from screen bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
