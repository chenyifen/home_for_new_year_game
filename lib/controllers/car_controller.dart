import 'package:home_for_new_year_game/models/car.dart';
import 'package:home_for_new_year_game/models/car_queue_state.dart';
import 'package:home_for_new_year_game/models/person.dart';


class CarController {
  final CarQueueState carQueueState;

  CarController({required this.carQueueState});

  void handlePersonMoveToCar(Person person) {
    final currentCar = carQueueState.currentCar;
    if (currentCar != null && currentCar.color == person.color) {
      if (currentCar.addPerson(person)) {
        if (currentCar.seatCount == 0) {
          carQueueState.moveToNextCar();
        }
      } else {
        _showMessage("No seats available");
      }
    } else {
      _showMessage("Wrong car color or no car available");
    }
  }

  void _showMessage(String message) {
    // Implement your message display logic here
    print(message); // Placeholder for actual message display
  }
}