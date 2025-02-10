import 'person.dart';
import 'obstacle.dart';
import 'board.dart';
import 'game_object.dart';

class BoardState {
  final Board board;

  BoardState(this.board);

  void removePerson(int x, int y) {
    if (board.grid[x][y] is Person) {
      board.grid[x][y] = null;
    }
  }

  GameObject? getObjectAt(int x, int y) {
    return board.getObjectAt(x, y);
  }

  void placePerson(int x, int y, Person person) {
    board.placePerson(x, y, person);
  }

  void placeObstacle(int x, int y, Obstacle obstacle) {
    board.placeObstacle(x, y, obstacle);
  }

  void checkVictory() {
    // Victory check logic
  }
}