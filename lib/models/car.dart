import 'game_object.dart';
import 'person.dart';

class Car extends GameObject {
  final String color;
  int seatCount;
  final int totalSeats;  // 添加totalSeats字段

  Car(int x, int y, this.color, this.seatCount) 
      : totalSeats = seatCount, // 初始化totalSeats
        super(x, y);

  bool addPerson(Person person) {
    if (seatCount > 0) {
      seatCount--;
      return true;
    }
    return false;
  }
}