import 'package:flame/extensions.dart';
import 'package:flame/components.dart';

class Enemy extends SpriteAnimationComponent {


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

  //TYPE
  //0-1 : archer
  //2-3 : cyclop
  //4-5 : dog
  //6-7 : eye
  //8-9 : gargoyle
  //10-11 : ghost
  //12-13 : zombie
  //14-15 : dragon
  //16-17 : chicken
  //18-19 : lich

  ///Retourne le nom du monstre lie au [type]
  static String TypeToName(int type) {
    switch(type) {
      case 0:
      case 1:
        return 'Archer';
      case 2:
      case 3:
        return 'Cyclop';
      case 4:
      case 5:
        return 'Dog';
      case 6:
      case 7:
        return 'Eye';
      case 8:
      case 9:
        return 'Gargoyle';
      case 10:
      case 11:
        return 'ghost';
      case 12:
      case 13:
        return 'Zombie';
      case 14:
      case 15:
        return 'Dragon';
      case 16:
      case 17:
        return 'Chicken';
      case 18:
      case 19:
        return 'Lich';
    }
    return '';
  }

  ///Constructors : prend position [x] [y] et un [type]
  Enemy(double x, double y, int pType):super(position: Vector2(x,y)){
    type = pType;
    //Si le type est impair alors reduit de 1 pour que sa start sur moveAnimation
    if(type.isOdd){
      type-=1;
    }
    anchor=Anchor.center;
    isFlying=false;
    isRanged=false;
    //switch sur le type pour ses stats
    switch(type) {
      //0-1 : archer
      case 0:
      case 1: {
        damage = 0.8;
        health = 10;
        speed = 0.4;
        size = Vector2(60, 60);
        range=190;
        isRanged=true;
      }
      break;
      //2-3 : cyclop
      case 2:
      case 3: {
        damage =15;
        health = 3000;
        speed = 0.15;
        size = Vector2(60, 60);
        range=10;
      }
      break;
      //4-5 : dog
      case 4:
      case 5: {
        damage = 6;
        health = 45;
        speed = 1.5;
        size = Vector2(60, 60);
        range=30;
      }
      break;
      //6-7 : eye
      case 6:
      case 7: {
        damage = 1;
        health = 200;
        speed = 0.5;
        size = Vector2(60, 60);
        range=50;
      }
      break;
      //8-9 : gargoyle
      case 8:
      case 9: {
        damage = 2;
        health = 200;
        speed = 0.8;
        size = Vector2(60, 60);
        range=50;
        isFlying=true;
      }
      break;
      //10-11 : ghost
      case 10:
      case 11: {
        damage = 1;
        health = 100;
        speed = 0.3;
        size = Vector2(60, 60);
        range=50;
      }
      break;
      //12-13 : zombie
      case 12:
      case 13: {
        damage = 0.7;
        health = 400;
        speed = 0.4;
        size = Vector2(60, 60);
        range=35;
      }
      break;

      //14-15 : dragon
      case 14:
      case 15: {
      damage = 1.55;
      health = 150;
      speed = 0.9;
      size = Vector2(60, 60);
      range=60;
      isFlying=true;
      }
      break;

      //16-17 : chicken
      case 16:
      case 17: {
        damage = 0;
        health = 20;
        speed = 1.2;
        size = Vector2(60, 60);
        range=40;
      }
      break;

      //18-19 : lich
      case 18:
      case 19: {
        damage = 0;
        health = 3000;
        speed = 0.25;
        size = Vector2(60, 60);
        range=20;
      }
      break;

      default: {
        damage = 1;
        health = 100;
        speed = 0.1;
        range=50;
        size = Vector2(40, 40);
      }
      break;

    }
    maxHealth = health;
  }
}