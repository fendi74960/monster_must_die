import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/widgets/hud.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';

import '../games/gamenetwork.dart';

class GameButtons extends GameNetwork with TapDetector {
  //readyButton
  late Sprite readyPressedButton;
  late Sprite readyUnpressedButton;
  final readyPosition = Vector2(0, 0);
  bool readyPressed = false;

  //allyButton
  late Sprite allyPressedButton;
  late Sprite allyUnpressedButton;
  final allyPosition = Vector2(0, 40);
  bool allyPressed = false;

  final buttonsSize = Vector2(120, 30);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    readyUnpressedButton = await loadSprite(
      'ready-buttons.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(60, 20),
    );
    readyPressedButton = await loadSprite(
      'ready-buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );

    allyUnpressedButton = await loadSprite(
      'send-buttons.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(60, 20),
    );
    allyPressedButton = await loadSprite(
      'send-buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var button = readyPressed ? readyPressedButton : readyUnpressedButton;
    button.render(canvas, position: readyPosition, size: buttonsSize);

    button = allyPressed ? allyPressedButton : allyUnpressedButton;
    button.render(canvas, position: allyPosition, size: buttonsSize);
  }

  @override
  void update(double dt) {
    super.update(dt);

    //todo
  }

  @override
  void onTapDown(TapDownInfo event) {
    // On tap down we need to check if the event ocurred on the
    // button area. There are several ways of doing it, for this
    // tutorial we do that by transforming ours position and size
    // vectors into a dart:ui Rect by using the `&` operator, and
    // with that rect we can use its `contains` method which checks
    // if a point (Offset) is inside that rect
    if (this.overlays.isActive(Hud.id)) {
      var buttonArea = Vector2(size.x - unitButtonSize.x, 0) & unitButtonSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        listUnit.add(
            UnitWidget.unitWidgetSpawn(size.x / 2, size.y - 40, 4, images));
      }

      buttonArea = readyPosition & buttonsSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset()) &&
          readyPressed == false) {
        print("I'm ready");
        socket.emit('ready', 'true');
      }
      readyPressed = buttonArea.contains(event.eventPosition.game.toOffset());

      buttonArea = allyPosition & buttonsSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset()) &&
          allyPressed == false) {
        print("Send unit to ally");
        socket.emit('toother', '1');
      }
      allyPressed = buttonArea.contains(event.eventPosition.game.toOffset());
    }
  }

  @override
  void onTapUp(TapUpInfo event) {
    readyPressed = false;
    allyPressed = false;
  }

  @override
  void onTapCancel() {
    readyPressed = false;
    allyPressed = false;
  }
}