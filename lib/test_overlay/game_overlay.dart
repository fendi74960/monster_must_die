import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'player_data.dart';



class MyGame extends Game {
  // A constant speed, represented in logical pixels per second
  static const int squareSpeed = 400;

  late PlayerData playerData;

  late Rect squarePos;


  int squareDirection = 1;


  @override
  Future<void> onLoad() async {
    Flame.device.fullScreen();
    squarePos = const Rect.fromLTWH(-20, -50, 100, 100);
    playerData=PlayerData();
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
  }
}

