import 'car.dart';

class CarQueueState {
  final List<Car> carQueue;
  Car? currentCar;

  CarQueueState(this.carQueue) {
    if (carQueue.isNotEmpty) {
      currentCar = carQueue.removeAt(0);
    }
  }

  void moveToNextCar() {
    if (carQueue.isNotEmpty) {
      currentCar = carQueue.removeAt(0);
    } else {
      currentCar = null;
    }
  }

  bool isQueueEmpty() {
    return carQueue.isEmpty;
  }
}