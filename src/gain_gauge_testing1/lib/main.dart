import 'package:flutter/material.dart';
import 'pages/tabbed_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GainGauge",
      
      theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 249, 238, 208),
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity),
            
        ),


      home: MyTabbedApp(),
    );
  }
}
