import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';

void main() {

  final myGame = MyGame();

  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

class MyGame extends BaseGame {
  // A constant speed, represented in logical pixels per second
  static const int squareSpeed = 400;

  // To represent our square we are using the Rect class from dart:ui
  // which is a handy class to represent this type of data. We will be
  // seeing other types of data classes in the future, but for this
  // example, Rect will do fine for us.
  late Rect squarePos;

  // To represent our direction, we will be using an int value, where 1 means
  // going to the right, and -1 going to the left, this may seems like a too much
  // simple way of representing a direction, and indeed it is, but this will
  // will work fine for our small example and will make more sense when we implement
  // the update method
  int squareDirection = 1;

  // The onLoad method is where all of the game initialization is supposed to go
  // For this example, you may think that this square could just be initialized on the field
  // declaration, and you are right, but for learning purposes and to present the life cycle method
  // for this example we will be initializing this field here.
  @override
  Future<void> onLoad() async {
    Flame.device.fullScreen();
    squarePos = const Rect.fromLTWH(-20, -50, 100, 100);
  }
  // BasicPalette is a help class from Flame, which provides default, pre-built instances
  // of Paint that can be used by your game
  static final squarePaint = BasicPalette.white.paint;

  @override
  void update(double dt) {

    // Here we move our square by calculating our movement using
    // the iteration delta time and our speed variable and direction.
    // Note that the Rect class is immutable and the translate method returns a new Rect instance
    // for us, so we just re-assign it to our square variable.
    //
    // It is important to remember that the result of the execution of this method,
    // must be the game state (in our case our rect, speed and direction variables) updated to be
    // consistent of how it should be after the amount of time stored on the dt variable,
    // that way your game will always run smooth and consistent even when a FPS drop or peak happen.
    //
    // To illustrate this, if our square moves at 200 logical pixels per second, and half a second
    // has passed, our square should have moved 100 logical pixels on this iteration
    squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);

    // This simple condition verifies if the square is going right, and has reached the end of the
    // screen and if so, we invert the direction.
    //
    // Note here that we have used the variable size, which is a variable provided
    // by the Game class which contains the size in logical pixels that the game is currently using.
    if (squareDirection == 1 && squarePos.right > size.x) {
      squareDirection = -1;
      // This does the same, but now checking the left direction
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
    }
  }




  @override
  void render(Canvas canvas) {
    // Canvas is a class from dart:ui and is it responsible for all the rendering inside of Flame
    canvas.drawRect(squarePos, squarePaint());
  }
}

