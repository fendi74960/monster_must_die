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
    switch(type) {


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
      if((ens[ii].type == 4 || ens[ii].type == 5) && type > 3) {
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
          break;
        default:
          break;
      }
    }
  }
}