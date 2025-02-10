import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/widgets/board_view.dart';
import 'package:home_for_new_year_game/widgets/car_view.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('回家过年'),
        centerTitle: true,
        backgroundColor: Color(0xFF3421AC),
      ),
      backgroundColor: Color(0xFF3421AC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CarView(
                    totalSeats: 5,
                    currentSeats: 3,
                    waitingPersons: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('候车'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF35257E), // 背景颜色
                      ),
                    ),
                  ),
                  BoardView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}