import 'board_state.dart';
import 'person.dart';

class GameRules {

  bool canPersonMove(Person person, int x, int y) {
    // Basic implementation to check if the move is possible
    // Placeholder method: additional logic needed
    return true;
  }

  bool checkVictory(BoardState boardState) {
    // Victory if no person left on board
    for (var row in boardState.grid) {
      for (var cell in row) {
        if (cell is Person) {
          return false;
        }
      }
    }
    return true;
  }
}