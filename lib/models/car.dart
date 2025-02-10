import 'game_object.dart';
import 'person.dart';

class Car extends GameObject {
  final String color;
  int seatCount;

  Car(int x, int y, this.color, this.seatCount) : super(x, y);

  bool addPerson(Person person) {
    if (seatCount > 0) {
      seatCount--;
      return true;
    }
    return false;
  }
}