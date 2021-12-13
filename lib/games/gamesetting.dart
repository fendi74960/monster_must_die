import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monster_must_die/games/gamebuttons.dart';

class GameSetting extends GameButtons {

  @override
  Color backgroundColor() => const Color(0xFF222222);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    ///Force le full screen et une orientation portrait
    Flame.device.fullScreen();
    Flame.device.setOrientation(DeviceOrientation.portraitUp);
  }

  @override
  void update(double dt) {
    super.update(dt);

    //todo
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    //todo
  }

  ///Remet a zero les diff parametres du joueur et de la partie
  void reset() {
    listEnemy.clear();
    listUnit.clear();
    tracking['spawn']=0;
    tracking['emit']=0;
    tracking['spell']=0;
    tracking['archer/marshall']=0;
    tracking['balista/pegase']=0;
    tracking['berserker/spear']=0;
    tracking['cavalrer/wizard']=0;
    tracking['fire/thunder']=0;
    tracking['barricade/transformation']=0;
    playerData.lives=5;
    playerData.pointsPerso=0;
    playerData.pointsCoop=0;
    sortDejaUse=false;
    sortDejaSent=false;
  }
}