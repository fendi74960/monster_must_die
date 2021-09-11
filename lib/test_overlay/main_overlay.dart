import 'game_overlay.dart';
import 'hud_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

final myGame = MyGame();

void main() {



  runApp(MyGameApp());
}

// The main widget for this game.
class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dino Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Settings up some default theme for elevated buttons.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget(
          // This will dislpay a loading bar until [DinoRun] completes
          // its onLoad method.
          loadingBuilder: (conetxt) => Center(
            child: Container(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
          // Register all the overlays that will be used by this game.
          overlayBuilderMap: {
            Hud.id: (_, MyGame gameRef) => Hud(gameRef),
          },
          // By default MainMenu overlay will be active.
          initialActiveOverlays: [Hud.id],
          game: myGame,
        ),
      ),
    );
  }
}