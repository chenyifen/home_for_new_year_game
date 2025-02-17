import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/initial_screen.dart';
import 'controllers/main_controller.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainController(context, scaffoldMessengerKey),
        ),
      ],
      child: MaterialApp(
        title: 'Home for New Year',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          primaryColor: Color(0xFF3421AC),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: InitialScreen(),
      ),
    ),
  );
}