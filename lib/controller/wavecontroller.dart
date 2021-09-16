import 'package:flame/assets.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';

class WaveController {
  static newWave(int wave, List<EnemyWidget> listEnemy, double minX, maxX, minY, maxY, Images images) {
    switch(wave) {
      /*
      case 1: {
        for(int i = 0; i < 10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 2,images));
        }
      }
      break;
      */

      default: {
        for(int i = 0; i < wave*10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2, images));
        }
      }
      break;
    }
  }
}