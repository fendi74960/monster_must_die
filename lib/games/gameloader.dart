import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';

import '../models/player_data.dart';


class GameLoader extends BaseGame {
  static const _imageAssets = [
    'heheboy.png',
    'Archer.png',
    'Axe.png',
    'Bishop.png',
    'CavArcher.png',
    'Lance.png',
    'Mage.png',
    'lifebar.png',
    'lifebarRouge.png',
    'fe.png',
    'Lance_attaque_anim.png',
  ];
  // A constant speed, represented in logical pixels per second
  static const int squareSpeed = 400;

  late PlayerData playerData;

  late Rect squarePos;

  // One sprite for each button state
  late Sprite unitLance;
  late Sprite unitAxe;
  late Sprite unitMage;
  late Sprite unitBishop;
  late Sprite unitArcher;
  late Sprite unitCavArcher;

  final unitButtonSize = Vector2(100, 100);

  int squareDirection = 1;

  // BasicPalette is a help class from Flame, which provides default, pre-built instances
  // of Paint that can be used by your game
  static final squarePaint = BasicPalette.white.paint;

  late List<EnemyWidget> listEnemy;

  late List<UnitWidget> listUnit;
  late bool tempAStopper;

  @override
  Future<void> onLoad() async {
    await images.loadAll(_imageAssets);
    squarePos = const Rect.fromLTWH(-20, -50, 100, 100);
    playerData=PlayerData();
    unitLance=await loadSprite('Lance.png');
    unitAxe=await loadSprite('Axe.png');
    unitMage=await loadSprite('Mage.png');
    unitBishop=await loadSprite('Bishop.png');
    unitArcher=await loadSprite('Archer.png');
    unitCavArcher=await loadSprite('CavArcher.png');


    listUnit = List.empty(growable: true);
    listEnemy = List.empty(growable: true);


  }
  void startGame(){
    for(int i = 0; i < 20 ; i++){
      listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 0,images));
    }
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 4,images));
  }

  @override
  void render(Canvas canvas) {
    // Canvas is a class from dart:ui and is it responsible for all the rendering inside of Flame
    canvas.drawRect(squarePos, squarePaint());

    unitLance.render(canvas,position:Vector2(size.x-unitButtonSize.x,0) ,size: unitButtonSize);
    unitAxe.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y) ,size: unitButtonSize);
    unitMage.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*2) ,size: unitButtonSize);
    unitBishop.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*3) ,size: unitButtonSize);
    unitArcher.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*4) ,size: unitButtonSize);
    unitCavArcher.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*5) ,size: unitButtonSize);

    for(int i = 0; i < listUnit.length; i++)
    {
      listUnit[i].renderUnit(canvas);
    }

    for(int i = 0; i < listEnemy.length; i++)
    {
      listEnemy[i].renderEnemy(canvas);
    }


  }

  @override
  void update(double dt) {

    squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);

    if (squareDirection == 1 && squarePos.right > size.x) {
      squareDirection = -1;
      // This does the same, but now checking the left direction
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
      playerData.waves-=1;
    }
    //LOGIQUE POUR UNIT ALLIER
    for(int i = 0; i < listUnit.length; i++)
    {
      EnemyWidget target=EnemyWidget(0,0,0,images);
      if(listUnit[i].isAlive()) {
        if (listEnemy.isNotEmpty) {
          tempAStopper = listUnit[i].isStopped;

          target = listUnit[i].checkInRangeEnnemie(listEnemy);

          if (tempAStopper == listUnit[i].isStopped) {
            listUnit[i].etatChanger = false;
          }
          else {
            listUnit[i].etatChanger = true;
          }

          if (!listUnit[i].isStopped) {
            //Move TOWARDS nearest ennemy
            listUnit[i].updateMovUnit(dt, listUnit[i].speed, target);
            listUnit[i].actualisationAnim(-1);
          }
          else {
            listUnit[i].attaque(dt, target);
            listUnit[i].actualisationAnim(1);
          }
        }
      }
      else {
        listUnit.removeAt(i);
      }
    }
    //LOGIQUE POUR ENEMIES
    for(int i = 0; i < listEnemy.length; i++)
    {
      UnitWidget target=UnitWidget(0,0,0,images);
      if(listEnemy[i].isAlive()) {
        tempAStopper=listEnemy[i].isStopped;
        target = listEnemy[i].checkInRangeUnit(listUnit,size);

        if(tempAStopper==listEnemy[i].isStopped){
          listEnemy[i].etatChanger=false;
        }
        else{
          listEnemy[i].etatChanger=true;
        }

        if(!listEnemy[i].isStopped) {
          //Move TOWARDS nearest ennemy
          listEnemy[i].updateMovEnemie(dt, listEnemy[i].speed,target);
          listEnemy[i].actualisationAnim(-1);
        }
        else{
          listEnemy[i].attaque(dt,target);
          listEnemy[i].actualisationAnim(1);
        }

        if (listEnemy[i].getPosition().y > size.y) {
          playerData.lives -= 1;
          listEnemy.removeAt(i);
        }
      }
      else {
        listEnemy.removeAt(i);
      }
    }


    //HIERARCHIE EN COMMENTAIRES DES FUTURS FONCTIONS COTE ENNEMIES
    //check si en vie

    //check si un unit from unitList a porte
      //ATTENTION METTRE UN BOOLEAN SI PAS BESOIN DE RECHANGER ANIMATION
      //Si non alors change animation to avance
      //Si oui alors change animation puis attaque

    //HIERARCHIE EN COMMENTAIRES DES FUTURS FONCTIONS COTE Unit
    //check si en vie

    //check si un unit from unitList a porte
      //ATTENTION METTRE UN BOOLEAN SI PAS BESOIN DE RECHANGER ANIMATION
      //Si non alors change animation to avance VERS ennemie plus proche
      //Si oui alors change animation puis attaque

    //HIERARCHIE EN COMMENTAIRES DES FUTURS FONCTIONS de la suite
    //Check nb ennemie si 0 faire l'etape de pause
    //si >0 rien faire
  }


}

