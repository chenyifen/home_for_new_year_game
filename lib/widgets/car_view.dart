import 'package:flutter/material.dart';

class CarView extends StatelessWidget {
  final int totalSeats;
  final int currentSeats;
  final int waitingPersons;

  CarView({required this.totalSeats, required this.currentSeats, required this.waitingPersons});

  @override
  Widget build(BuildContext context) {
    final carSize = MediaQuery.of(context).size.width > 600
        ? 300.0
        : MediaQuery.of(context).size.width / 2;

    return Column(
      children: [
        Container(
          width: carSize,
          height: carSize / 2,
          child: Image.asset(
            'assets/images/car_current.png',
            fit: BoxFit.contain,
          ),
        ),
        Text('当前座位: ${currentSeats}/${totalSeats}'),
        SizedBox(height: 16),
        Container(
          width: carSize,
          height: carSize / 2,
          child: Image.asset(
            'assets/images/car_next.png',
            fit: BoxFit.contain,
          ),
        ),
        Text('候车人数: $waitingPersons'),
      ],
    );
  }
}