import 'package:flutter/material.dart';
import '../models/day_data.dart';


/// Shows one day's nutrition info

class CalorieCard extends StatelessWidget {
  const CalorieCard({
    super.key,
    required this.data,
  });

  final DayData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.onPrimary,
      elevation: 9,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(" Day #${data.dayNumber} ", textScaler: TextScaler.linear(1.5),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var item in data.foodItems) FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("${data.foodItems.indexOf(item) + 1}) ${item.name} | Cals: ${item.calories}")
                        ),
                    ],
                  ),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Card(
                      elevation: 1,
                      color: (data.totalCalories <= data.calorieGoal) ? Colors.greenAccent : Colors.redAccent, 
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("Calories: ${data.totalCalories} ", textScaler: TextScaler.linear(1.5),)
                          ),
                      ),
                    ),
                    
                   Card(
                  color: (data.totalProtein >= data.proteinGoal) ? Colors.greenAccent : Colors.redAccent, 
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Protein: ${data.totalProtein} ", textScaler: TextScaler.linear(1.5),)
                      ),
                  ),
                )
                
                  ],
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}