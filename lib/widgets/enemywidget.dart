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
  void updateEnemy(double dt) {
    enemyAnimation.update(dt);
  }

  void renderEnemy(Canvas canvas) {
    enemyAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: enemySize);
  }
}