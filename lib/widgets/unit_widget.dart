import 'dart:math';
import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:monster_must_die/models/unit.dart';



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
    setPosition(Vector2(getPosition().x,getPosition().y+speed));
  }

  void renderUnit(Canvas canvas) {
    unitAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: unitSize);
  }

  static UnitWidget unitWidgetSpawn(double x, double y, int type,Images images){
    return UnitWidget(x, y, type,images);
  }
}