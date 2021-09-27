import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
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
  int firstButtonUnitType = 0;

  late Sprite secondButton;
  late Sprite secondButtonSelected;
  late Vector2 secondButtonPosition;
  int secondButtonUnitType = 2;

  late Sprite thirdButton;
  late Sprite thirdButtonSelected;
  late Vector2 thirdButtonPosition;
  int thirdButtonUnitType = 4;

  late Sprite fourthButton;
  late Sprite fourthButtonSelected;
  late Vector2 fourthButtonPosition;
  int fourthButtonUnitType = 6;

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

    //check if the button is pressed and it change the sprite if yes
    var button = readyPressed ? readyPressedButton : readyUnpressedButton;
    button.render(canvas, position: readyPosition, size: buttonsSize);

    button = allyPressed ? allyPressedButton : allyUnpressedButton;
    button.render(canvas, position: allyPosition, size: buttonsSize);

    //check if the unit is selected and it change the sprite if yes
    if(selectedUnit == firstButtonUnitType) {
      firstButtonSelected.render(canvas,position:firstButtonPosition, size: buttonsUnitSize);
    } else {
      firstButton.render(canvas,position:firstButtonPosition, size: buttonsUnitSize);
    }

    if(selectedUnit == secondButtonUnitType) {
      secondButtonSelected.render(canvas,position:secondButtonPosition, size: buttonsUnitSize);
    } else {
      secondButton.render(canvas,position:secondButtonPosition, size: buttonsUnitSize);
    }

    if(selectedUnit == thirdButtonUnitType) {
      thirdButtonSelected.render(canvas,position:thirdButtonPosition, size: buttonsUnitSize);
    } else {
      thirdButton.render(canvas,position:thirdButtonPosition, size: buttonsUnitSize);
    }

    if(selectedUnit == fourthButtonUnitType) {
      fourthButtonSelected.render(canvas,position:fourthButtonPosition, size: buttonsUnitSize);
    } else {
      fourthButton.render(canvas,position:fourthButtonPosition, size: buttonsUnitSize);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo event) {

    //check if the unit is selected and it change the selectedUnit if yes
    if (this.overlays.isActive(Hud.id)) {
      var buttonArea = firstButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = firstButtonUnitType;
      }
      buttonArea = secondButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = secondButtonUnitType;
      }
      buttonArea = thirdButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = thirdButtonUnitType;
      }
      buttonArea = fourthButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        selectedUnit = fourthButtonUnitType;
      }

      //add unit when we tap on the screen (at the bottom half of the screen)
      if(event.eventPosition.game.x<size.x-buttonsUnitSize.x  && event.eventPosition.game.y>size.y/2) {
        if(playerData.pointsPerso>0 && UnitWidget.howMuchItCost(selectedUnit)<=playerData.pointsPerso) {
          listUnit.add(UnitWidget.unitWidgetSpawn(event.eventPosition.game.x, event.eventPosition.game.y, selectedUnit, images,playerData,playerType));
        }
      }

      //emit to the server a command (ready or toother)
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
        socket.emit('toother', { 'id': selectedUnit.toString(), 'nb': '1' });
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

  ///Set the unit of the player (there's 2 possibility)
  void setUnitType() async {

    if(playerType == 1) {
      firstButton = await loadSprite(
        'Unit/dragon/button.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(100, 100),
      );
      secondButton = await loadSprite(
        'Unit/marshall/button.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(70, 70),
      );
      thirdButton = await loadSprite(
        'Unit/spear/button.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(50, 50),
      );
      fourthButton = await loadSprite(
        'Unit/wizard/button.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(50, 50),
      );
      firstButtonSelected = await loadSprite(
        'Unit/dragon/buttonselected.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(100, 100),
      );
      secondButtonSelected = await loadSprite(
        'Unit/marshall/buttonselected.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(70, 70),
      );
      thirdButtonSelected = await loadSprite(
        'Unit/spear/buttonselected.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(50, 50),
      );
      fourthButtonSelected = await loadSprite(
        'Unit/wizard/buttonselected.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(50, 50),
      );
      selectedUnit = 8;
      firstButtonUnitType = 8;
      secondButtonUnitType = 10;
      thirdButtonUnitType = 12;
      fourthButtonUnitType = 14;
    }
  }
}