import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import '../models/player_data.dart';
import 'package:flame/components.dart';




class MyGame extends BaseGame {
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


  @override
  Future<void> onLoad() async {
    Flame.device.fullScreen();
    squarePos = const Rect.fromLTWH(-20, -50, 100, 100);
    playerData=PlayerData();
    unitLance=await loadSprite('Lance.png');
    unitAxe=await loadSprite('Axe.png');
    unitMage=await loadSprite('Mage.png');
    unitBishop=await loadSprite('Bishop.png');
    unitArcher=await loadSprite('Archer.png');
    unitCavArcher=await loadSprite('CavArcher.png');

  }
  // BasicPalette is a help class from Flame, which provides default, pre-built instances
  // of Paint that can be used by your game
  static final squarePaint = BasicPalette.white.paint;

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


  }
}

