import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:monster_must_die/models/enemy.dart';
import 'package:flame/assets.dart';

class EnemyWidget extends Enemy {

  late SpriteAnimation enemyAnimation;
  late Sprite lifebar;
  late Images images;


  //Constructors
  EnemyWidget(double x, double y, int type,this.images) : super(x, y, type){

    switch(type) {
      case 1: {
        enemyAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('heheboy.png'),
            SpriteAnimationData.sequenced(
              amount: 19,
              textureSize: Vector2(700, 660),
              stepTime: 0.1,
            ));
      }
      break;

      default: {
        enemyAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('fe.png'),
            SpriteAnimationData.sequenced(
              amount: 26,
              textureSize: Vector2(40, 40),
              stepTime: 0.1,
            ));
      }
      break;

    }

    lifebar=Sprite(images.fromCache('lifebar.png'));

  }

  static EnemyWidget enemyWidgetRandom(double minX, double maxX, double minY, double maxY, int type,Images images){
    var rng = Random();
    double x = minX + rng.nextInt(( maxX.toInt() - minX.toInt() ) ).toDouble();
    double y = minY + rng.nextInt(( maxY.toInt() - minY.toInt() ) ).toDouble();

    return EnemyWidget(x, y, type,images);
  }

  //Flame functions to call in the main
  void updateMovEnemy(double dt,double speed) {
    enemyAnimation.update(dt);
    setPosition(Vector2(getPosition().x,getPosition().y+speed));
  }

  void renderEnemy(Canvas canvas) {
    enemyAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: enemySize);
    lifebar.render(canvas, position: Vector2(getPosition().x,getPosition().y-10), size: Vector2((enemySize.x*health)/maxHealth,10));
  }

  bool isAlive(){
    return health>0?true:false;
  }

}