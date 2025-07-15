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

  // Convert to JSON map
  Map<String, dynamic> toJson() => {
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'weight': weight,
      };

  // Construct from JSON map
  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        name: json['name'],
        calories: json['calories'],
        protein: json['protein'],
        carbs: json['carbs'],
        fat: json['fat'],
        weight: json['weight'],
      );




}

// Represents a single day's worth of logged food and computes totals.
class DayData {
  final int dayNumber;            // Example: Day 1, Day 2, etc.
  final List<FoodItem> foodItems; // A list of all foods eaten on this day.
  final double calorieGoal;
  final double proteinGoal;

  // Constructor to create a DayData object with day number and list of food items.
  DayData({required this.dayNumber, required this.foodItems, required this.calorieGoal, required this.proteinGoal});

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

  int get caloriePercent => ((totalCalories / calorieGoal) * 100).round();
  int get proteinPercent => ((totalProtein / proteinGoal) * 100).round();

    // Convert to JSON map
  Map<String, dynamic> toJson() => {
        'dayNumber': dayNumber,
        'foodItems': foodItems.map((item) => item.toJson()).toList(),
        'calorieGoal': calorieGoal,
        'proteinGoal': proteinGoal,
      };

  // Construct from JSON map
  factory DayData.fromJson(Map<String, dynamic> json) => DayData(
        dayNumber: json['dayNumber'],
        foodItems: (json['foodItems'] as List)
            .map((item) => FoodItem.fromJson(item))
            .toList(),
            calorieGoal: json['calorieGoal'],
            proteinGoal: json['proteinGoal'],
      );

}
