import 'car.dart';

class CarQueueState {
  final List<Car> carQueue;
  Car? currentCar;

  CarQueueState(this.carQueue) {
    if (carQueue.isNotEmpty) {
      currentCar = carQueue.removeAt(0);
    }
    print('1. init  current car = ${currentCar}');

  }

  void moveToNextCar() {
    if (carQueue.isNotEmpty) {
      currentCar = carQueue.removeAt(0);
    } else {
      currentCar = null;
    }
    print('update current car = ${currentCar}');
  }

  bool isQueueEmpty() {
    return carQueue.isEmpty;
  }
}