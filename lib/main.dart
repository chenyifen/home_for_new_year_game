import 'package:flutter/material.dart';
import 'screens/initial_screen.dart';

void main() {
  runApp(HomeForNewYearGame());
}

class HomeForNewYearGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home for New Year',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialScreen(),
    );
  }
}