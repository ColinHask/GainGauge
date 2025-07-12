// Represents a single food item with its nutritional values.
class FoodItem {
  final String name;
  final double calories;
  final double? weight;   // Optional weight in grams
  final double? protein;  // Optional grams of protein
  final double? carbs;    // Optional grams of carbohydrates
  final double? fat;      // Optional grams of fat

  // Constructor for creating a FoodItem. Fields marked with `required` must be provided.
  FoodItem({
    required this.name,
    required this.calories,
    this.weight,
    this.protein,
    this.carbs,
    this.fat,
  });
}

// Represents a single day's worth of logged food and computes totals.
class DayData {
  final int dayNumber;            // Example: Day 1, Day 2, etc.
  final List<FoodItem> foodItems; // A list of all foods eaten on this day.

  // Constructor to create a DayData object with day number and list of food items.
  DayData({required this.dayNumber, required this.foodItems});

  // Getter to compute total calories from all food items.
  // The `=>` fat arrow means "return the result of this expression".
  double get totalCalories =>
      foodItems.fold(0, (sum, item) => sum + item.calories);
  // Equivalent to:
  // int get totalCalories {
  //   return foodItems.fold(0, (sum, item) => sum + item.calories);
  // }

  // Getter to compute total protein. If a food item doesn't have protein, assume 0.
  double get totalProtein =>
      foodItems.fold(0, (sum, item) => sum + (item.protein ?? 0));

  // Total carbs
  double get totalCarbs =>
      foodItems.fold(0, (sum, item) => sum + (item.carbs ?? 0));

  // Total fat
  double get totalFat =>
      foodItems.fold(0, (sum, item) => sum + (item.fat ?? 0));
}
