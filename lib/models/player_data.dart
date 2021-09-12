import 'package:flutter/foundation.dart';

// This class stores the player progress presistently.

class PlayerData extends ChangeNotifier   {

  int highScore = 0;

  int _waves = 5;

  int _lives = 5;

  int _pointsCoop =0;
  int _pointsPerso =0;

  int get waves => _waves;
  set waves(int value) {
    if (value <= 5 && value >= 0) {
      _waves = value;
      notifyListeners();
    }
  }

  int get pointsCoop => _pointsCoop;
  set pointsCoop(int value) {
    if (value >= 0) {
      _pointsCoop = value;
      notifyListeners();
    }
  }
  int get pointsPerso=> _pointsPerso;
  set pointsPerso(int value) {
    if (value >= 0) {
      _pointsPerso = value;
      notifyListeners();
    }
  }
  int get lives => _lives;
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      notifyListeners();
    }
  }

  int _currentScore = 0;

  int get currentScore => _currentScore;
  set currentScore(int value) {
    _currentScore = value;

    if (highScore < _currentScore) {
      highScore = _currentScore;
    }

    notifyListeners();
  }

}