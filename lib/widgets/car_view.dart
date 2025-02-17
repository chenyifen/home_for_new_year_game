import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/car.dart';

class CarView extends StatelessWidget {
  final Car car;
  final double width; // 移除 width 参数

  const CarView({
    required this.car,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double carWidth = 120.0; // 设置固定宽度
    const double carHeight = carWidth / 3; // 保持高度比例，可以根据需要调整为 width / 2 或其他值

    return Container(
      width: carWidth, // 使用固定宽度
      height: carHeight, // 使用固定高度
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/car_${car.color}.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5, // 稍微向上调整文字位置
            left: 5, // 稍微向左调整文字位置
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3), // 稍微缩小内边距
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '座位 还剩 ${car.seatCount}个',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: carWidth * 0.08, // 文字大小基于固定宽度调整
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.grey.shade400,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}