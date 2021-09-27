import 'package:flutter/foundation.dart';

// This class stores the player progress presistently.

class PlayerData extends ChangeNotifier   {

  //Valeur de l'hud
  int _waves = 5;
  int _lives = 5;
  int _pointsCoop =0;
  int _pointsPerso =0;

  ///getter et setter pour les waves
  int get waves => _waves;
  set waves(int value) {
    if (value <= 5 && value >= 0) {
      _waves = value;
      notifyListeners();
    }
  }

  ///getter et setter pour les points Coop
  int get pointsCoop => _pointsCoop;
  set pointsCoop(int value) {
    if (value >= 0) {
      _pointsCoop = value;

    }
    else{
      _pointsCoop=0;
    }
    notifyListeners();
  }

  ///getter et setter pour les pointsPerso
  int get pointsPerso=> _pointsPerso;
  set pointsPerso(int value) {
    if (value >= 0) {
      _pointsPerso = value;
    }
    else{
      _pointsPerso=0;
    }
    notifyListeners();
  }

  ///getter et setter pour les lives
  int get lives => _lives;
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      notifyListeners();
    }
  }



}