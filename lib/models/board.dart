import 'game_object.dart';
import 'person.dart';
import 'obstacle.dart';

class Board {
  final int width;
  final int height;
  List<List<GameObject?>> grid;

  Board({this.width = 6, this.height = 6})
      : grid = List.generate(6, (_) => List.filled(6, null));

  void placePerson(int x, int y, Person person) {
    grid[x][y] = person;
  }

    void removePerson(int x, int y) {
    grid[x][y] = null;
  }

  void placeObstacle(int x, int y, Obstacle obstacle) {
    grid[x][y] = obstacle;
  }

  GameObject? getObjectAt(int x, int y) {
    return grid[x][y];
  }
}