import 'package:flutter/material.dart';
import 'package:work_out_project/home_screen.dart';
import 'package:work_out_project/language_screen.dart';
import 'package:work_out_project/onboarding_1.dart';
import 'package:work_out_project/onboarding_2.dart';
import 'package:work_out_project/onboarding_3.dart';
import 'splash_screen.dart';
import 'language_screen.dart';
import 'terms_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}