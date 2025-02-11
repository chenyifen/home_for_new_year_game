import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_for_new_year_game/controllers/main_controller.dart';

class CarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final carWidth = screenWidth > 600 ? 300.0 : screenWidth / 2;
    final carHeight = carWidth / 2;

    return Consumer<MainController>(
      builder: (context, controller, child) {
        final carQueue =
            controller.gameState.carQueueState.carQueue.reversed.toList();
        final totalCarWidth = carQueue.length * carWidth;

        return SizedBox(
          width: carWidth * 1.5, // 确保Stack有一个明确的宽度
          height: carHeight, // 确保Stack有一个明确的高度
          child: Stack(
            children: carQueue.asMap().entries.map((entry) {
              int index = entry.key;
              var car = entry.value;
              return AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                left: controller.carViewOffset +
                    (carWidth * 1.5 - totalCarWidth) +
                    index * carWidth,
                top: 8,
                child: Container(
                  width: carWidth,
                  height: carHeight,
                  child: Image.asset(
                    'assets/images/car_${car.color}.png',
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
