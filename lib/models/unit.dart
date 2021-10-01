import 'dart:math';
import 'package:flame/assets.dart';
import 'package:flame/extensions.dart';
import 'package:flame/components.dart';

class Unit extends SpriteAnimationComponent{


  //Stats
  late double damage;
  late double health;
  late double maxHealth;
  late double speed;
  late double range;

  //Autres
  late int type;
  late bool isFlying;
  late bool isRanged;

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

  ///Constructors : prend position [x] [y] et un [type]
  Unit(double x, double y, int pType,Images images):super(position: Vector2(x,y)){
    type = pType;
    anchor=Anchor.center;
    isFlying=false;
    isRanged=false;
    switch(type) {
    //0-1 : archer
      case 0:
      case 1: {
        damage = 1;
        health = 10;
        speed = 0.4;
        size = Vector2(60, 60);
        range=200;
        isRanged=true;
      }
      break;
    //2-3 : balista
      case 2:
      case 3: {
        damage = 1.1;
        health = 5;
        speed = 0.05;
        size = Vector2(60, 60);
        range=250;
        isRanged=true;
      }
      break;
    //4-5 : berserker
      case 4:
      case 5: {
        damage = 5;
        health = 300;
        speed = 0.6;
        size = Vector2(60, 60);
        range=20;
      }
      break;
    //6-7 : cavalier
      case 6:
      case 7: {
        damage = 2;
        health = 150;
        speed = 1;
        size = Vector2(60, 60);
        range=50;
      }
      break;
    //8-9 : dragon
      case 8:
      case 9: {
        damage = 1.75;
        health = 200;
        speed = 0.9;
        size = Vector2(60, 60);
        range=60;
        isFlying=true;
      }
      break;
    //10-11 : marshall
      case 10:
      case 11: {
        damage = 1;
        health = 1000;
        speed = 0.3;
        size = Vector2(60, 60);
        range=30;
      }
      break;
    //12-13 : spear
      case 12:
      case 13: {
        damage = 1.2;
        health = 200;
        speed = 0.6;
        size = Vector2(60, 60);
        range=45;
      }
      break;
    //14-15 : wizard
      case 14:
      case 15: {
        damage = 4;
        health = 1;
        speed = 0.3;
        size = Vector2(60, 60);
        range=85;
        isRanged=true;
      }
      break;

      default: {
        damage = 1;
        health = 1;
        speed = 0.5;
        range=50;
        size = Vector2(40, 40);
      }
      break;
    }
    maxHealth = health;
  }

}
