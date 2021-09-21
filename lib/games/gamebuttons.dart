import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/widgets/hud.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';

import '../games/gamenetwork.dart';

class GameButtons extends GameNetwork with TapDetector {
  //ready button
  late Sprite readyPressedButton;
  late Sprite readyUnpressedButton;
  final readyPosition = Vector2(0, 0);
  bool readyPressed = false;

  //ally button
  late Sprite allyPressedButton;
  late Sprite allyUnpressedButton;
  final allyPosition = Vector2(0, 40);
  bool allyPressed = false;

  //first unit button
  late Sprite firstButton;
  late Sprite firstButtonSelected;
  late Vector2 firstButtonPosition;

  late Sprite secondButton;
  late Sprite secondButtonSelected;
  late Vector2 secondButtonPosition;

  late Sprite thirdButton;
  late Sprite thirdButtonSelected;
  late Vector2 thirdButtonPosition;

  late Sprite fourthButton;
  late Sprite fourthButtonSelected;
  late Vector2 fourthButtonPosition;

  int selectedUnit = 0;

  final buttonsSize = Vector2(120, 30);
  final buttonsUnitSize = Vector2(60, 60);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Ready and send buttons
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

    //Unit buttons
    firstButton = await loadSprite(
      'Unit/archer/button.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(40, 40),
    );
    secondButton = await loadSprite(
      'Unit/balista/button.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(70, 70),
    );
    thirdButton = await loadSprite(
      'Unit/berserker/button.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(60, 60),
    );
    fourthButton = await loadSprite(
      'Unit/cavalrer/button.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(70, 70),
    );
    firstButtonSelected = await loadSprite(
      'Unit/archer/buttonselected.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(40, 40),
    );
    secondButtonSelected = await loadSprite(
      'Unit/balista/buttonselected.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(70, 70),
    );
    thirdButtonSelected = await loadSprite(
      'Unit/berserker/buttonselected.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(60, 60),
    );
    fourthButtonSelected = await loadSprite(
      'Unit/cavalrer/buttonselected.png',
      srcPosition: Vector2.zero(),
      srcSize: Vector2(70, 70),
    );

    firstButtonPosition = Vector2(size.x-buttonsUnitSize.x,0);
    secondButtonPosition = Vector2(size.x-buttonsUnitSize.x,buttonsUnitSize.y);
    thirdButtonPosition = Vector2(size.x-buttonsUnitSize.x,buttonsUnitSize.y*2);
    fourthButtonPosition = Vector2(size.x-buttonsUnitSize.x,buttonsUnitSize.y*3);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var button = readyPressed ? readyPressedButton : readyUnpressedButton;
    button.render(canvas, position: readyPosition, size: buttonsSize);

    button = allyPressed ? allyPressedButton : allyUnpressedButton;
    button.render(canvas, position: allyPosition, size: buttonsSize);

    if(selectedUnit == 0) {
      firstButtonSelected.render(canvas,position:firstButtonPosition, size: buttonsUnitSize);
    } else {
      firstButton.render(canvas,position:firstButtonPosition, size: buttonsUnitSize);
    }

    if(selectedUnit == 2) {
      secondButtonSelected.render(canvas,position:secondButtonPosition, size: buttonsUnitSize);
    } else {
      secondButton.render(canvas,position:secondButtonPosition, size: buttonsUnitSize);
    }

    if(selectedUnit == 4) {
      thirdButtonSelected.render(canvas,position:thirdButtonPosition, size: buttonsUnitSize);
    } else {
      thirdButton.render(canvas,position:thirdButtonPosition, size: buttonsUnitSize);
    }

    if(selectedUnit == 6) {
      fourthButtonSelected.render(canvas,position:fourthButtonPosition, size: buttonsUnitSize);
    } else {
      fourthButton.render(canvas,position:fourthButtonPosition, size: buttonsUnitSize);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    //todo
  }

  @override
  void onTapDown(TapDownInfo event) {

    if (this.overlays.isActive(Hud.id)) {
      var buttonArea = firstButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = 0;
        listUnit.add(UnitWidget.unitWidgetSpawn(size.x / 2, size.y - 40, 0, images));
      }

      buttonArea = secondButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = 2;
        listUnit.add(UnitWidget.unitWidgetSpawn(size.x / 2, size.y - 40, 2, images));
      }

      buttonArea = thirdButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = 4;
        listUnit.add(UnitWidget.unitWidgetSpawn(size.x / 2, size.y - 40, 4, images));
      }

      buttonArea = fourthButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = 6;
        listUnit.add(UnitWidget.unitWidgetSpawn(size.x / 2, size.y - 40, 6, images));
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