import 'package:flutter/material.dart';
import 'package:work_out_project/onboarding_1.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  Widget customRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(icon, size: 28),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const SizedBox(height: 10),

              const Text(
                "Terms of Use",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              customRow(
                Icons.lock_outline,
                "I declare I have read and accepted the following condition of use.",
              ),

              customRow(
                Icons.block,
                "If we find the app is being used outside its terms of use.",
              ),

              customRow(
                Icons.settings,
                "Any type of modification to the app is not allowed.",
              ),
              
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),

                  onPressed: () {
                    Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context)=> const Onboarding1()),
                     );
                  },

                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}