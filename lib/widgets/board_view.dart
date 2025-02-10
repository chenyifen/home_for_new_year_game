import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/game_object.dart';
import 'package:home_for_new_year_game/models/board.dart';
import 'package:home_for_new_year_game/models/person.dart';
import 'package:home_for_new_year_game/models/obstacle.dart';

class BoardView extends StatelessWidget {
  final Board board = Board();

  @override
  Widget build(BuildContext context) {
    final gridSize = MediaQuery.of(context).size.width > 600
        ? 600.0
        : MediaQuery.of(context).size.width - 40;

    return Center(
      child: Container(
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
            return Container(
              color: Colors.grey[300],
              child: item == null
                  ? Container()
                  : item is Person
                      ? Image.asset(
                          item.imagePath,
                          width: gridSize / 6 - 8,
                          height: gridSize / 6 - 8,
                        )
                      : item is Obstacle
                          ? Image.asset(
                              item.imagePath,
                              width: gridSize / 6 - 8,
                              height: gridSize / 6 - 8,
                            )
                          : Container(),
            );
          },
        ),
      ),
    );
  }
}