import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_for_new_year_game/models/board.dart';
import 'package:home_for_new_year_game/models/car.dart';
import 'package:home_for_new_year_game/models/person.dart';
import 'package:home_for_new_year_game/models/obstacle.dart';
import 'package:home_for_new_year_game/models/game_state.dart';
import 'package:home_for_new_year_game/models/waiting_area.dart';
import 'package:home_for_new_year_game/models/board_state.dart';
import 'package:home_for_new_year_game/models/car_queue_state.dart';

class MainController with ChangeNotifier {
  late GameState gameState;
  final BuildContext context;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  MainController(this.context, this.scaffoldMessengerKey) {
    resetGame();
  }

  void resetGame() {
    final board = Board();
    final carQueue = [
      Car(0, 0, 'red', 4),
      Car(0, 0, 'green', 5),
      Car(0, 0, 'blue', 3),
      Car(0, 0, 'yellow', 5),
      Car(0, 0, 'red', 3),
      Car(0, 0, 'green', 5),
      Car(0, 0, 'blue', 4),
      Car(0, 0, 'yellow', 3)
    ];

    gameState = GameState(
      BoardState(board),
      CarQueueState(carQueue),
      WaitingArea(),
    );
    notifyListeners();
  }

  void handlePersonClick(Person person) {
    print('Person Clicked: ${person.color} at (${person.x}, ${person.y})');
    if (gameState.carQueueState.currentCar != null) {
      final currentCar = gameState.carQueueState.currentCar!;
      if (_canPersonMove(person)) {
        gameState.boardState.removePerson(person.x, person.y);
        notifyListeners();

        if (person.color == currentCar.color) {
          animatePersonToCar(person, currentCar);
        } else {
          if (gameState.waitingArea.addPerson(person)) {
            animatePersonToWaitingArea(person);
          } else {
            _showGameOver();
          }
        }
        notifyListeners();
      } else {
        _showMessageAtPersonPosition(person, "我被挡住啦");
      }
    }
  }

  bool _canPersonMove(Person person) {
    final board = gameState.boardState.board;
    final List<int> dx = [0, 1, 0, -1];
    final List<int> dy = [1, 0, -1, 0];
    for (int direction = 0; direction < 4; direction++) {
      final int newX = person.x + dx[direction];
      final int newY = person.y + dy[direction];
      if (newX >= 0 && newX < board.width && newY >= 0 && newY < board.height) {
        if (board.getObjectAt(newX, newY) == null) {
          return true;
        }
      }
    }
    return false;
  }

  void handleObstacleClick(Obstacle obstacle) {
    print('Obstacle Clicked: at (${obstacle.x}, ${obstacle.y})');
    _showMessage("障碍物不可移动");
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }

  void _showMessageAtPersonPosition(Person person, String message) {
    final snackBar = SnackBar(content: Text(message), behavior: SnackBarBehavior.floating);
    scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }

  void _showGameOver() {
    print("Game Over!");
  }

  void animatePersonToCar(Person person, Car car) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final snackBar = SnackBar(content: Text("${person.color} 小人上车"));
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

      car.addPerson(person);
      if (car.seatCount == 0) {
        gameState.carQueueState.moveToNextCar();
        _animateCarDepartAndArrive();
      }
      notifyListeners();
    });
  }

  void animatePersonToWaitingArea(Person person) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final snackBar = SnackBar(content: Text("${person.color} 小人进入候车区"));
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

      notifyListeners();
    });
  }
   
  void _animateCarDepartAndArrive() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final snackBar = SnackBar(content: Text("车辆驶离，下一辆车进场"));
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
      notifyListeners();
    });
  }
}