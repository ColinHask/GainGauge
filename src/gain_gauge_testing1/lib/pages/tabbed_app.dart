
/// TODO:
/// - serialize data into json file
/// - write data to file as str
/// - parse json -> datdata list on startup
/// 
/// FUTURE TODO:
/// - Today page
///   - auto fill option on meal entry
///   - Saving food items? (seperate json)
///   - rename meal to food item
///
/// - Workout page
///   - split creator
///   - data entry
///   - data storage
/// 
/// - ADD settings 
///   - what to track
///   - workout vs diet preference
///   - diet goal setting (weekly vs biweekly vs custom # of days)
///



import 'package:flutter/material.dart';
import 'package:gain_gauge_testing1/pages/my_custom_form.dart';
import 'package:gain_gauge_testing1/pages/today_page.dart';
import 'package:gain_gauge_testing1/storage/diet_storage.dart';
import 'diet_history_page.dart';
import 'workout_page.dart';
import '../models/day_data.dart';

/// Main entry widget that manages all tabs/pages of the app:
/// - Diet History
/// - Today Tracking
/// - Workout
/// - Testing Form

class MyTabbedApp extends StatefulWidget {
  const MyTabbedApp({super.key});

  @override
  State<MyTabbedApp> createState() => _MyTabbedAppState();
}

class _MyTabbedAppState extends State<MyTabbedApp> {
  // List to store the full diet history
  List<DayData> _dietHistory = [];

  // Tracks which tab is selected
  int _selectedIndex = 1;

 DayData get currentDay => _dietHistory.last;


  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved diet history on startup
  }

  /// Loads saved diet history JSON and initializes current day
bool _isLoading = true;

void _loadData() async {
  final history = await loadDietHistory();
  setState(() {

    // add starter day if history is empty
    _dietHistory = history.isEmpty
        ? [DayData(dayNumber: 1, foodItems: [], calorieGoal: 2000, proteinGoal: 110)]
        : history;
    
    _isLoading = false;
    
  });
}

  /// Determines which page to display based on the selected tab
  Widget _getPage(int index) {
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    switch (index) {
      case 0:
        return DietHistoryPage(dietHistory: _dietHistory);
      case 1:
        return TodayPage(
          currentDay: currentDay,
          onDayChange: _rotateDay, // Rotate day callback
          onDayUpdate: () async => await saveDietHistory(_dietHistory),
        );
      case 2:
        return WorkoutPage(label: 'LIFT HEAVY!');
      case 3:
        return MyCustomForm();
      default:
        return const Center(child: Text("Invalid Page"));
    }
  }

  /// Called when a different tab is selected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// adds new day
  void _rotateDay() async {
    setState(() {
      _dietHistory.add(DayData(dayNumber: currentDay.dayNumber + 1, foodItems: [], calorieGoal: 2000, proteinGoal: 110)); // Add completed day to history
    });

    // Persist the new diet history to disk
    await saveDietHistory(_dietHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(child: _getPage(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(
          size: 30,
          color: Theme.of(context).primaryColorDark,
        ),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Diet History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flatware),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science_rounded),
            label: 'TESTING',
          ),
        ],
      ),
    );
  }
}
