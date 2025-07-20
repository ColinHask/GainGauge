import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/day_data.dart';

/// The name of the file we will use to store the diet history.
const String _dietFileName = 'diet_history.json';

/// Returns the full path to the file where we save the diet history.
Future<String> _getDietFilePath() async {
  final dir = await getApplicationDocumentsDirectory(); // Platform-specific app storage dir
  return '${dir.path}/$_dietFileName';
}

/// Saves the full diet history list to a JSON file.
Future<void> saveDietHistory(List<DayData> history) async {
  final path = await _getDietFilePath();

  final jsonData = jsonEncode(history.map((day) => day.toJson()).toList());

  final file = File(path);
  await file.writeAsString(jsonData);
}

/// Loads the diet history list from the JSON file.  
/// Returns an empty list if no file exists.
Future<List<DayData>> loadDietHistory() async {
  try {
    final path = await _getDietFilePath();
    final file = File(path);

    if (!await file.exists()) {
      return []; // File doesn't exist yet
    }

    final jsonString = await file.readAsString();
    final List<dynamic> data = jsonDecode(jsonString);

    return data.map((item) => DayData.fromJson(item)).toList();
  } catch (e) {
    print('Failed to load diet history: $e');
    return [];
  }
}
