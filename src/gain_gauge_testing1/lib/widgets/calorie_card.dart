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
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (var item in data.foodItems) FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("${data.foodItems.indexOf(item) + 1}) ${item.name} | Cals: ${item.calories}")
                        ),
                    ],
                  ),
                ),
                Expanded(child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Calories total: ${data.totalCalories} ", textScaler: TextScaler.linear(1.5),)
                      ),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}