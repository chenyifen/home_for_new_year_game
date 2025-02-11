import 'dart:math';
import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/game_object.dart';
import 'package:home_for_new_year_game/widgets/person_view.dart';
import 'package:home_for_new_year_game/widgets/obstacle_view.dart';
import 'package:home_for_new_year_game/models/board.dart';
import 'package:home_for_new_year_game/models/person.dart';
import 'package:home_for_new_year_game/models/obstacle.dart';
import 'package:home_for_new_year_game/controllers/main_controller.dart';
import 'package:provider/provider.dart';

class BoardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<MainController>(context);
    final board = controller.gameState.boardState.board;  // Obtain the modified board
    final gridSize = MediaQuery.of(context).size.width > 600
        ? 600.0
        : MediaQuery.of(context).size.width - 40;
    final cellSize = (gridSize - (5 * 4)) / 6;
    final waitingAreaHeight = cellSize;

    return Center(
      child: Column(
        children: [
          Container(
            width: gridSize,
            height: waitingAreaHeight,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  if (index == 0) {
                    return Container(
                      width: cellSize,
                      height: cellSize,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFF35257E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/waiting_icon.png',
                        fit: BoxFit.contain,
                      ),
                    );
                  } else {
                    return Container(
                      width: cellSize,
                      height: cellSize,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFF35257E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: controller.gameState.waitingArea.waitingPersons.length > (index - 1)
                          ? Image.asset(
                              'assets/images/person_${controller.gameState.waitingArea.waitingPersons[index - 1].color}.png')
                          : Container(),
                    );
                  }
                }),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: gridSize,
            height: gridSize,
            child: GridView.builder(
              padding: EdgeInsets.all(4),
              itemCount: board.grid.length * board.grid.length, // 6x6 board
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) {
                int x = index % 6;
                int y = index ~/ 6;
                GameObject? item = board.grid[x][y];
                bool isEvenCell = (x + y) % 2 == 0;

                return Container(
                  decoration: BoxDecoration(
                    color: isEvenCell
                        ? Color(0xFF35257E)
                        : Color(0xFF281C79),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: item == null
                      ? Container()
                      : item is Person
                          ? PersonView(
                              person: item,
                              onTap: () {
                                controller.handlePersonClick(item);
                              },
                            )
                          : item is Obstacle
                              ? ObstacleView(
                                  obstacle: item,
                                  onTap: () {
                                    controller.handleObstacleClick(item);
                                  },
                                )
                              : Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}