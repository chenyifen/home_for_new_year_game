import 'game_object.dart';

class Person extends GameObject {
  final String color;
  bool isOnBoard;
  final String imagePath;

  Person(int x, int y, this.color, {this.isOnBoard = false})
      : imagePath = 'assets/images/person_${color}.png',
        super(x, y);

  void moveTo(int newX, int newY) {
    // Move logic
  }

  void boardTheCar() {
    isOnBoard = true;
  }
}