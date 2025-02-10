import 'package:flutter/material.dart';

class BoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      itemCount: 36, // 6x6 board
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Center(
            child: Text(
              '$index',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}