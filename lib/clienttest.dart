import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';
import 'package:monster_must_die/main.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;


void main() {

  /*
  // Dart client
  IO.Socket socket = IO.io('http://localhost:3000');
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
  */

  final myGame = ClientTest();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

class ClientTest extends MyGame with TapDetector { //Don't forget the TapDetecor !

  late Sprite pressedButton;
  late Sprite unpressedButton;
  final buttonPosition = Vector2(0, 0);
  final buttonSize = Vector2(120, 30);
  bool isPressed = false;

  @override
  Future<void> onLoad() async {

    super.onLoad();

    unpressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2.zero(), // this is zero by default
      srcSize: Vector2(60, 20),
    );

    pressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
  }

  @override
  void render(Canvas canvas) {

    final button = isPressed ? pressedButton : unpressedButton;
    button.render(canvas, position: buttonPosition, size: buttonSize);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPressed) {
      print("click !");
    }
  }

  @override
  void onTapDown(TapDownInfo event) {

    final buttonArea = buttonPosition & buttonSize;

    isPressed = buttonArea.contains(event.eventPosition.game.toOffset());
  }

  @override
  void onTapUp(TapUpInfo event) {
    isPressed = false;
  }

  @override
  void onTapCancel() {
    isPressed = false;
  }
}