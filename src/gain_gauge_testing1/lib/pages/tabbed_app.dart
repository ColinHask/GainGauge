import 'package:flutter/material.dart';
import 'package:gain_gauge_testing1/pages/my_custom_form.dart';
import 'package:gain_gauge_testing1/pages/today_page.dart';
import 'diet_history_page.dart';
import 'workout_page.dart';
import '../models/day_data.dart';
class MyTabbedApp extends StatefulWidget {
  const MyTabbedApp({super.key});

  @override
  State<MyTabbedApp> createState() => _MyTabbedAppState();
}

class _MyTabbedAppState extends State<MyTabbedApp> {
  
  late final List<DayData> _dietHistory;
  int _selectedIndex = 1;

  late DayData currentDay; // moved out of initState

 @override
  void initState() {
    super.initState();

    _dietHistory = [

      //TODO: load from file history here
      
    ];

  currentDay = DayData(dayNumber: _dietHistory.length + 1, foodItems: [

  ]);


  }

    Widget _getPage(int index) {
  switch (index) {
    case 0:
      return DietHistoryPage(dietHistory: _dietHistory);
    case 1:
      return TodayPage(
        currentDay: currentDay,
        onDayChange: () => _rotateDay(),
      );
    case 2:
      return WorkoutPage(label: 'LIFT HEAVY!');
    case 3:
      return MyCustomForm();
    default:
      return Center(child: Text("Invalid Page"));
  }
}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _rotateDay(){
    setState(() {
      // TODO: modify this to be NOT demo data but real history
      _dietHistory.add(currentDay);
      currentDay = DayData(dayNumber: currentDay.dayNumber + 1, foodItems: []);
    });
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
          selectedIconTheme: IconThemeData(size: 30, color: Theme.of(context).primaryColorDark),
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
              )
          ]
        ),


      );
  }
}
