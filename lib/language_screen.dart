import 'package:flutter/material.dart';
import 'terms_screen.dart'; 

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> languages = [
    {"flag": "🇬🇧", "name": "English"},
    {"flag": "🇮🇳", "name": "हिंदी"},
    {"flag": "🇪🇸", "name": "Española"},
    {"flag": "🇫🇷", "name": "Francesa"},
    {"flag": "🇧🇷", "name": "Português"},
    {"flag": "🇰🇷", "name": "한국인"},
  ];

  @override
  Widget build(BuildContext context) {
    // Getting the screen height dynamically to properly distribute the image space
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          
          // LAYER 1: The Content Layer (Title, List, and Button)
          SafeArea(
            bottom: false, // Allows content containers to flow nicely downward
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Select Language",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25),
                
                // Language Selection List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? Colors.black : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                languages[index]["flag"]!,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  languages[index]["name"]!,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (!isSelected)
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey.shade700,
                                )
                              else
                                const SizedBox(width: 16), // Keeps sizing balanced when arrow hides
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: 160, // Sized perfectly to match the pill shape in your screenshot
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF222222), // Dark slate/black matching your UI
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Fully rounded pill shape
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // This gives dynamic spacing matching the photo layout ratio
                SizedBox(height: screenHeight * 0.38), 
              ],
            ),
          ),

          // LAYER 2: Absolute Fixed Bottom Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/girl-back.png",
              width: double.infinity,
              height: screenHeight * 0.35, // Allocates roughly 35% of lower screen real estate to the picture
              fit: BoxFit.cover, // Wipes out margins completely by stretching to edges
            ),
          ),
          
        ],
      ),
    );
  }
}