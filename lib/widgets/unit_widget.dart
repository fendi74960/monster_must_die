import 'dart:math';
import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:monster_must_die/models/unit.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';



class UnitWidget extends Unit  {

  late SpriteAnimation unitAnimation;
  bool etatChanger=false;
  late Images images;
  bool isStopped=false;
  late Sprite lifebar;

  //Constructors
  UnitWidget(double x, double y, int type,this.images) : super(x, y, type) {
    if(type.isOdd){
      type-=1;
    }
    switch(type) {
    //0-1 : archer
      case 0:
      case 1: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/archer/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 30),
            stepTime: 0.1,
          ));
      break;
    //2-3 : balista
      case 2:
      case 3: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/balista/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 30),
            stepTime: 0.1,
          ));
      break;
    //4-5 : berserker
      case 4:
      case 5: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/berserker/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 32),
            stepTime: 0.1,
          ));
      break;
    //6-7 : cavalier
      case 6:
      case 7: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/cavalrer/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 32),
            stepTime: 0.1,
          ));
      break;
    //8-9 : dragon
      case 8:
      case 9: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/dragon/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 32),
            stepTime: 0.1,
          ));
      break;
    //10-11 : marshall
      case 10:
      case 11: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/marshall/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 30),
            stepTime: 0.1,
          ));
      break;
    //12-13 : spear
      case 12:
      case 13: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/spear/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 30),
            stepTime: 0.1,
          ));
      break;
      //14-15 : wizard
      case 14:
      case 15: unitAnimation = SpriteAnimation.fromFrameData(
          images.fromCache('Unit/wizard/moving.png'),
          SpriteAnimationData.sequenced(
            amount: 4,
            amountPerRow: 1,
            textureSize: Vector2(32, 30),
            stepTime: 0.1,
          ));
      break;

      default: {
        unitAnimation=SpriteAnimation.fromFrameData(
            images.fromCache('heheboy.png'),
            SpriteAnimationData.sequenced(
              amount: 19,
              textureSize: Vector2(700, 660),
              stepTime: 0.1,
            ));
      }
      break;
    }

    lifebar=Sprite(images.fromCache('lifebar.png'));
  }


  //Flame functions to call in the main
  void updateMovUnit(double dt,double speed,EnemyWidget target) {
    unitAnimation.update(dt);
    double vectorX=target.getPosition().x-getPosition().x;
    double vectorY=target.getPosition().y-getPosition().y;

    double length=sqrt(vectorX*vectorX+vectorY*vectorY);
    double newVectorX = 0;
    double newVectorY = 0;
    if(length!=0) {
       newVectorX = vectorX / length;
       newVectorY = vectorY / length;
    }


    setPosition(Vector2(getPosition().x+newVectorX*speed,getPosition().y+newVectorY*speed));

  }

  void attaque(double dt,EnemyWidget target) {
    unitAnimation.update(dt);
    target.health-=damage;

  }

  void renderUnit(Canvas canvas) {
    unitAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: unitSize);
    lifebar.render(canvas, position: Vector2(getPosition().x,getPosition().y-10), size: Vector2((unitSize.x*health)/maxHealth,10));
  }

  static UnitWidget unitWidgetSpawn(double x, double y, int type,Images images){
    return UnitWidget(x, y, type,images);
  }

  EnemyWidget checkInRangeEnnemie(List<EnemyWidget> ens ){
    bool canHit=true;
    double enemyX,enemyY;
    double unitX=getPosition().x+unitSize.x/2,unitY=getPosition().y+unitSize.y/2;

    EnemyWidget plusProche=EnemyWidget(getPosition().x, getPosition().y, 0,images);
    double proximite=9999999;
    double tempProxi=0;

    for(int ii=0;ii<ens.length;ii++) {
      //Check si ennemie=arien et qu'on peut taper
      if((ens[ii].type == 8 || ens[ii].type == 9) && type > 3) {
        canHit=false;
      }
      //mage peut taper ghost
      else if((ens[ii].type == 10 || ens[ii].type == 11) && (type != 14 || type != 15)){
        canHit=false;
      }
      else {
        canHit=true;
      }
      if (canHit) {
        enemyX = ens[ii].getPosition().x + ens[ii].enemySize.x / 2;
        enemyY = ens[ii].getPosition().y + ens[ii].enemySize.y / 2;

        tempProxi = sqrt(pow(enemyX - unitX, 2) + pow(enemyY - unitY, 2));

        if (tempProxi <= range) {
          isStopped = true;
          return ens[ii];
        }
        else {
          if (tempProxi < proximite) {
            plusProche = ens[ii];
            proximite = tempProxi;
          }
        }
      }
    }
    isStopped=false;
    return plusProche;
  }
  bool isAlive(){
    return health>0?true:false;
  }
  void actualisationAnim(int modificateurType){
    if(etatChanger) {
      type += modificateurType;

      switch (type) {
      //0-1 : archer
        case 0:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/archer/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 30),
                stepTime: 0.1,
              ));
          break;
        case 1: unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/archer/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 25,
              textureSize: Vector2(50, 50),
              stepTime: 0.1,
            ));
        break;
      //2-3 : balista
        case 2:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/balista/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 30),
                stepTime: 0.1,
              ));
          break;
        case 3: unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/balista/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 10,
              textureSize: Vector2(80, 80),
              stepTime: 0.1,
            ));
        break;
      //4-5 : berserker
        case 4:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/berserker/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 32),
                stepTime: 0.1,
              ));
          break;
        case 5:
          unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/berserker/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 12,
              textureSize: Vector2(100, 80),
              stepTime: 0.1,
            ));
        break;
      //6-7 : cavalier
        case 6:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/cavalrer/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 32),
                stepTime: 0.1,
              ));
          break;
        case 7:
          unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/cavalrer/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 21,
              textureSize: Vector2(140, 80),
              stepTime: 0.1,
            ));
        break;
      //8-9 : dragon
        case 8:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/dragon/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 32),
                stepTime: 0.1,
              ));
          break;
        case 9:
          unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/dragon/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 20,
              textureSize: Vector2(140, 110),
              stepTime: 0.1,
            ));
        break;
      //10-11 : marshall
        case 10:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/marshall/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 30),
                stepTime: 0.1,
              ));
          break;
        case 11: unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/marshall/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 31,
              textureSize: Vector2(140, 95),
              stepTime: 0.1,
            ));
        break;
      //12-13 : spear
        case 12:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/spear/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 30),
                stepTime: 0.1,
              ));
          break;
        case 13:
          unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/spear/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 26,
              textureSize: Vector2(90, 60),
              stepTime: 0.1,
            ));
        break;
      //14-15 : wizard
        case 14:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('Unit/wizard/moving.png'),
              SpriteAnimationData.sequenced(
                amount: 4,
                amountPerRow: 1,
                textureSize: Vector2(32, 30),
                stepTime: 0.1,
              ));
          break;
        case 15:
          unitAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('Unit/wizard/attack.png'),
            SpriteAnimationData.sequenced(
              amount: 19,
              textureSize: Vector2(90, 100),
              stepTime: 0.1,
            ));
        break;


        /*
        case 4:
          unitAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('heheboy.png'),
              SpriteAnimationData.sequenced(
                amount: 19,
                textureSize: Vector2(700, 660),
                stepTime: 0.1,
              ));
          break;
        case 5:
          unitAnimation = SpriteAnimation.fromFrameData(
              images.fromCache('Lance_attaque_anim.png'),
              SpriteAnimationData.sequenced(
                amount: 25,
                textureSize: Vector2(115, 64),
                stepTime: 0.1,
              ));
          break;*/
        default:
          break;
      }
    }
  }
}