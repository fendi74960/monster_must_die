import 'package:flutter/material.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'package:monster_must_die/games/gamebuttons.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';
import 'package:provider/provider.dart';
import 'package:monster_must_die/models/player_data.dart';

class Hud extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'Hud';

  // Reference to parent game.
  final GameSetting gameRef;

  const Hud(this.gameRef, {Key? key}) : super(key: key);

  ///Build l'hud du jeu
  ///Il est build avec ChangeNotifierProvider qui permet à certaines valeur de changer automatiquement si elles sont changer ailleurs et notifier
  ///le build ici consiste a une colonne avec une ligne situé tout en bas avec des textes
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ChangeNotifierProvider.value(
              value: gameRef.buttonData,
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        //When we click on send, it :
                        // check if the thread is launched (if no, it launch it)
                        // The player has few seconds to select what he want to send
                        // check if the player has enough points
                        // add the unit or the spell to the arrayToSend
                        // increment numberToSend
                        if(gameRef.threadStarted == false)
                        {
                          gameRef.sendThread();
                          gameRef.threadStarted = true;
                        }

                        //Check if it's a spell or a unit
                        if(gameRef.selectedButton >= 16 && !gameRef.sortDejaSent) {
                          if(gameRef.howMuchItCostSpell(gameRef.selectedButton-16) <= gameRef.playerData.pointsCoop) {
                            gameRef.sortDejaSent=true;
                            gameRef.buttonData.numberToSend++;
                            gameRef.playerData.pointsCoop-=gameRef.howMuchItCostSpell(gameRef.selectedButton-16);
                            if (gameRef.selectedButton == gameRef.firstSpellButtonType) {
                              gameRef.arrayToSend[4]++;
                            } else {
                              gameRef.arrayToSend[5]++;
                            }
                          }
                        } else {
                          if (UnitWidget.howMuchItCost(gameRef.selectedButton) <
                              gameRef.playerData.pointsCoop) {
                            gameRef.buttonData.numberToSend++;
                            gameRef.playerData.pointsCoop -=
                                UnitWidget.howMuchItCost(gameRef.selectedButton);
                            if (gameRef.selectedButton ==
                                gameRef.firstButtonUnitType) {
                              gameRef.arrayToSend[0]++;
                            } else if (gameRef.selectedButton ==
                                gameRef.secondButtonUnitType) {
                              gameRef.arrayToSend[1]++;
                            } else if (gameRef.selectedButton ==
                                gameRef.thirdButtonUnitType) {
                              gameRef.arrayToSend[2]++;
                            } else {
                              gameRef.arrayToSend[3]++;
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                      child: Row(
                        children: [
                          Selector<ButtonData, int>(
                            selector: (_, buttonData) =>
                            buttonData.numberToSend,
                            builder: (_, numberToSend, __) {
                              return Container(
                                width: MediaQuery.of(context).size.height * 0.1,
                                child: Text(
                                  'Send $numberToSend units',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              );
                            },
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          ChangeNotifierProvider.value(
            value: gameRef.playerData,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 15.0),
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
                          return Expanded(
                              child: Text(
                                'Wave: $waves',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ));
                        },
                      ),
                      Selector<PlayerData, int>(
                        selector: (_, playerData) => playerData.lives,
                        builder: (_, lives, __) {
                          return Expanded(
                              child: Text(
                                'Lives: $lives',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ));
                        },
                      ),
                      Selector<PlayerData, int>(
                        selector: (_, playerData) => playerData.pointsPerso,
                        builder: (_, pointsPerso, __) {
                          return Expanded(
                            child: Text(
                              'Score: $pointsPerso',
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          );
                        },
                      ),
                      Selector<PlayerData, int>(
                        selector: (_, playerData) => playerData.pointsCoop,
                        builder: (_, pointsCoop, __) {
                          return Expanded(
                            child: Text(
                              'Coop score: $pointsCoop',
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]);
  }
}
