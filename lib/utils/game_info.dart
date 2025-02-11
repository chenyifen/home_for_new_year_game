import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

class GameInfo {
  static int difficulty = 1;
  static int gamesPlayed = 0;
  static int gamesWon = 0;
  static int gamesLost = 0;

  static Future<void> loadGameInfo() async {
    // final prefs = await SharedPreferences.getInstance();
    // difficulty = prefs.getInt('difficulty') ?? 1;
    // gamesPlayed = prefs.getInt('gamesPlayed') ?? 0;
    // gamesWon = prefs.getInt('gamesWon') ?? 0;
    // gamesLost = prefs.getInt('gamesLost') ?? 0;
  }

  static Future<void> saveGameInfo() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('difficulty', difficulty);
    // await prefs.setInt('gamesPlayed', gamesPlayed);
    // await prefs.setInt('gamesWon', gamesWon);
    // await prefs.setInt('gamesLost', gamesLost);
  }

  static void recordGameOver(int onboardCount) {
    gamesPlayed++;
    if (onboardCount == 32) {
      gamesWon++;
    } else {
      gamesLost++;
    }

    _adjustDifficulty();
    saveGameInfo();
  }

  static void _adjustDifficulty() {
    if (gamesWon > gamesLost) {
      difficulty++;
    } else if (gamesLost > gamesWon && difficulty > 1) {
      difficulty--;
    }
  }
}