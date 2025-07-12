import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/day_data.dart';

// Modular Popup for Adding New Meal
class MealInputPopup extends StatefulWidget {
  final void Function(FoodItem) onSubmit;

  const MealInputPopup({super.key, required this.onSubmit});

  @override
  State<MealInputPopup> createState() => _MealInputPopupState();
}

class _MealInputPopupState extends State<MealInputPopup> {
  // Controllers for the form fields
  final _nameController = TextEditingController();
  final _calController = TextEditingController();
  final _proteinController = TextEditingController();
  final _weightController = TextEditingController();

  // Cleanup controllers to avoid memory leaks
  @override
  void dispose() {
    _nameController.dispose();
    _calController.dispose();
    _proteinController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Handle form submission and validation
  void _submit() {
    try {
      final name = _nameController.text;
      final calories = double.parse(_calController.text);
      final protein = double.tryParse(_proteinController.text);
      final weight = double.tryParse(_weightController.text);

      if (name.isEmpty) throw Exception("Name cannot be empty");

      final newItem = FoodItem(
        name: name,
        calories: calories,
        protein: protein,
        weight: weight,
      );

      widget.onSubmit(newItem); // Send to parent
      Navigator.of(context).pop(); // Close popup
    } catch (e) {
      // Show error if input is invalid
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Invalid input: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Wrap in Padding and SingleChildScrollView for keyboard safety
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add New Meal", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),

              _buildTextField("Meal Name", _nameController),
              _buildTextField("Calories", _calController, isNumeric: true),
              _buildTextField("Protein", _proteinController, isNumeric: true),
              _buildTextField("Weight (g)", _weightController, isNumeric: true),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // DRY reusable input field generator
  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
