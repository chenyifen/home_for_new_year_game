Sprint 1: 项目初始化与基础Model层实现

**1.1 初始化工程：**
- 创建Flutter项目，设置必要的环境配置
- 搭建基本目录结构

**1.2 基础Model层实现：**
- 定义基本游戏对象类（GameObject）
- 实现小人类（Person），障碍物类（Obstacle），棋盘类（Board）

**1.3 基础单元测试：**
- 编写基础Model层的单元测试
- 确保对象的正确创建和基本方法运作

**验收标准：**
- 工程结构清晰，Model层对象及基本逻辑实现，并通过单元测试



好的，让我们一步一步完成Sprint 1。以下是详细的操作方法：

Pre: Flutter环境准备

### Sprint 1: 项目初始化与基础Model层实现

#### **1.1 初始化工程**

**操作步骤：**
1. **创建Flutter项目**
    ```sh
    flutter create home_for_new_year_game
    cd home_for_new_year_game
    ```
2. **设置必要的环境配置**
   - 确保Flutter SDK已经正确安装，并且环境变量已经配置。
   - 使用`flutter doctor`查看环境配置是否正常。
    ```sh
    flutter doctor
    ```

3. **搭建基本目录结构**
   下面是项目基本目录结构的建议：
    ```
    home_for_new_year_game/
    ├── lib/
    │   ├── models/
    │   │   ├── game_object.dart
    │   │   ├── person.dart
    │   │   ├── obstacle.dart
    │   │   ├── board.dart
    │   ├── main.dart
    ├── test/
    │   ├── models/
    │       ├── person_test.dart
    │       ├── obstacle_test.dart
    │       ├── board_test.dart
    ├── .gitignore
    ├── pubspec.yaml
    ```

#### **1.2 基础Model层实现**

**操作步骤：**

1. **定义基本游戏对象类（`GameObject`）**

    创建文件 `lib/models/game_object.dart`：
    ```dart
    abstract class GameObject {
      final int x;
      final int y;

      GameObject(this.x, this.y);
    }
    ```

2. **实现小人类（`Person`）**

    创建文件 `lib/models/person.dart`：
    ```dart
    import 'game_object.dart';

    class Person extends GameObject {
      final String color;
      bool isOnBoard;

      Person(int x, int y, this.color, {this.isOnBoard = false}) : super(x, y);

      void moveTo(int newX, int newY) {
        // Move logic
      }

      void boardTheCar() {
        isOnBoard = true;
      }
    }
    ```

3. **实现障碍物类（`Obstacle`）**

    创建文件 `lib/models/obstacle.dart`：
    ```dart
    import 'game_object.dart';

    class Obstacle extends GameObject {
      Obstacle(int x, int y) : super(x, y);
    }
    ```

4. **实现棋盘类（`Board`）**

    创建文件 `lib/models/board.dart`：
    ```dart
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

      void placeObstacle(int x, int y, Obstacle obstacle) {
        grid[x][y] = obstacle;
      }

      GameObject? getObjectAt(int x, int y) {
        return grid[x][y];
      }
    }
    ```

#### **1.3 基础单元测试**

**操作步骤：**

1. **编写基础Model层的单元测试**

    创建测试文件 `test/models/person_test.dart`：
    ```dart
    import 'package:flutter_test/flutter_test.dart';
    import 'package:home_for_new_year_game/models/person.dart';

    void main() {
      group('Person Tests', () {
        test('Initialize Person', () {
          final person = Person(0, 0, 'red');
          expect(person.x, 0);
          expect(person.y, 0);
          expect(person.color, 'red');
          expect(person.isOnBoard, false);
        });

        test('Person Boarding', () {
          final person = Person(0, 0, 'red');
          person.boardTheCar();
          expect(person.isOnBoard, true);
        });
      });
    }
    ```

    创建测试文件 `test/models/obstacle_test.dart`：
    ```dart
    import 'package:flutter_test/flutter_test.dart';
    import 'package:home_for_new_year_game/models/obstacle.dart';

    void main() {
      group('Obstacle Tests', () {
        test('Initialize Obstacle', () {
          final obstacle = Obstacle(0, 0);
          expect(obstacle.x, 0);
          expect(obstacle.y, 0);
        });
      });
    }
    ```

    创建测试文件 `test/models/board_test.dart`：
    ```dart
    import 'package:flutter_test/flutter_test.dart';
    import 'package:home_for_new_year_game/models/board.dart';
    import 'package:home_for_new_year_game/models/person.dart';
    import 'package:home_for_new_year_game/models/obstacle.dart';

    void main() {
      group('Board Tests', () {
        test('Initialize Board', () {
          final board = Board();
          expect(board.width, 6);
          expect(board.height, 6);
          expect(board.grid.length, 6);
          expect(board.grid[0].length, 6);
        });

        test('Place Person on Board', () {
          final board = Board();
          final person = Person(0, 0, 'red');
          board.placePerson(0, 0, person);
          expect(board.getObjectAt(0, 0), person);
        });

        test('Place Obstacle on Board', () {
          final board = Board();
          final obstacle = Obstacle(1, 1);
          board.placeObstacle(1, 1, obstacle);
          expect(board.getObjectAt(1, 1), obstacle);
        });
      });
    }
    ```

2. **运行单元测试**
    ```sh
    flutter test
    ```

### 验收标准

**验收标准：**
- 工程结构清晰，Model层对象及基本逻辑实现，并通过单元测试

**操作步骤：**

1. **检查工程目录结构是否正确**
    确保所有文件和目录都按照之前的基本目录结构创建。

2. **检查Model层实现**
    确保基本游戏对象类（`GameObject`），小人类（`Person`），障碍物类（`Obstacle`），棋盘类（`Board`）都已准确实现。

3. **运行单元测试**
    确保所有测试用例运行通过：
    ```sh
    flutter test
    ```

通过这些操作，可以完成Sprint 1的目标，确保工程结构清晰，Model层对象及基本逻辑实现，并通过单元测试。