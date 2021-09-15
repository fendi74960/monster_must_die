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

  //Constructors
  UnitWidget(double x, double y, int type,Images images) : super(x, y, type) {
    switch(type) {


      default: {
        unitAnimation=SpriteAnimation.fromFrameData(
            images.fromCache('heheboy.png'),
            SpriteAnimationData.sequenced(
              amount: 3,
              textureSize: Vector2(944, 804),
              stepTime: 0.2,
            ));
      }
      break;
    }


  }


  //Flame functions to call in the main
  void updateMovUnit(double dt,double speed,EnemyWidget target) {
    unitAnimation.update(dt);
    double vectorX=target.getPosition().x-getPosition().x;
    double vectorY=target.getPosition().y-getPosition().y;

    double length=sqrt(vectorX*vectorX+vectorY*vectorY);

    double newVectorX=vectorX/length;
    double newVectorY=vectorY/length;
    
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
  }

  static UnitWidget unitWidgetSpawn(double x, double y, int type,Images images){
    return UnitWidget(x, y, type,images);
  }

  EnemyWidget checkInRangeEnnemie(List<EnemyWidget> ens,Images images){
    double enemyX,enemyY;
    double unitX=getPosition().x+unitSize.x/2,unitY=getPosition().y+unitSize.y/2;

    EnemyWidget plusProche=EnemyWidget(0, 0, 0,images);
    double proximite=9999999;
    double tempProxi=0;

    for(int ii=0;ii<ens.length;ii++){
      enemyX=ens[ii].getPosition().x+ens[ii].enemySize.x/2;
      enemyY=ens[ii].getPosition().y+ens[ii].enemySize.y/2;

      tempProxi=sqrt(pow(enemyX-unitX,2)+pow(enemyY-unitY,2));

      if(tempProxi<=range) {
        isStopped=true;
        return ens[ii];
      }
      else{
        if(tempProxi<proximite) {
          plusProche=ens[ii];
          proximite=tempProxi;
        }
      }

    }
    isStopped=false;
    return plusProche;
  }
  bool isAlive(){
    return health>0?true:false;
  }
}