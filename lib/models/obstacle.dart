import 'game_object.dart';

class Obstacle extends GameObject {
  final String imagePath;

  Obstacle(int x, int y)
      : imagePath = 'assets/images/obstacle.png',
        super(x, y);
}