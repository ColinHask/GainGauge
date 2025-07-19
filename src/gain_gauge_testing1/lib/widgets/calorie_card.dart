import 'package:flutter/material.dart';
import '../models/day_data.dart';

/// Shows one day's nutrition info

class CalorieCard extends StatelessWidget {
  const CalorieCard({super.key, required this.data});

  final DayData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Card(
        color: theme.colorScheme.onPrimary,
        elevation: 9,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                " Day #${data.dayNumber} ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var item in data.foodItems)
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${item.name}: ${item.calories}cal | ${(item.protein != null)? item.protein: 0 }g protein ",
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        elevation: 1,
                        color: (data.totalCalories <= data.calorieGoal && data.totalCalories < (data.calorieGoal - 100))
                            ? const Color.fromARGB(255, 190, 246, 218)
                            : (data.totalCalories < data.calorieGoal)
                            ? const Color.fromARGB(255, 236, 231, 179)
                            : const Color.fromARGB(255, 246, 203, 203),

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Calories: ${data.totalCalories} ",
                              textScaler: TextScaler.linear(1.5),
                            ),
                          ),
                        ),
                      ),
      
                      Card(
                        color: (data.totalProtein >= data.proteinGoal)
                            ? const Color.fromARGB(255, 190, 246, 218)
                            : const Color.fromARGB(255, 246, 203, 203),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Protein: ${data.totalProtein} ",
                              textScaler: TextScaler.linear(1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
