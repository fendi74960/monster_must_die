import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';


void main() {
  final myGame = MyGame();
  runApp(GameWidget(game: myGame));
}

class MyGame extends Game with TapDetector {
  // One sprite for each button state
  late Sprite pressedButton;
  late Sprite unpressedButton;
  // Just like our robot needs its position and size, here we create two
  // variables for the button as well
  final buttonPosition = Vector2(200, 120);
  final buttonSize = Vector2(120, 30);
  // Simple boolean variable to tell if the button is pressed or not
  bool isPressed = false;

  late SpriteAnimation runningRobot;

  // Vector2 is a class from `package:vector_math/vector_math_64.dart` and is widely used
  // in Flame to represent vectors. Here we need two vectors, one to define where we are
  // going to draw our robot and another one to define its size
  final robotPosition = Vector2(100, 50);
  final robotSize = Vector2(48, 60);

  // Now, on the `onLoad` method, we need to load our animation. To do that we can use the
  // `loadSpriteAnimation` method, which is present on our game class.
  @override
  Future<void> onLoad() async {
    runningRobot = await loadSpriteAnimation(
      'robot.png',
      // `SpriteAnimationData` is a class used to tell Flame how the animation Sprite Sheet
      // is organized. In this case we are describing that our frames are laid out in a horizontal
      // sequence on the image, that there are 8 frames, that each frame is a sprite of 16x18 pixels,
      // and, finally, that each frame should appear for 0.1 seconds when the animation is running.
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(16, 18),
        stepTime: 0.1,
      ),
    );

    // Just like we have a `loadSpriteAnimation` function, here we can use
    // `loadSprite`. To use it, we just need to inform the asset's path
    // and the position and size defining the section of the whole image
    // that we want. If we wanted to have a sprite with the full image, `srcPosition`
    // and `srcSize` could just be omitted
    unpressedButton = await loadSprite(
      'buttons.png',
      // `srcPosition` and `srcSize` here tells `loadSprite` that we want
      // just a rect (starting at (0, 0) with the dimensions (60, 20)) of the image
      // which gives us only the first button
      srcPosition: Vector2.zero(), // this is zero by default
      srcSize: Vector2(60, 20),
    );

    pressedButton = await loadSprite(
      'buttons.png',
      // Same thing here, but now a rect starting at (0, 20)
      // which gives us only the second button
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
  }

  // Finally, we just modify our update method so the animation is
  // updated only if the button is pressed
  @override
  void update(double dt) {
    if (isPressed) {
      runningRobot.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    // Since an animation is basically a list of sprites, to render it, we just need to get its
    // current sprite and render it on our canvas. Which frame is the current sprite is updated on the `update` method.
    runningRobot
        .getSprite()
        .render(canvas, position: robotPosition, size: robotSize);

    final button = isPressed ? pressedButton : unpressedButton;
    button.render(canvas, position: buttonPosition, size: buttonSize);
  }

  @override
  void onTapDown(TapDownInfo event) {
    // On tap down we need to check if the event ocurred on the
    // button area. There are several ways of doing it, for this
    // tutorial we do that by transforming ours position and size
    // vectors into a dart:ui Rect by using the `&` operator, and
    // with that rect we can use its `contains` method which checks
    // if a point (Offset) is inside that rect
    final buttonArea = buttonPosition & buttonSize;

    isPressed = buttonArea.contains(event.eventPosition.game.toOffset());
  }

  // On both tap up and tap cancel we just set the isPressed
  // variable to false
  @override
  void onTapUp(TapUpInfo event) {
    isPressed = false;
  }

  @override
  void onTapCancel() {
    isPressed = false;
  }

  @override
  Color backgroundColor() => const Color(0xFF222222);
}