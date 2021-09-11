import 'package:flutter/foundation.dart';

// This class stores the player progress presistently.

class PlayerData extends ChangeNotifier   {

  int highScore = 0;

  int _waves = 5;

  int get waves => _waves;
  set waves(int value) {
    if (value <= 5 && value >= 0) {
      _waves = value;
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