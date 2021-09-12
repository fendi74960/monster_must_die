import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_overlay.dart';
import 'player_data.dart';


// This represents the head up display in game.
// It consists of, current score, high score,
// a pause button and number of remaining lives.
class Hud extends StatelessWidget {

  // An unique identified for this overlay.
  static const id = 'Hud';

  // Reference to parent game.
  final MyGame gameRef;

  const Hud(this.gameRef, {Key? key}) : super(key: key);

  static const List<String> suggestions = ['hello', 'world'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0,left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.waves,
                  builder: (_, waves, __) {
                    return Text(
                      'Waves: $waves',
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.lives,
                  builder: (_, lives, __) {
                    return Row(
                      children: List.generate(5, (index) {
                        if (index < lives) {
                          return Icon(
                            Icons.favorite,
                            color: Colors.red,
                          );
                        } else {
                          return Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          );
                        }
                      }),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.pointsPerso,
                  builder: (_, pointsPerso, __) {
                    return Text(
                      'pointsPerso: $pointsPerso',
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.pointsCoop,
                  builder: (_, pointsCoop, __) {
                    return Text(
                      'pointsCoop: $pointsCoop',
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/*
            Column(
              children: [
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.currentScore,
                  builder: (_, score, __) {
                    return Text(
                      'Score: $score',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.highScore,
                  builder: (_, highScore, __) {
                    return Text(
                      'High: $highScore',
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ],
            ),

            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.waves,
              builder: (_, waves, __) {
                return Row(
                  children: List.generate(5, (index) {
                    if (index < waves) {
                      return const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      );
                    } else {
                      return const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      );
                    }
                  }),
                );
              },
            )

 */