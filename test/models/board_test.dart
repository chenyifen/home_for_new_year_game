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