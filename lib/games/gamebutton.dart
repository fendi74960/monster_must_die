import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import '../games/gamenetwork.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';

class GameButton extends GameNetwork with TapDetector {

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //todo
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

  @override
  void onTapDown(TapDownInfo event) {
    // On tap down we need to check if the event ocurred on the
    // button area. There are several ways of doing it, for this
    // tutorial we do that by transforming ours position and size
    // vectors into a dart:ui Rect by using the `&` operator, and
    // with that rect we can use its `contains` method which checks
    // if a point (Offset) is inside that rect
    final buttonArea = Vector2(size.x-unitButtonSize.x,0) & unitButtonSize;
    if( buttonArea.contains(event.eventPosition.game.toOffset())){
      listUnit.add(UnitWidget.unitWidgetSpawn(size.x/2,size.y,0,images));
    }

  }
}