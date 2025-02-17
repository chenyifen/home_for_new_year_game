import 'car.dart';

class CarQueueState {
  final List<Car> carQueue;
  Car? currentCar;
  Car? nextCar;

  CarQueueState(this.carQueue) {
    if (carQueue.isNotEmpty) {
      currentCar = carQueue.removeAt(0);
      // 初始化 nextCar
      nextCar = carQueue.isNotEmpty ? carQueue[0] : null;
    }
    print('1. init  current car = ${currentCar?.color}');
    print('1. init  next car = ${nextCar?.color}');
  }

  void moveToNextCar() {
    if (carQueue.isNotEmpty) {
      currentCar = carQueue.removeAt(0);
      // 更新 nextCar
      nextCar = carQueue.isNotEmpty ? carQueue[0] : null;
    } else {
      currentCar = null;
      nextCar = null;
    }
    print('update current car = ${currentCar?.color}');
    print('update next car = ${nextCar?.color}');
  }

  bool isQueueEmpty() {
    return carQueue.isEmpty && currentCar == null;
  }
}








