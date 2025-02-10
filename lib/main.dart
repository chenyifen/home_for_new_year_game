import 'package:flutter/material.dart';
import 'screens/initial_screen.dart';

void main() {
  runApp(HomeForNewYearGame());
}

class HomeForNewYearGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '回家过年',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Color(0xFF3421AC),

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme.
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: InitialScreen(),
    );
  }
}