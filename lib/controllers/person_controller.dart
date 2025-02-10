import 'package:home_for_new_year_game/models/board.dart';
import 'package:home_for_new_year_game/models/game_rules.dart';
import 'package:home_for_new_year_game/models/person.dart';

class PersonController {
  final Board board;
  final GameRules gameRules;

  PersonController({required this.board, required this.gameRules});

  void movePerson(Person person, int targetX, int targetY) {
    if (gameRules.canPersonMove(person, targetX, targetY)) {
      board.placePerson(targetX, targetY, person);
    }
  }
}