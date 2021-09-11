import 'dart:math';

import 'package:flame/components.dart';

class Enemy {

  //late modifier can be used while declaring a non-nullable variable that’s initialized after its declaration.
  late double _x;
  late double _y;
  late double damage;
  late Vector2 enemySize;
  late double health;
  late double speed;
  late int type;


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
        health = 2;
        speed = 1;
        enemySize = Vector2(60, 60);
      }
      break;

      default: {
        damage = 1;
        health = 2;
        speed = 1;
        enemySize = Vector2(40, 40);
      }
      break;
    }
  }
}