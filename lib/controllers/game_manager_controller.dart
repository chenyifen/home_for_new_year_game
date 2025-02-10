import 'package:home_for_new_year_game/models/game_state.dart';

class GameManagerController {
  final GameState gameState;

  GameManagerController({required this.gameState});

  void startGame() {
    gameState.reset();
  }

  void endGame() {
    // Implement your game over logic here
    print("Game Over!");
  }

  bool checkGameOver() {
    return gameState.isGameOver();
  }

  bool checkWin() {
    return gameState.isWin();
  }
}