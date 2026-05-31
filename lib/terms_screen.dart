import 'package:flutter/material.dart';
import 'package:work_out_project/onboarding_1.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  // Helper widget to build the icon-text list rows perfectly aligned
  Widget customRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: const Color(0xFF222222)),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          
          // LAYER 1: Main Text & Interactive Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          "Terms of Use",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // Top Intro Description
                        const Text(
                          "Application is informing you about the app, that gives you many services and important information for safer and efficient use.\n\nUser-Generated Content Policy(UGC) By pressing the Accept button",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Term Row items with matching screenshot icons
                        customRow(
                          Icons.lock_outline,
                          "I declare I have read and accepted the following condition of use.",
                        ),
                        customRow(
                          Icons.not_interested_outlined, // Matches the cancel/block icon shape
                          "If we find the app is being used outside its terms of use, we may restrict access to it.",
                        ),
                        customRow(
                          Icons.phonelink_erase_outlined, // Modification lock icon substitute
                          "Any type of modification to the app or its components is not allowed.",
                        ),
                        customRow(
                          Icons.assignment_turned_in_outlined, // Document verification icon
                          "Privacy Policy may be updated from time time for any reason. We will notify you of any changes to our Privacy Policy by posting the new Privacy Policy here.",
                        ),
                        customRow(
                          Icons.share_location, // Network nodes/personal share icon
                          "We do not share any kind of your Personal Data with third parties.",
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // Legal links section
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "You can find out more information by clicking on the\nFollowing link : Terms and conditions of use\nFollowing Link: Privacy policy.",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 35),

                        // Pill-shaped Accept Button
                        SizedBox(
                          width: 160,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222222),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Onboarding1()),
                              );
                            },
                            child: const Text(
                              "Accept",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        // Buffer space to protect elements from passing over the background graphic base
                        SizedBox(height: screenHeight * 0.28),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // LAYER 2: Absolute Bottom Positioned Image Frame
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/girl-back.png",
              width: double.infinity,
              height: screenHeight * 0.24, // Keeps the bottom vertical height layout perfectly balanced
              fit: BoxFit.cover,
            ),
          ),
          
        ],
      ),
    );
  }
}