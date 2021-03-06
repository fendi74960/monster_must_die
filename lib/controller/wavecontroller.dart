import 'dart:math';
import 'package:flame/assets.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/models/player_data.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';
import 'package:oktoast/oktoast.dart';

class WaveController {
  static newWave(int wave, List<EnemyWidget> listEnemy, double minX, double maxX, double minY, double maxY, Images images,PlayerData data) async {
    //We wait 5 seconds before the wave, so players can prepare themself
    showToast('The wave ' + wave.toString() + " is coming in 5 seconds !", position: ToastPosition.top, textStyle: TextStyle(color: Colors.white, fontSize: 30));
    await Future.delayed(Duration(seconds: 5));

    //The points of the wave
    data.pointsCoop+=100+10*wave;
    data.pointsPerso+=100+10*wave;

    //Then we add enemies depending on the wave id
    showToast('The wave ' + wave.toString() + " is starting !", position: ToastPosition.top, textStyle: TextStyle(color: Colors.white, fontSize: 30));
    switch(wave) {
      case 1: {
        for(int i = 0; i < 10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
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
      case 6: {
        for(int i = 0; i < 10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2,images));

        break;
      }
      case 7: {
        for(int i = 0; i < 3; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 8,images));
        }
        for(int i = 0; i < 8; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 6,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 6,images));

        break;
      }
      case 8: {
        for(int i = 0; i < 25; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2,images));

        break;
      }
      case 9: {
        for(int i = 0; i < 10; i++){
          listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 12,images));
        }
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 2,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 10,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 10,images));

        break;
      }
      case 10: {
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 18,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));
        listEnemy.add(EnemyWidget.enemyWidgetRandom(minX, maxX, minY, maxY, 4,images));

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