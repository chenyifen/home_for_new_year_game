import 'board_state.dart';
import 'car_queue_state.dart';

class GameState {
  final BoardState boardState;
  final CarQueueState carQueueState;

  GameState(this.boardState, this.carQueueState);
}