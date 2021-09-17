import 'dart:math';
import 'package:flame/extensions.dart';
import 'package:flame/components.dart';

class Unit {

  //Stats
  late double _x;
  late double _y;
  late double damage;
  late Vector2 unitSize;
  late double health;
  late double maxHealth;
  late double speed;
  late int type;
  late double range;


  //I made a getter and setter, because we are using vector2 but I prefer double x and y :)
  Vector2 getPosition() {
    return Vector2(_x, _y);
  }

  void setPosition(Vector2 vector2) {
    _x = vector2.x;
    _y = vector2.y;
  }

  //Constructors
  Unit(double x, double y, int pType){
    _x = x;
    _y = y;
    type = pType;
    switch(type) {
      case 1: {
        damage = 1;
        health = 100;
        maxHealth=100;
        speed = 0.4;
        range=50;
        unitSize = Vector2(40, 40);
      }
      break;

      default: {
        damage = 1;
        health = 100;
        maxHealth=100;
        speed = 0.4;
        range=50;
        unitSize = Vector2(40, 40);
      }
      break;
    }
  }

}
