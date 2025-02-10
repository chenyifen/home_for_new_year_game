import 'package:flutter/material.dart';

class CarView extends StatelessWidget {
  final int totalSeats;
  final int currentSeats;
  final int waitingPersons;

  CarView({
    required this.totalSeats,
    required this.currentSeats,
    required this.waitingPersons,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final carWidth = screenWidth > 600 ? 300.0 : screenWidth / 2;
    final carHeight = carWidth / 2;

    return Stack(
      children: [
        Positioned(
          left: 4,
          top: 8,
          child: Column(
            children: [
              Container(
                width: carWidth / 3,
                height: carHeight,
                child: Image.asset(
                  'assets/images/car_next.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '候车人数: $waitingPersons',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: carWidth,
            height: carHeight,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/car_current.png',
                  fit: BoxFit.contain,
                ),
                Center(
                  child: Text(
                    '$currentSeats/$totalSeats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}