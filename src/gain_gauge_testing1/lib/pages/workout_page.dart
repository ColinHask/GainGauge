import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  final String label;

  const WorkoutPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    
    final Color color = Theme.of(context).colorScheme.secondary;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 1; i < 5; i++)
                    Card(
                      color: color,
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              ' ===== Workout $i ===== ',
                               style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: 20,
                               )
                                ),
                            SizedBox(
      
                              height: 400,
                              width: 300,
                              child: Placeholder(color: Theme.of(context).colorScheme.onSecondary,)
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
