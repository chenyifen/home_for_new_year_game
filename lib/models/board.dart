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
    print("Placed person at ($x, $y) with color ${person.color}");
  }

  void placeObstacle(int x, int y, Obstacle obstacle) {
    grid[x][y] = obstacle;
    print("Placed obstacle at ($x, $y)");
  }

  GameObject? getObjectAt(int x, int y) {
    return grid[x][y];
  }

  void removePerson(int x, int y) {
    if (grid[x][y] is Person) {
      grid[x][y] = null;
      print("Removed person at ($x, $y)");
    }
  }

  void clear() {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        grid[y][x] = null;
      }
    }
  }

}