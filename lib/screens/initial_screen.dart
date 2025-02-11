import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/widgets/board_view.dart';
import 'package:home_for_new_year_game/widgets/car_view.dart';
import 'package:provider/provider.dart';
import 'package:home_for_new_year_game/controllers/main_controller.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final carWidth = screenWidth > 600 ? 300.0 : screenWidth / 2;

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
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: carWidth * 1.5,
                    child: CarView(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<MainController>().resetGame(),
                      child: Text('重置游戏'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF35257E),
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
