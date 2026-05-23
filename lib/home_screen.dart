import 'package:flutter/material.dart';
import 'package:work_out_project/exercise_screen.dart';
import 'menu_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; 
  int _currentWorkoutIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // Controllers for text fields inside our dialog popup
  final TextEditingController _weightController = TextEditingController(text: "100");
  final TextEditingController _repsController = TextEditingController();

  final List<Map<String, dynamic>> _workouts = [
    {
      "title": "Squats",
      "desc": "Squats are effective for building lower body strength and enhancing overall lower body.",
      "image": "assets/women-squats.png"
    },
    {
      "title": "Deadlift",
      "desc": "Deadlifts are essential for developing raw back power, core stability, and hamstring strength",
      "image": "assets/women-deadlift.png",
      "rightOffset": 50.0,
    },
    {
      "title": "Biceps Curl",
      "desc": "Biceps curls isolate and target your arm strength, maximizing your peak upper body aesthetics.",
      "image": "assets/women-bisceps-curl.png" 
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  // Method to open the Custom Metric Dialog Popup
  void _showMetricDialog(String metricType, Color themeColor) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Text(
                      "$metricType Lifted",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.black45, size: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Field 1: Weight input
                const Text(
                  "Weight Lifted",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: "Kg",
                    suffixStyle: const TextStyle(color: Colors.black38, fontSize: 16),
                    filled: true,
                    fillColor: themeColor.withOpacity(0.06),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: themeColor.withOpacity(0.4), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: themeColor, width: 2),
                    ),
                  ),
                  style: TextStyle(color: themeColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Field 2: Reps input
                const Text(
                  "Reps Performed",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _repsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.02),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.08)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Calculate Action Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MenuScreen(), 
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,                  
        scrolledUnderElevation: 0,
        title: const Text(
          "FitZone: Your Gym Guide",
          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, 
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black, size: 28),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Specifies the height area for the line
          child: Container(
            color: Colors.black.withOpacity(0.08), // Soft grey color that matches your card borders
            height: 1.0,
      ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quick Workout",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 35),

              // PageView slider
              SizedBox(
                height: 170,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _workouts.length,
                  clipBehavior: Clip.none, 
                  onPageChanged: (index) => setState(() => _currentWorkoutIndex = index),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final workout = _workouts[index];
                    return Stack(
                      clipBehavior: Clip.none, 
                      children: [
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.black.withOpacity(0.08)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(workout["title"]!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 6),
                                      Text(workout["desc"]!, style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.3), maxLines: 4, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 4), 
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: -30, 
                          bottom: 0,
                          child: Image.asset(workout["image"]!, fit: BoxFit.contain),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_workouts.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _currentWorkoutIndex == index ? Colors.black : Colors.black26, 
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Metrics Grid
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      "Weight", "102 Kg", Icons.fitness_center, const Color(0xFFEEEDFF), const Color(0xFF6C63FF),
                      onTap: () => _showMetricDialog("Weight", const Color(0xFF6C63FF)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      "BMI", "18", Icons.accessibility_new, const Color(0xFFE8F5E9), const Color(0xFF4CAF50),
                      onTap: () => _showMetricDialog("BMI", const Color(0xFF4CAF50)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      "Water", "4 Glass", Icons.local_drink_outlined, const Color(0xFFFFF8E1), const Color(0xFFFFB300),
                      onTap: () => _showMetricDialog("Water", const Color(0xFFFFB300)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // UPDATED: Calories Bar Chart Container styling to perfectly mirror metric card borders
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1EB), // Soft internal fill background color
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    // Uses exact opacity formula layout setup matching the metrics row blocks
                    color: const Color(0xFFFFA07A).withOpacity(0.25), 
                    width: 1.5, 
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Calories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBarChartColumn("SUN", 12),
                        _buildBarChartColumn("MON", 12),
                        _buildBarChartColumn("TUE", 12),
                        _buildBarChartColumn("WED", 45),
                        _buildBarChartColumn("THU", 70), 
                        _buildBarChartColumn("FRI", 70),
                        _buildBarChartColumn("SAT", 12),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Featured Exercise
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Featured Exercise", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ExerciseScreen()),
                    );
                  }, 
                  child: const Text("See All", style: TextStyle(color: Colors.black54, fontSize: 13,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black54,
                  decorationThickness: 1.5,
                  ),
                  ),
                  ),
                ],
              ),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(image: AssetImage("assets/women-barbell.png"), fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomRight,
                  child: const Text("Intermediate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 80), 
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
     bottomNavigationBar: Container(
        height: 75, // Slightly increased height for native bottom-docked appearance
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F9),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), 
              blurRadius: 10, 
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: SafeArea(
          top: false, // Ensures native system navigation pills on iOS/Android don't clip your icons
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.fitness_center, color: _currentIndex == 0 ? Colors.black : Colors.black38, size: 28),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  child: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
                ),
              ),
              IconButton(
                icon: Icon(Icons.restaurant_menu_outlined, color: _currentIndex == 2 ? Colors.black : Colors.black38, size: 28),
                onPressed: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color bg, Color iconColor, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20), 
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: iconColor.withOpacity(0.25), 
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 36),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: iconColor),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartColumn(String day, double heightPercentage) {
    return Column(
      children: [
        Container(
          height: 100, 
          width: 28,
          decoration: const BoxDecoration(color: Colors.transparent),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: heightPercentage,
            width: 28,
            decoration: BoxDecoration(
              color: heightPercentage > 50 ? const Color(0xFFFFA07A) : const Color(0xFFFFD3C4), 
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}