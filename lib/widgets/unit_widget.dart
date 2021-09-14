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
  void updateMovUnit(double dt,double speed) {
    unitAnimation.update(dt);
    if(!isStopped) {
      //TODO
      //CHECK SI ON DOIT REMETTRE LE EN MARCHE
      setPosition(Vector2(getPosition().x,getPosition().y+speed));
    }
    //else mov towards ennemies
  }

  void renderUnit(Canvas canvas) {
    unitAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: unitSize);
  }

  static UnitWidget unitWidgetSpawn(double x, double y, int type,Images images){
    return UnitWidget(x, y, type,images);
  }

  bool checkInRangeEnnemie(List<EnemyWidget> ens){
    double enemyX,enemyY;
    double unitX=getPosition().x+unitSize.x/2,unitY=getPosition().y+unitSize.y/2;
    for(int ii=0;ii<ens.length;ii++){
      enemyX=ens[ii].getPosition().x+ens[ii].enemySize.x/2;
      enemyY=ens[ii].getPosition().y+ens[ii].enemySize.y/2;

      if(sqrt(pow(enemyX-unitX,2)+pow(enemyY-unitY,2))<=range) {
        return true;
      }
    }

    return false;
  }
}