import 'dart:math';

import 'package:flame/components.dart';

class Enemy {

  //late modifier can be used while declaring a non-nullable variable that’s initialized after its declaration.
  //Position
  late double _x;
  late double _y;

  //Stats
  late double damage;
  late double health;
  late double maxHealth;
  late double speed;
  late double range;

  //Taille
  late Vector2 enemySize;

  //Autres
  late int type;

  //late Images images;


  //I made a getter and setter, because we are using vector2 but I prefer double x and y :)
  Vector2 getPosition() {
    return Vector2(_x, _y);
  }

  void setPosition(Vector2 vector2) {
    _x = vector2.x;
    _y = vector2.y;
  }

  //Constructors
  Enemy(double x, double y, int pType){
    _x = x;
    _y = y;
    type = pType;
    switch(type) {
      case 1: {
        damage = 1;
        health = 100;
        maxHealth = 100;
        speed = 0.1;
        enemySize = Vector2(60, 60);
        range=50;
      }
      break;

      default: {
        damage = 1;
        health = 100;
        maxHealth = 100;
        speed = 0.1;
        range=50;
        enemySize = Vector2(40, 40);
      }
      break;
    }
  }
}