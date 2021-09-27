import 'package:monster_must_die/widgets/networkmenu.dart';
import 'games/gamesetting.dart';
import 'widgets/hud.dart';
import 'widgets/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:oktoast/oktoast.dart';

final myGame = GameSetting();

void main() {
  runApp(MyGameApp());
}

// The main widget for this game.
class MyGameApp extends StatelessWidget {
  static late BuildContext currentContext;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return OKToast(
        child: MaterialApp(
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
                MainMenu.id:(_,GameSetting gameRef) => MainMenu(gameRef),
                NetworkMenu.id:(_,GameSetting gameRef) => NetworkMenu(gameRef),
              },
              // By default MainMenu overlay will be active.
              initialActiveOverlays: [MainMenu.id],
              game: myGame,
            ),
          ),
        )
    );
  }
}