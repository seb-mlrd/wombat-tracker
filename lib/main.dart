import 'package:flutter/material.dart';
import 'package:wombat_tracker/content.dart';
// import 'package:wombat_tracker/styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Content(),
        ),
      ),
    );
  }
}
