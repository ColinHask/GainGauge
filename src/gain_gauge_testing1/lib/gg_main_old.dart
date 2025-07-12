import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyTabbedApp(),
    );
  }
}

class MyTabbedApp extends StatelessWidget {
  const MyTabbedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flatware_rounded), text: 'Diet Tracker'),
              Tab(icon: Icon(Icons.bolt), text: 'Exercise Tracker'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabPage(color: Color.fromARGB(255, 33, 163, 78), label: 'EAT CLEAN!'),
            TabPage(color: Color.fromARGB(255, 210, 24, 24), label: 'LIFT HEAVY!'),
          ],
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final Color color;
  final String label;



  const TabPage({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 6),
        Expanded(
            child: SingleChildScrollView(

              child: Column(
                
                children: [
                  for (var i = 0; i < 20; i++) 
                    Card(
                      color: color,
                      margin: EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          Text(' ===== SOMETHING NUMBER $i ===== '),
                          for (var j = 0; j < 5; j++)
                            Text("sub-something #$j")
                        ],),
                      )
                      ),

                ],
              ),
            ),
        ),
      ],
    );
  }
}
