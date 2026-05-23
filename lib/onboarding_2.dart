import 'package:flutter/material.dart';
import 'package:work_out_project/onboarding_3.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/sporty-woman.png",
              fit: BoxFit.cover, // Fills the entire screen seamlessly
            ),
          ),

          // 2. Gradient Overlay (Ensures your text stands out over the image)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.8), // Smooth dark drop shadow at the bottom
                  ],
                ),
              ),
            ),
          ),

          // 3. UI Layout Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end, // Aligns elements to the bottom
                children: [
                  // Title
                  const Text(
                    "Stay Healthy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle Description
                  const Text(
                    "Get nutritional value of food, and hit your calorie goals effortlessly!",
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
                              borderRadius: BorderRadius.circular(25), // Elegant pill shape
                            ),
                          ),
                           onPressed: () {
                    Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context)=> const Onboarding3()
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

                      // Page Indicators (Active dot is moved to index 2)
                      Row(
                        children: [
                          // Inactive Dot 1
                          Container(
                            width: 10,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 6),
                          
                          // Active Dot (Wide pill - Center Focus)
                          Container(
                            width: 24,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 6),
                          
                          // Inactive Dot 2
                          Container(
                            width: 10,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

