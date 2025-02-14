import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';
import 'package:home_for_new_year_game/models/board.dart';
import 'package:home_for_new_year_game/models/car.dart';
import 'package:home_for_new_year_game/models/person.dart';
import 'package:home_for_new_year_game/models/obstacle.dart';
import 'package:home_for_new_year_game/models/game_state.dart';
import 'package:home_for_new_year_game/models/waiting_area.dart';
import 'package:home_for_new_year_game/models/board_state.dart';
import 'package:home_for_new_year_game/models/car_queue_state.dart';
import 'package:home_for_new_year_game/utils/game_info.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MainController with ChangeNotifier {
  late GameState gameState;
  final BuildContext context;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  int presetUsageCount = 0;
  List<dynamic> presets = [];
  double carViewOffset = 0.0;
  final board = Board();
  final carQueue = <Car>[];


  MainController(this.context, this.scaffoldMessengerKey) {
    _initializeController();
  }

  Future<void> _initializeController() async {
    GameInfo.loadGameInfo();
    await loadPresets(); // 等待预设加载完成
    if (presets.isNotEmpty) {
      _initializeWithPreset(presets[presetUsageCount]);
      presetUsageCount++;
    } else {
      _initializeBoardAuto();
    }
    notifyListeners(); // 确保UI更新
  }

  Future<void> loadPresets() async {
    final String response = await rootBundle.loadString('assets/presets.json');
    final data = await json.decode(response);
    presets = data['presets'];

    // 添加打印语句以输出加载的预设信息
    print('Loaded Presets:');
    for (var i = 0; i < presets.length; i++) {
      print('Preset $i:');
      print('Board: ${presets[i]['board']}');
      print('CarQueue: ${presets[i]['carQueue']}');
    }
  }

  void resetGame() {
    if (presetUsageCount < presets.length) {
      _initializeWithPreset(presets[presetUsageCount]);
      presetUsageCount++;
    } else {
      _initializeBoardAuto();
    }


    gameState = GameState(
      BoardState(board),
      CarQueueState(carQueue),
      WaitingArea(),
    );


    // Notify listeners
    notifyListeners();
  }

  void _initializeWithPreset(Map<String, dynamic> preset) {

    // 定义颜色映射
    final colorMap = {
      'r': 'red',
      'y': 'yellow',
      'b': 'blue',
      'g': 'green',
    };

    for (int y = 0; y < preset['board'].length; y++) {
      for (int x = 0; x < preset['board'][y].length; x++) {
        final cell = preset['board'][y][x];
        if (colorMap.containsKey(cell)) {
          board.placePerson(x, y, Person(x, y, colorMap[cell]!));
        } else if (cell == 'o') {
          board.placeObstacle(x, y, Obstacle(x, y));
        }
      }
    }

    final rawCarList = preset['carQueue'];

    for (var carInfo in rawCarList) {
      final colorCode = carInfo[0];
      final color = colorMap[colorCode] ?? 'unknown'; // 使用映射转换颜色代码
      final seats = carInfo[1];
      carQueue.add(Car(0, 0, color, seats));
    }

     gameState = GameState(
      BoardState(board),
      CarQueueState(carQueue),
      WaitingArea(),
    );

    // Print carQueue information for debugging
    print('CarQueue from Preset:');
    for (var car in carQueue) {
      print('Car color: ${car.color}, seats: ${car.seatCount}');
    }

    print('Game reset with preset setup.');
  }

  void _initializeBoardAuto() {
    _initializeBoard(board, GameInfo.difficulty);

    // Calculate totals for each color
    final colorCounts = {'red': 0, 'green': 0, 'blue': 0, 'yellow': 0};
    for (var row in board.grid) {
      for (var cell in row) {
        if (cell is Person) {
          colorCounts[cell.color] = colorCounts[cell.color]! + 1;
        }
      }
    }

    // Generate car queue based on person counts
    final random = Random();
    colorCounts.forEach((color, count) {
      while (count > 0) {
        final seats = min(count, random.nextInt(4) + 2); // Cars have 2-5 seats
        carQueue.add(Car(0, 0, color, seats));
        count -= seats;
      }
    });

    // Shuffle car queue
    carQueue.shuffle();

    gameState = GameState(
      BoardState(board),
      CarQueueState(carQueue),
      WaitingArea(),
    );

    // Print carQueue information for debugging
    print('CarQueue:');
    for (var car in carQueue) {
      print('Car color: ${car.color}, seats: ${car.seatCount}');
    }

    print('Game reset with initial setup.');
  }

  void resetGame2() {
    final board = Board();
    _initializeBoard(board, GameInfo.difficulty);

    // 计算每种颜色的小人总数
    final colorCounts = {'red': 0, 'green': 0, 'blue': 0, 'yellow': 0};
    for (var row in board.grid) {
      for (var cell in row) {
        if (cell is Person) {
          colorCounts[cell.color] = colorCounts[cell.color]! + 1;
        }
      }
    }

    // 根据小人总数生成车队
    final carQueue = <Car>[];
    final random = Random();
    colorCounts.forEach((color, count) {
      while (count > 0) {
        final seats = min(count, random.nextInt(4) + 2); // 每辆车2-5个座位
        carQueue.add(Car(0, 0, color, seats));
        count -= seats;
      }
    });

    // 打乱车队顺序
    carQueue.shuffle();

    gameState = GameState(
      BoardState(board),
      CarQueueState(carQueue),
      WaitingArea(),
    );

    // 打印carQueue信息
    print('CarQueue:');
    for (var car in carQueue) {
      print('Car color: ${car.color}, seats: ${car.seatCount}');
    }

    print('Game reset with initial setup.');
    notifyListeners();
  }

  void handlePersonClick(Person person) {
    print('Person Clicked: ${person.color} at (${person.x}, ${person.y})');
    if (gameState.carQueueState.currentCar != null) {
      final currentCar = gameState.carQueueState.currentCar!;
      if (_canPersonMove(person)) {
        gameState.boardState.removePerson(person.x, person.y);
        notifyListeners(); // 确保立即更新UI

        if (person.color == currentCar.color) {
          print('${person.color} person is moving to the car.');
          animatePersonToCar(person, currentCar);
        } else {
          print('${person.color} person is moving to the waiting area.');
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
    final obj = gameState.boardState.board.getObjectAt(person.x, person.y);
    print("after place, get obj in pos = ${obj}");
  }

  // 判断小人是否可移动
  bool _canPersonMove(Person person) {
    final board = gameState.boardState.board;
    final List<int> dx = [0, 1, 0, -1];
    final List<int> dy = [-1, 0, 1, 0]; // 下->0，上->1，右->2，左->3方向的移动

    // 如果小人在第一排，是可移动的
    if (person.y == 0) {
      print('Person is in the first row.');
      return true;
    }

    // 广度优先搜索（BFS）
    List<List<int>> queue = [
      [person.x, person.y]
    ];
    Set<List<int>> visited = {queue[0]};

    while (queue.isNotEmpty) {
      List<int> pos = queue.removeAt(0);
      int x = pos[0];
      int y = pos[1];

      for (int direction = 0; direction < 4; direction++) {
        int newX = x + dx[direction];
        int newY = y + dy[direction];

        // 检查新位置是否在棋盘范围内，并且不是在墙边或者障碍物、小人
        if (newX >= 0 &&
            newX < board.width &&
            newY >= 0 &&
            newY < board.height) {
          if (board.getObjectAt(newX, newY) == null) {
            if (newY == 0) {
              print(
                  'Found a path to the first row from ($person.x, $person.y).');
              return true;
            }

            if (visited.add([newX, newY])) {
              queue.add([newX, newY]);
            }
          }
        }
      }
    }

    print('No path to the first row for ($person.x, $person.y).');
    return false;
  }

  void handleObstacleClick(Obstacle obstacle) {
    print('Obstacle Clicked: at (${obstacle.x}, ${obstacle.y})');
    _showMessage("障碍物不可移动");
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    print(message);
  }

  void _showMessageAtPersonPosition(Person person, String message) {
    final snackBar =
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating);
    scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    print(message);
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

      // 打印当前车信息
      print(
          'Current Car: color: ${car.color}, remaining seats: ${car.seatCount}');

      print('${person.color} person moved to the car.');
      notifyListeners(); // 确保刷新UI
    });
  }

  void animatePersonToWaitingArea(Person person) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final snackBar = SnackBar(content: Text("${person.color} 小人进入候车区"));
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

      print('${person.color} person moved to the waiting area.');
      notifyListeners(); // 确保刷新UI
    });
  }

  void _animateCarDepartAndArrive() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      shiftCarViewRight(86); // 调用shiftCarViewRight来更新offset

      final snackBar = SnackBar(content: Text("车辆驶离，下一辆车进场"));
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

      print('The car has departed, and the next car has arrived.');
      notifyListeners(); // 确保刷新UI
    });
  }

  void _initializeBoard(Board board, int difficulty) {
    final random = Random();
    final colors = ['red', 'green', 'blue', 'yellow'];
    final obstaclesCount = difficulty; // 动态生成障碍数量随难度变化

    for (int i = 0; i < obstaclesCount; i++) {
      int x, y;
      do {
        x = random.nextInt(6);
        y = random.nextInt(6);
      } while (board.getObjectAt(x, y) != null);
      board.placeObstacle(x, y, Obstacle(x, y));
    }

    for (int x = 0; x < 6; x++) {
      for (int y = 0; y < 6; y++) {
        if (board.getObjectAt(x, y) == null) {
          final color = colors[random.nextInt(colors.length)];
          board.placePerson(x, y, Person(x, y, color));
        }
      }
    }
  }

  void shiftCarViewRight(double carWidth) {
    carViewOffset += carWidth;
    notifyListeners();
  }
}
