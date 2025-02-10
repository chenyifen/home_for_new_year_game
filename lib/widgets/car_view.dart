import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_for_new_year_game/controllers/main_controller.dart';

class CarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
    final car = controller.gameState.carQueueState.currentCar;
    final nextCar = controller.gameState.carQueueState.carQueue.isNotEmpty
        ? controller.gameState.carQueueState.carQueue.first
        : null;

    final screenWidth = MediaQuery.of(context).size.width;
    final carWidth = screenWidth > 600 ? 300.0 : screenWidth / 2;
    final carHeight = carWidth / 2;

    return Stack(
      children: [
        if (nextCar != null)
          Positioned(
            left: 4,
            top: 8,
            child: Column(
              children: [
                Container(
                  width: carWidth / 3,
                  height: carHeight,
                  child: Image.asset(
                    'assets/images/next_car_${nextCar.color}.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '候车人数: ${controller.gameState.waitingArea.waitingPersons.length}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        if (car != null)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: carWidth,
              height: carHeight,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/car_${car.color}.png',
                    fit: BoxFit.contain,
                  ),
                  Center(
                    child: car.totalSeats != null ?
                    Text(
                      '${car.seatCount}/${car.totalSeats}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ) : Container()
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}