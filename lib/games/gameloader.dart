import 'dart:io';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/controller/wavecontroller.dart';
import 'package:monster_must_die/widgets/enemywidget.dart';
import 'package:monster_must_die/widgets/game_over_menu.dart';
import 'package:monster_must_die/widgets/hud.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';

import 'package:path_provider/path_provider.dart';

import '../models/player_data.dart';

class GameLoader extends FlameGame {
  //Permet de mettre en cache les images plus tard
  static const _imageAssets = [
    'heheboy.png',
    'lifebar.png',
    'lifebarRouge.png',
    'fe.png',
    'Enemy/zombie/attack.png',
    'Enemy/ghost/moving.png',
    'Enemy/gargoyle/attack.png',
    'Enemy/eye/moving.png',
    'Enemy/dog/attack.png',
    'Enemy/cyclop/attack.png',
    'Enemy/archer/attack.png',
    'Unit/archer/attack.png',
    'Unit/balista/attack.png',
    'Unit/berserker/attack.png',
    'Unit/cavalrer/attack.png',
    'Unit/pegas/attack.png',
    'Unit/marshall/attack.png',
    'Unit/spear/attack.png',
    'Unit/wizard/attack.png',
    'Enemy/zombie/moving.png',
    'Enemy/gargoyle/moving.png',
    'Enemy/dog/moving.png',
    'Enemy/cyclop/moving.png',
    'Enemy/archer/moving.png',
    'Enemy/dragon/moving.png',
    'Enemy/chicken/moving.png',
    'Enemy/lich/moving.png',
    'Enemy/dragon/attack.png',
    'Enemy/lich/attack.png',
    'Unit/archer/moving.png',
    'Unit/balista/moving.png',
    'Unit/berserker/moving.png',
    'Unit/cavalrer/moving.png',
    'Unit/pegas/moving.png',
    'Unit/marshall/moving.png',
    'Unit/spear/moving.png',
    'Unit/wizard/moving.png',
    'Background/field.png',
    'Background/fog.png',
    'Background/forest.png',
    'Background/rain.png',
    'Background/swamp.png',
    'Background/volcano.png',
    'Spell/fireball.png',
    'Spell/thunder.png',
    'Spell/transformation.png',
    'Spell/transformation_button.png',
    'Spell/thunder_button.png',
    'Spell/fireball_button.png',
    'Spell/barricade_button.png',
    'Spell/barricade.png'

  ];
  int howMuchItCostSpell(int id)
  {
    const unitsCost = [40,30,60,10 ];
    return unitsCost[id];
  }

  //Map a convert to json
  Map<String, dynamic> tracking= {};

  late SpriteComponent background;

  late SpriteAnimationComponent spell;
  late int counterBarricade=100;
  late int typeBg = 1;
  late int typeSpell=2;

  late PlayerData playerData;

  //Listes des unit/ennemie qui vont apparaitre
  late List<EnemyWidget> listEnemy;
  late List<UnitWidget> listUnit;

  //boolean temp pour voir si unit/ennemy ne bouge plus
  late bool tempAStopper;

  late File jsonFile;

  var typePossible=[0,4,6,8,10,12,14,16];
  ///Charger plusieurs element au debut du jeu
  @override
  Future<void> onLoad() async {
    await images.loadAll(_imageAssets);
    playerData = PlayerData();
    listUnit = List.empty(growable: true);
    listEnemy = List.empty(growable: true);
    changeBackground(typeBg);
    spell=SpriteAnimationComponent(position: Vector2.zero(),size:size );
    //Initialize les valeurs du json a 0 pour de ne pas avoir de pb de null
    tracking['spawn']=0;
    tracking['emit']=0;
    tracking['spell']=0;
    tracking['archer/marshall']=0;
    tracking['balista/pegase']=0;
    tracking['berserker/spear']=0;
    tracking['cavalrer/wizard']=0;
    tracking['fire/thunder']=0;
    tracking['barricade/transformation']=0;

    /*if(!kIsWeb)
    {
      jsonFile= await _localFile;
      tracking['test']=1;
      String jsonn =json.encode(tracking);
      jsonFile.writeAsString(jsonn);
      final content = await readFile(jsonFile);
      print(content);
    }*/

  }

  ///Lance le jeu en creant pour l'instant des ennemies random
  void startGame() {
    /*for(int i = 0; i < 5 ; i++){
      listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 0,images));
    }
    //TODO y supprimer plus tard
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 2,images));
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 4,images));
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 6,images));
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 8,images));
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 10,images));
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 12,images));*/
    /*listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 14,images));
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 16,images));*/
    listEnemy.add(EnemyWidget.enemyWidgetRandom(20, size.x - 20, 20, size.y - 20, 18,images));
    WaveController.newWave(7, listEnemy, 0.toDouble(), size.x, 0, size.y / 3, images, playerData);
    //A ENLEVER
    //startSpell(typeSpell);

  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<String> readFile(File fil) async {
      final file = fil;

      // Read the file
      final contents = await file.readAsString();

      return contents;

  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tracking.json');
  }
  ///change le background en fonction de [bgID] donnée
  void changeBackground(int bgId) {
    typeBg=bgId;
    switch (typeBg) {
      case 0:
        background = SpriteComponent.fromImage(images.fromCache("Background/field.png"),
            size: Vector2(size.x, size.y),
            srcSize: Vector2(256,160 ),
            position: Vector2(0, 0));
        break;
      case 1:
        background = SpriteComponent.fromImage(images.fromCache("Background/fog.png"),
            size: Vector2(size.x, size.y),
            srcSize: Vector2(240,160 ),
            position: Vector2(0, 0));
        break;
      case 2:
        background = SpriteComponent.fromImage(images.fromCache("Background/forest.png"),
            size: Vector2(size.x, size.y),
            srcSize: Vector2(240, 160),
            position: Vector2(0, 0));
        break;
      case 3:
        background = SpriteComponent.fromImage(images.fromCache("Background/rain.png"),
            size: Vector2(size.x, size.y),
            srcSize: Vector2(240,160 ),
            position: Vector2(0, 0));
        break;
      case 4:
        background = SpriteComponent.fromImage(images.fromCache("Background/swamp.png"),
            size: Vector2(size.x, size.y),
            srcSize: Vector2(1280,960 ),
            position: Vector2(0, 0));
        break;
      case 5:
        background = SpriteComponent.fromImage(images.fromCache("Background/volcano.png"),
            size: Vector2(size.x, size.y),
            srcSize: Vector2(256,160 ),
            position: Vector2(0, 0));
        break;
      default:
        break;
    }
  }
 ///Lance l'animation d'un sort en fonction de [spellId] donnée
  void startSpell(int spellId){
      tracking['spell']+=1;
      typeSpell=spellId;
      spell.position=Vector2(0,0);
      spell.size=Vector2(size.x,size.y);
      switch (spellId) {
      //fireball
        case 0:
          spell.animation=SpriteAnimation.fromFrameData(
              images.fromCache('Spell/fireball.png'),
              SpriteAnimationData.sequenced(
                amount: 21,
                textureSize: Vector2(240, 61),
                stepTime: 0.1,
              ));
          break;
          //thunder
        case 1:
          spell.animation=SpriteAnimation.fromFrameData(
              images.fromCache('Spell/thunder.png'),
              SpriteAnimationData.sequenced(
                amount: 12,
                textureSize: Vector2(137, 63),
                stepTime: 0.1,
              ));
          break;
          //transfo
        case 2:
          spell.animation=SpriteAnimation.fromFrameData(
              images.fromCache('Spell/transformation.png'),
              SpriteAnimationData.sequenced(
                amount: 22,
                textureSize: Vector2(240, 61),
                stepTime: 0.1,
              ));
          break;
        case 3:
          counterBarricade=100;
          spell.position=Vector2(0,size.y*0.8);
          spell.size=Vector2(size.x,size.y*0.2);
          spell.animation=SpriteAnimation.fromFrameData(
              images.fromCache('Spell/barricade.png'),
              SpriteAnimationData.sequenced(
                amount: 15,
                textureSize: Vector2(85, 107),
                stepTime: 0.1,
              ));
          break;
        default:
          break;
      }
      spell.animation?.loop=false;
      spell.playing=true;
      spell.setOpacity(0.5);
    }



  ///Execute chaque frame pour render les differents choses sur le [canvas]
  @override
  void render(Canvas canvas) {
    canvas.save();
    background.render(canvas);
    canvas.restore();
    for (int i = 0; i < listUnit.length; i++) {
      listUnit[i].renderUnit(canvas);
    }

    for (int i = 0; i < listEnemy.length; i++) {
      listEnemy[i].renderEnemy(canvas);
    }
    canvas.save();
    if(spell.animation != null ){
      bool? temp =spell.animation?.isLastFrame;
      if( temp !=null && temp ) {
        if(typeSpell!=3 || (counterBarricade<=0)) {
          spell.playing=false;
        }
      }
    }

    if(spell.playing) {
      spell.render(canvas);
    }
    canvas.restore();
  }

  ///Executer chaque frame pour update certaines action dont les mouvements avec un [dt]
  @override
  void update(double dt) {
    //LOGIQUE POUR UNIT ALLIER
    for (int i = 0; i < listUnit.length; i++) {
      EffectOfBg(listUnit[i]);
      EnemyWidget target = EnemyWidget(0, 0, 0, images);
      if (listUnit[i].isAlive()) {
        if (listEnemy.isNotEmpty) {
          tempAStopper = listUnit[i].isStopped;

          target = listUnit[i].checkInRangeEnnemie(listEnemy);

          if (tempAStopper == listUnit[i].isStopped) {
            listUnit[i].etatChanger = false;
          } else {
            listUnit[i].etatChanger = true;
          }

          if (!listUnit[i].isStopped) {
            //Move TOWARDS nearest ennemy
            listUnit[i].updateMovUnit(dt, listUnit[i].speed, target);
          } else {
            listUnit[i].attaque(dt, target);
          }
          if(listUnit[i].etatChanger){
            listUnit[i].actualisationAnim();
          }
        }
      } else {
        listUnit.removeAt(i);
      }
    }
    //LOGIQUE POUR ENEMIES
    for (int i = 0; i < listEnemy.length; i++) {
      EffectOfBg(listEnemy[i]);
      if(spell.playing) {
        EffectOfSpell(listEnemy[i]);
      }
      UnitWidget target = UnitWidget(0, 0, 0, images, null, 0);
      if (listEnemy[i].isAlive()) {
        tempAStopper = listEnemy[i].isStopped;
        target = listEnemy[i].checkInRangeUnit(listUnit, size);
        if (tempAStopper == listEnemy[i].isStopped) {
          listEnemy[i].etatChanger = false;
        } else {
          listEnemy[i].etatChanger = true;
        }

        if (!listEnemy[i].isStopped && listEnemy[i].type!=19) {
          //Move TOWARDS nearest ennemy
          listEnemy[i].updateMovEnemie(dt, listEnemy[i].speed, target);
        } else {
          listEnemy[i].attaque(dt, target);
        }
        if(listEnemy[i].etatChanger){
          listEnemy[i].actualisationAnim();
        }


        if(listEnemy[i].type==18){
          bool? isLast=listEnemy[i].animation?.isLastFrame;
          if(isLast!=null && isLast){
            listEnemy[i].actualisationAnim();
          }
        }
        if(listEnemy[i].type==19){
          bool? isLast=listEnemy[i].animation?.isLastFrame;
          if(isLast!=null && isLast){
            listEnemy[i].actualisationAnim();
            //fait spawn un zombie
            listEnemy.add(EnemyWidget(listEnemy[i].x,listEnemy[i].y,12,images));
          }
        }
        if (listEnemy[i].position.y > size.y) {
          playerData.lives -= 1;
          listEnemy.removeAt(i);
          if(playerData.lives<=0){
            pauseEngine();
            overlays.remove(Hud.id);
            overlays.add(GameOverMenu.id);

          }
        }

      } else {
          if(listEnemy[i].type==16){
            var rnd = Random();
            listEnemy[i]=EnemyWidget(listEnemy[i].x, listEnemy[i].y,typePossible[rnd.nextInt(typePossible.length)] , images);
          }
          else{
            listEnemy.removeAt(i);
          }

      }
    }
    spell.animation?.update(dt);
  }

  ///L'effet du background sur les unit allier ou ennemies
  void EffectOfBg(var unit) {
    switch (typeBg) {
      //FOG
      case 1:
        if(unit.isRanged && unit.effetUnique){
          unit.range/=2;
          unit.effetUnique=false;
        }
        break;
        //FOREST
      case 2:
        if(unit.isFlying){
          unit.health-=0.1;
        }
        break;
        //RAIN
      case 3:
        if(unit.isFlying&& unit.effetUnique){
          if(unit.speed>0.4) {
            unit.speed-=0.4;
          } else {
            unit.speed=0.2;
          }
          unit.effetUnique=false;
        }
        break;
        //SWAMP
      case 4:
        if(!unit.isFlying && unit.effetUnique){
          if(unit.speed>0.4) {
            unit.speed-=0.4;
          } else {
            unit.speed=0.2;
          }
          unit.effetUnique=false;
        }
        break;
        //VOLCANO
      case 5:
        if(!unit.isFlying){
          unit.health-=0.1;
        }
        break;
      default:
        break;
    }
  }

  void EffectOfSpell(var unit) {
    switch (typeSpell) {
    //Fireball
      case 0:
        if(!unit.isFlying){
          unit.health-=2;
        }
        break;
    //Thunder
      case 1:
        if(unit.isFlying){
          unit.health-=2;
        }
        break;
    //Transfo
      case 2:
        if(spell.animation != null ){
          int? temp =spell.animation?.frames.length;
          if(spell.animation?.currentIndex ==temp!-2 ) {
            var rnd = Random();
            double oldHealthPource;
            for(int i=0;i<listEnemy.length;i++){
              if(![18,19].contains(listEnemy[i].type)) {
                oldHealthPource = listEnemy[i].health / listEnemy[i].maxHealth;
                listEnemy[i] = EnemyWidget(listEnemy[i].x, listEnemy[i].y,
                    typePossible[rnd.nextInt(typePossible.length)], images);
                listEnemy[i].health = listEnemy[i].maxHealth * oldHealthPource;
              }
            }
          }
        }
        break;
      case 3:
        if(unit.y>size.y*0.8){
          unit.health-=5;
          counterBarricade--;
        }
        break;
      default:
        break;
    }
  }
}
