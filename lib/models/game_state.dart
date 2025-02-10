import 'board_state.dart';
import 'car_queue_state.dart';
import 'waiting_area.dart';

class GameState {
  final BoardState boardState;
  final CarQueueState carQueueState;
  final WaitingArea waitingArea;

  GameState(this.boardState, this.carQueueState, this.waitingArea);
}