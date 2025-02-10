import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/widgets/board_view.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home for New Year'),
      ),
      body: Column(
        children: [
          Text(
            'Welcome to Home for New Year Game!',
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: BoardView(),
          ),
        ],
      ),
    );
  }
}