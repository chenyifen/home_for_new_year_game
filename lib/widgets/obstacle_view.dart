import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/obstacle.dart';

class ObstacleView extends StatelessWidget {
  final Obstacle obstacle;
  final Function onTap;

  ObstacleView({required this.obstacle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Image.asset(
        obstacle.imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}