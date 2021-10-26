import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/widgets/hud.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';
import '../games/gamenetwork.dart';
import 'package:monster_must_die/controller/bestiarycontroller.dart';

class GameButtons extends GameNetwork with TapDetector {
  //ready button
  late Sprite readyPressedButton;
  late Sprite readyUnpressedButton;
  final readyPosition = Vector2(0, 0);
  bool readyPressed = false;

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

  late Sprite firstSpellButton;
  late Vector2 firstSpellButtonPosition;

  late Sprite secondSpellButton;
  late Vector2 secondSpellButtonPosition;

  int spellUnique=0;

  int selectedUnit = 0;
  bool enemyClicked = false;

  final buttonsSize = Vector2(120, 30);
  late Vector2 buttonsUnitSize;

  List<int> arrayToSend = [0, 0, 0, 0];
  //For the HUD
  ButtonData buttonData = ButtonData();

  // For the Bestiary
  InformationData informationData = InformationData();
  BestiaryController bController = BestiaryController();
  int currentBestiaryIndex = 0;

  bool threadStarted = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    buttonsUnitSize = Vector2(size.x * 0.15, size.x * 0.15);

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

    firstSpellButton = await loadSprite(
      'Spell/fireball_button.png',
      srcPosition:Vector2.zero() ,
      srcSize: Vector2(650,650),
    );

    secondSpellButton = await loadSprite(
      'Spell/transformation_button.png',
      srcPosition:Vector2.zero() ,
      srcSize: Vector2(62,63),
    );

    firstButtonPosition = Vector2(size.x - buttonsUnitSize.x, 0);
    secondButtonPosition =
        Vector2(size.x - buttonsUnitSize.x, buttonsUnitSize.y);
    thirdButtonPosition =
        Vector2(size.x - buttonsUnitSize.x, buttonsUnitSize.y * 2);
    fourthButtonPosition =
        Vector2(size.x - buttonsUnitSize.x, buttonsUnitSize.y * 3);
    firstSpellButtonPosition= Vector2(size.x - buttonsUnitSize.x, buttonsUnitSize.y * 4);
    secondSpellButtonPosition= Vector2(size.x - buttonsUnitSize.x, buttonsUnitSize.y * 5);

    majInformationData();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    //check if the button is pressed and it change the sprite if yes
    var button = readyPressed ? readyPressedButton : readyUnpressedButton;
    button.render(canvas, position: readyPosition, size: buttonsSize);

    //check if the unit is selected and it change the sprite if yes
    if (selectedUnit == firstButtonUnitType) {
      firstButtonSelected.render(canvas,
          position: firstButtonPosition, size: buttonsUnitSize);
    } else {
      firstButton.render(canvas,
          position: firstButtonPosition, size: buttonsUnitSize);
    }

    if (selectedUnit == secondButtonUnitType) {
      secondButtonSelected.render(canvas,
          position: secondButtonPosition, size: buttonsUnitSize);
    } else {
      secondButton.render(canvas,
          position: secondButtonPosition, size: buttonsUnitSize);
    }

    if (selectedUnit == thirdButtonUnitType) {
      thirdButtonSelected.render(canvas,
          position: thirdButtonPosition, size: buttonsUnitSize);
    } else {
      thirdButton.render(canvas,
          position: thirdButtonPosition, size: buttonsUnitSize);
    }

    if (selectedUnit == fourthButtonUnitType) {
      fourthButtonSelected.render(canvas,
          position: fourthButtonPosition, size: buttonsUnitSize);
    } else {
      fourthButton.render(canvas,
          position: fourthButtonPosition, size: buttonsUnitSize);
    }

    firstSpellButton.render(canvas,position: firstSpellButtonPosition,size:buttonsUnitSize);
    secondSpellButton.render(canvas,position: secondSpellButtonPosition,size:buttonsUnitSize);
  }

  //Every 5 seconds, send the selected units to send to your comrade
  void sendThread() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    if (arrayToSend[0] > 0) {
      tracking['emit']+=arrayToSend[0];
      socket.emit('toother', {
        'id': firstButtonUnitType.toString(),
        'nb': arrayToSend[0].toString()
      });
    }
    if (arrayToSend[1] > 0) {
      tracking['emit']+=arrayToSend[1];
      socket.emit('toother', {
        'id': secondButtonUnitType.toString(),
        'nb': arrayToSend[1].toString()
      });
    }
    if (arrayToSend[2] > 0) {
      tracking['emit']+=arrayToSend[2];
      socket.emit('toother', {
        'id': thirdButtonUnitType.toString(),
        'nb': arrayToSend[2].toString()
      });
    }
    if (arrayToSend[3] > 0) {
      tracking['emit']+=arrayToSend[3];
      socket.emit('toother', {
        'id': fourthButtonUnitType.toString(),
        'nb': arrayToSend[3].toString()
      });
    }

    arrayToSend = [0, 0, 0, 0];
    buttonData.numberToSend = 0;
    threadStarted = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo event) {
    //check if the unit is selected and it change the selectedUnit if yes
    if (this.overlays.isActive(Hud.id)) {
      for (int i = 0; i < listEnemy.length; i++) {
        var buttonArea = listEnemy[i].position -
                Vector2(listEnemy[i].size.x / 2, listEnemy[i].size.y / 2) &
            listEnemy[i].size;

        if (buttonArea.contains(event.eventPosition.game.toOffset())) {
          print("Enemy clicked");
          print("Need help enemy type : " + listEnemy[i].type.toString());
          sendHelp(listEnemy[i].type);
          enemyClicked = true;
          //await Future.delayed(const Duration(seconds: 5), (){});
        }
      }

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

      buttonArea = firstSpellButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        if(howMuchItCostSpell(spellUnique) <= playerData.pointsPerso) {
          playerData.pointsPerso-=howMuchItCostSpell(spellUnique);
          startSpell(spellUnique);
        }
      }

      buttonArea = secondSpellButtonPosition & buttonsUnitSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset())) {
        if(howMuchItCostSpell(2) <= playerData.pointsPerso) {
          playerData.pointsPerso-=howMuchItCostSpell(2);
          startSpell(2);
        }
      }

      //add unit when we tap on the screen (at one tier of the screen)
      if (!enemyClicked &&
          event.eventPosition.game.x < size.x - buttonsUnitSize.x &&
          event.eventPosition.game.y > size.y / 3) {
        if (playerData.pointsPerso > 0 &&
            UnitWidget.howMuchItCost(selectedUnit) <= playerData.pointsPerso) {
          listUnit.add(UnitWidget.unitWidgetSpawn(
              event.eventPosition.game.x,
              event.eventPosition.game.y,
              selectedUnit,
              images,
              playerData,
              playerType));
          tracking['spawn']+=1;
          switch(selectedUnit){
            case 0:
            case 8:
            tracking['archer/marshall']+=1;
              break;
            case 2:
            case 10:
              tracking['balista/pegase']+=1;
              break;
            case 4:
            case 12:
              tracking['berserker/spear']+=1;
              break;
            case 6:
            case 14:
              tracking['cavalrer/wizard']+=1;
              break;
            default:
              break;

          }
        }
      }
      enemyClicked = false;

      //emit to the server a command (ready or toother)
      buttonArea = readyPosition & buttonsSize;
      if (buttonArea.contains(event.eventPosition.game.toOffset()) &&
          readyPressed == false) {
        print("I'm ready");
        socket.emit('ready', 'true');
      }
      readyPressed = buttonArea.contains(event.eventPosition.game.toOffset());
    }
  }

  @override
  void onTapUp(TapUpInfo event) {
    readyPressed = false;
  }

  @override
  void onTapCancel() {
    readyPressed = false;
  }

  ///Set the unit of the player (there's 2 possibility)
  void setUnitType() async {
    if (playerType == 1) {
      firstButton = await loadSprite(
        'Unit/pegas/button.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(70, 70),
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
        'Unit/pegas/buttonselected.png',
        srcPosition: Vector2.zero(),
        srcSize: Vector2(70, 70),
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

      firstSpellButton = await loadSprite(
        'Spell/thunder_button.png',
        srcPosition:Vector2.zero() ,
        srcSize: Vector2(580,540),
      );

      spellUnique=1;
      selectedUnit = 8;
      firstButtonUnitType = 8;
      secondButtonUnitType = 10;
      thirdButtonUnitType = 12;
      fourthButtonUnitType = 14;
    }
  }

  void majInformationData() {
    informationData.enemieInformation = bController.getEnemieInformation(currentBestiaryIndex);
  }
}

//Class where the variable inside can be display on the hud menu
// it use a notifier when the variable change
class ButtonData extends ChangeNotifier   {
  int _numberToSend = 0;

  int get numberToSend => _numberToSend;

  set numberToSend(int value) {
    _numberToSend = value;
    notifyListeners();
  }
}
