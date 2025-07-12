import 'package:flutter/material.dart';
import '../widgets/calorie_card.dart';
import '../models/day_data.dart';

// ==========================
// Main Page for Viewing Diet History
// ==========================
class DietHistoryPage extends StatefulWidget {
  // A label prefix shown above the list (customizable in future)
  final label = "Selected Edit Day: ";

  // List of DayData representing the user's tracked meal history
  final List<DayData> dietHistory;

  DietHistoryPage({super.key, required this.dietHistory});

  @override
  State<DietHistoryPage> createState() => _DietHistoryPageState();
}

class _DietHistoryPageState extends State<DietHistoryPage> {
  // Tracks which day index is being "edited" (if applicable)
  int counter = 0;

  // This isn't currently used, but could be used to count active days
  int days = 0;

  // Callback for when a user clicks the Edit button on a day card
  void _editDay(int index) {
    setState(() {
      counter = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ===========================
    // Build the dynamic page body
    // ===========================

    // Instead of using inline `if (condition) ? widget : widget`, we use a clearer if/else structure.
    // This makes it more readable and manageable for future logic expansions.
    Widget historyContent;

    if (widget.dietHistory.isEmpty) {
      // If there's no data, show a centered message
      historyContent = Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "Nothing to see here...",
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      // If there is data, show the list of Day cards (reversed order for most recent at bottom)
      historyContent = SingleChildScrollView(
        child: Column(
          verticalDirection: VerticalDirection.up, // Reverses order so most recent day appears at bottom
          children: [
            for (var day in widget.dietHistory)
              Row(
                children: [
                  const SizedBox(width: 20), // Left padding
                  
                  // Main day summary widget (wrapped in Expanded to fill horizontal space)
                  Expanded(
                    child: CalorieCard(data: day),
                  ),

                  const SizedBox(width: 20), // Spacing between card and FAB

                  // Show an "Edit" button only on the most recent day (last index)
                  if (widget.dietHistory.indexOf(day) == widget.dietHistory.length - 1)
                    FloatingActionButton(
                      mini: true,
                      onPressed: () => _editDay(widget.dietHistory.indexOf(day)),
                      child: const Icon(Icons.edit),
                    ),

                  const SizedBox(width: 20), // Right margin
                ],
              ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 6),

            // Label showing currently selected day index
            Text(
              "${widget.label} $counter",
              style: const TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 6),

            // The core content of the page (either the list or the empty message)
            Expanded(child: historyContent),
          ],
        ),
      ),
    );
  }
}
