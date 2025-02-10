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