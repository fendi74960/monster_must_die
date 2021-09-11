import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:monster_must_die/models/enemy.dart';

class EnemyWidget extends Enemy {

  late SpriteAnimation enemyAnimation;

  //Constructors
  EnemyWidget(double x, double y, int type) : super(x, y, type);

  static EnemyWidget enemyWidgetRandom(double minX, double maxX, double minY, double maxY, int type){
    var rng = Random();
    double x = minX + rng.nextInt(( maxX.toInt() - minX.toInt() ) ).toDouble();
    double y = minY + rng.nextInt(( maxY.toInt() - minY.toInt() ) ).toDouble();
    return EnemyWidget(x, y, type);
  }

  //Flame functions to call in the main
  /* //can't do it here because loadSpriteAnimation is in the Game class
  Future<void> onLoadEnemy() async  {
    switch(type) {
      case 1: {
        enemyAnimation = await loadSpriteAnimation(
            'robot.png',
            SpriteAnimationData.sequenced(
            amount: 8,
            textureSize: Vector2(16, 18),
        stepTime: 0.1,
        ));
      }
      break;

      default: {
        enemyAnimation = ;
      }
      break;
    }

  }
  */

  void updateEnemy(double dt) {
    enemyAnimation.update(dt);
  }

  void renderEnemy(Canvas canvas) {
    enemyAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: enemySize);
  }
}