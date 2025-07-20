import 'package:flutter/material.dart';
import 'package:gain_gauge_testing1/models/day_data.dart';
import 'package:gain_gauge_testing1/widgets/meal_input_popup.dart'; // Popup for new meals

//==============================
// Main TodayPage Widget (Stateful)
//==============================
class TodayPage extends StatefulWidget {
  final DayData currentDay; // Current day's data object, passed from parent
  final VoidCallback onDayChange; // Called when user moves to next day
  final VoidCallback onDayUpdate; // Called when user updates today's items

  const TodayPage({super.key, required this.currentDay, required this.onDayChange, required this.onDayUpdate});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  // Open bottom sheet popup to add a new meal
  void _showMealInputPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows it to adjust for keyboard
      builder: (context) {
        return MealInputPopup(
          onSubmit: (FoodItem item) {
            setState(() {
              widget.currentDay.foodItems.add(item);
              widget.onDayUpdate();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,

      // Main page content
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Centered Day Number
              Center(
                child: Text(
                  'Day ${widget.currentDay.dayNumber}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),

              const SizedBox(height: 8),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                  Card(child: Padding(padding: EdgeInsetsGeometry.all(8),
                   child: Column(
                    
                    children: [ 
                      Text("UNDER", style: Theme.of(context).textTheme.titleSmall,),
                      Text("${widget.currentDay.calorieGoal} Calories", style: Theme.of(context).textTheme.titleSmall,)  ],
                   ) ,),),
                
                   Card(child: Padding(padding: EdgeInsetsGeometry.all(8),
                   child: Column(
                    children: [ 
                      Text("OVER", style: Theme.of(context).textTheme.titleSmall,),
                      Text("${widget.currentDay.proteinGoal}g Protein", style: Theme.of(context).textTheme.titleSmall,)  ],
                   ),
                   ),
                   ),
                
                
                  ],),
              ),

              const SizedBox(height: 10),


              // Centered Next DSay Button
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: NextDayButton(
                    onConfirm: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Confirmed! Moving to next day...")),
                      );
                      widget.onDayChange();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // goals section              const SizedBox(height: 10),

              

              const SizedBox(height: 20),

              // Show list if there are any meals
              if (widget.currentDay.foodItems.isNotEmpty)
                _MealList(
                  foodItems: widget.currentDay.foodItems,
                  onRemove: (index) {
                    setState(() {
                      widget.currentDay.foodItems.removeAt(index);
                      widget.onDayUpdate();
                    });
                  },
                ),

                const SizedBox(height: 80),

            ],
          ),
        ),
      ),

      // + Button to Add New Meal via Popup
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 35),
        child: FloatingActionButton(
          onPressed: _showMealInputPopup,
          child: const Icon(Icons.add),
        ),
      ),

      // Sticky footer summary
      bottomSheet: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Calories: ${widget.currentDay.totalCalories} (${widget.currentDay.caloriePercent}%)"),
            Text("Protein: ${widget.currentDay.totalProtein} (${widget.currentDay.proteinPercent}%)"),
          ],
        ),
      ),
    );
  }
}

//=============================================
// Widget to display list of current food items
//=============================================
class _MealList extends StatelessWidget {
  final List<FoodItem> foodItems;
  final void Function(int index) onRemove;

  const _MealList({required this.foodItems, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text("Today's Meals", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          for (var item in foodItems)
            Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text("Calories: ${item.calories}  |  Protein: ${item.protein ?? 0}"),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => onRemove(foodItems.indexOf(item)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

//===================================================
// Next Day Button with confirmation popup dialog box
//===================================================
class NextDayButton extends StatelessWidget {
  final VoidCallback onConfirm;

  const NextDayButton({super.key, required this.onConfirm});

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to move to the next day? This cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                onConfirm(); // Run the callback
              },
              child: const Text("Yes, Continue"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.navigate_next),
      label: const Text("Next Day"),
      onPressed: () => _showConfirmationDialog(context),
    );
  }
}
