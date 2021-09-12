import 'dart:ui';

import 'package:flame/flame.dart';

import '../games/gamebutton.dart';

class GameSetting extends GameButton {

  @override
  Color backgroundColor() => const Color(0xFF222222);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Flame.device.fullScreen();
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
}