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

    /*
    listEnemy = List.generate(3, (index) => {
      return EnemyWidget.enemyWidgetRandom(0, size.x, 0, size.y, 1);
    });
    */
    //listEnemy = List.empty(growable: true);
    //listEnemy.add(EnemyWidget.enemyWidgetRandom(0, size.x, 0, size.y, 1));
    listEnemy = [EnemyWidget.enemyWidgetRandom(0, 100, 0, 100, 1)];

    for(int i = 0; i < listEnemy.length - 1; i++)
    {
      switch(listEnemy[i].type) {
        case 1: {
          listEnemy[i].enemyAnimation = await loadSpriteAnimation(
              'robot.png',
              SpriteAnimationData.sequenced(
                amount: 8,
                textureSize: Vector2(16, 18),
                stepTime: 0.1,
              ));
        }
        break;

        default: {
          listEnemy[i].enemyAnimation = await loadSpriteAnimation(
              'robot.png',
              SpriteAnimationData.sequenced(
                amount: 8,
                textureSize: Vector2(16, 18),
                stepTime: 0.1,
              ));
        }
        break;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    for(int i = 0; i < listEnemy.length - 1; i++)
      {
        listEnemy[i].renderEnemy(canvas);
      }
  }

  @override
  void update(double dt) {
    for(int i = 0; i < listEnemy.length - 1; i++)
    {
      listEnemy[i].updateEnemy(dt);
    }
  }
}