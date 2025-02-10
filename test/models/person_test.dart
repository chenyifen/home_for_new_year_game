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