import 'package:flutter/material.dart';

class BestiaryController {
  late List<EnemieInformation> liste;
  late int max;

  //Load the bestiary array
  BestiaryController() {
    liste = List.empty(growable: true);

    EnemieInformation e = EnemieInformation("Archer");
    e.description = "It does ranged attack";
    e.pros = "Efficient against wizard, spear";
    e.cons = "Weak against cavalrie";
    liste.add(e);

    e = EnemieInformation("Cyclop");
    e.description = "It does heavy attack";
    e.pros = "Efficent against cavalrie, spearman";
    e.cons = "Weak against archer, berserk";
    liste.add(e);

    e = EnemieInformation("Dog");
    e.description = "It is fast but have low health point and it does heavy attack";
    e.pros = "Efficient against marshall";
    e.cons = "Weak against archer";
    liste.add(e);

    e = EnemieInformation("Eye");
    e.description = "It fly and go directly to your health bar";
    e.pros = "Efficient X";
    e.cons = "Weak against archer, balista";
    liste.add(e);

    e = EnemieInformation("Gargoyle");
    e.description = "It fly";
    e.pros = "Efficient against ground units";
    e.cons = "Weak against balista";
    liste.add(e);

    e = EnemieInformation("Ghost");
    e.description = "Can only be attacked with magic and go directly to your health bar";
    e.pros = "Efficient against X";
    e.cons = "Weak against wizard";
    liste.add(e);

    e = EnemieInformation("Zombie");
    e.description = "Basic enemie";
    e.pros = "Efficient against spearman";
    e.cons = "Weak against berserker";
    liste.add(e);

    e = EnemieInformation("Dragon");
    e.description = "It have a lot of health point";
    e.pros = "Efficient against ground units";
    e.cons = "Weak against balista";
    liste.add(e);

    e = EnemieInformation("Lich");
    e.description = "It spawn enemies after few seconds";
    e.pros = "Efficient against X";
    e.cons = "Weak against berserker";
    liste.add(e);

    e = EnemieInformation("Chicken");
    e.description = "It transform to an random enemy when killed";
    e.pros = "Efficient against X";
    e.cons = "Weak against X";
    liste.add(e);

    max = liste.length-1;
  }

  //Get the Enemie in the good index
  EnemieInformation getEnemieInformation(int val) {
    if(val > max || val < 0) {
      return EnemieInformation("Error");
    }
    return liste[val];
  }
}

//Information class for the bestiary
class EnemieInformation {
  String name = "";
  String picture = "";
  String description = "";
  String pros = "";
  String cons = "";

  EnemieInformation(String nameC) {
    name = nameC;
    picture = 'images/Enemy/' + nameC.toLowerCase() + '/profile.png';
  }
}

//Class where the variable inside can be display on the waitingMenu
// it use a notifier when the variable change
class InformationData extends ChangeNotifier   {
  EnemieInformation _enemieInformation = EnemieInformation("Error");
  EnemieInformation get enemieInformation => _enemieInformation;
  set enemieInformation(EnemieInformation value) {
    _enemieInformation = value;
    notifyListeners();
  }
}