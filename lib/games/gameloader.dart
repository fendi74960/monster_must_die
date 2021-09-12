import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';
import '../models/player_data.dart';
import 'package:flame/components.dart';


class GameLoader extends BaseGame {
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

  @override
  Future<void> onLoad() async {

    squarePos = const Rect.fromLTWH(-20, -50, 100, 100);
    playerData=PlayerData();
    unitLance=await loadSprite('Lance.png');
    unitAxe=await loadSprite('Axe.png');
    unitMage=await loadSprite('Mage.png');
    unitBishop=await loadSprite('Bishop.png');
    unitArcher=await loadSprite('Archer.png');
    unitCavArcher=await loadSprite('CavArcher.png');

    listEnemy = List.empty(growable: true);
    for(int i = 0; i < 50 ; i++){
      listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 2));
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
    // Canvas is a class from dart:ui and is it responsible for all the rendering inside of Flame
    canvas.drawRect(squarePos, squarePaint());

    unitLance.render(canvas,position:Vector2(size.x-unitButtonSize.x,0) ,size: unitButtonSize);
    unitAxe.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y) ,size: unitButtonSize);
    unitMage.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*2) ,size: unitButtonSize);
    unitBishop.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*3) ,size: unitButtonSize);
    unitArcher.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*4) ,size: unitButtonSize);
    unitCavArcher.render(canvas,position:Vector2(size.x-unitButtonSize.x,0+unitButtonSize.y*5) ,size: unitButtonSize);

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

    for(int i = 0; i < listEnemy.length; i++)
    {
      listEnemy[i].updateEnemy(dt);
      if(listEnemy[i].getPosition().y>size.y){
        playerData.lives-=1;
        listEnemy.removeAt(i);
      }
    }
  }
}

