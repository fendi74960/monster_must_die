import 'games/gamesetting.dart';
import 'widgets/hud.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';


final myGame = GameSetting();

void main() {
  runApp(MyGameApp());
}

// The main widget for this game.
class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monster must die',

      home: Scaffold(
        body: GameWidget(
          // This will display a loading bar
          // its onLoad method.
          loadingBuilder: (context) => Center(
            child: Container(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
          // Register all the overlays that will be used by this game.
          overlayBuilderMap: {
            Hud.id: (_, GameSetting gameRef) => Hud(gameRef),
          },
          // By default MainMenu overlay will be active.
          initialActiveOverlays: [Hud.id],
          game: myGame,
        ),
      ),
    );
  }
}