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