import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'package:monster_must_die/widgets/networkmenu.dart';
import 'package:monster_must_die/widgets/rulemenu.dart';

// This represents the main menu overlay.
class MainMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'MainMenu';

  // Reference to parent game.
  final GameSetting gameRef;

  const MainMenu(this.gameRef, {Key? key}) : super(key: key);

  ///Cree le main menu avec differents widgets
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Monster must die',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(MainMenu.id);
                      gameRef.overlays.add(NetworkMenu.id);
                    },
                    child: Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(MainMenu.id);
                      gameRef.overlays.add(RuleMenu.id);
                    },
                    child: Text(
                      'Rules',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}