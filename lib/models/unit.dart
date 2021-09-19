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

  //Vu que je sais pas faire les enum et que sa a l'air chiant a faire
  //TYPE
  //0-1 : archer
  //2-3 : balista
  //4-5 : berserker
  //6-7 : cavalier
  //8-9 : dragon
  //10-11 : marshall
  //12-13 : spear
  //14-15 : wizard


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
        speed = 0.5;
        range=50;
        unitSize = Vector2(40, 40);
      }
      break;
    }
  }

}
