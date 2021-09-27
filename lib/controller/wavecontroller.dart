import 'dart:math';
import 'package:flame/assets.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';

class WaveController {
  static newWave(int wave, List<EnemyWidget> listEnemy, double minX, maxX, minY, maxY, Images images) {
    switch(wave) {
      case 1: {
        /*for(int i = 0; i < 10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }*/
        break;
      }
      case 2: {
        for(int i = 0; i < 10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 0,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 0,images));
        break;
      }
      case 3: {
        for(int i = 0; i < 7; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 0,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 0,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        break;
      }
      case 4: {
        for(int i = 0; i < 7; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 0,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 0,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 10,images));
        break;
      }
      case 5: {
        for(int i = 0; i < 5; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2,images));

        break;
      }


      default: {
        for(int i = 0; i < wave.toDouble()*10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, Random().nextInt(13), images));
        }
      }
      break;
    }
  }
}