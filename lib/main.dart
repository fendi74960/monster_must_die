import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';

void main() {
  final myGame = MyGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

class MyGame extends Game {

  late List<EnemyWidget> listEnemy;

  @override
  Color backgroundColor() => const Color(0xFF222222);

  @override
  Future<void> onLoad() async {
    Flame.device.fullScreen();

    listEnemy = List.empty(growable: true);
    for(int i = 0; i < 50 ; i++){
      listEnemy.add(EnemyWidget.enemyWidgetRandom(0, size.x, 0, size.y, 2));
    }

    for(int i = 0; i < listEnemy.length; i++)
    {
      switch(listEnemy[i].type) {
        case 1: {
          listEnemy[i].enemyAnimation = await loadSpriteAnimation(
              'heheboy.png',
              SpriteAnimationData.sequenced(
                amount: 3,
                textureSize: Vector2(944, 804),
                stepTime: 0.2,
              ));
        }
        break;

        default: {
          listEnemy[i].enemyAnimation = await loadSpriteAnimation(
              'fe.png',
              SpriteAnimationData.sequenced(
                amount: 26,
                textureSize: Vector2(40, 40),
                stepTime: 0.1,
              ));
        }
        break;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    for(int i = 0; i < listEnemy.length; i++)
      {
        listEnemy[i].renderEnemy(canvas);
      }
  }

  @override
  void update(double dt) {
    for(int i = 0; i < listEnemy.length; i++)
    {
      listEnemy[i].updateEnemy(dt);
    }
  }
}