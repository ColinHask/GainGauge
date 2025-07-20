import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  final VoidCallback onClearData;

  const DebugPage({
    super.key,
    required this.onClearData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
          
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("DESTROY all user data"),
                  SizedBox(width: 5,),
                  ElevatedButton(
                    onPressed: onClearData,
                    child: Text("clear"),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
