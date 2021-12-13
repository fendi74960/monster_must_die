import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monster_must_die/controller/bestiarycontroller.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'package:monster_must_die/widgets/hud.dart';
import 'package:provider/provider.dart';

class WaitingMenu extends StatefulWidget {
  // An unique identified for this overlay.
  static const id = 'Wait';

  // Reference to parent game.
  final GameSetting gameRef;

  const WaitingMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  _WaitingMenu createState() => _WaitingMenu(this.gameRef);
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _WaitingMenu extends State<WaitingMenu> {
  GameSetting gameRef;

  _WaitingMenu(this.gameRef);

  late double textSizeDefault;

  @override
  Widget build(BuildContext context) {
    textSizeDefault = MediaQuery.of(context).textScaleFactor;
    return Center(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.black.withAlpha(100),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 100),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChangeNotifierProvider.value(
                                  value: gameRef.informationData,
                                  child: Column(children: [
                                    Selector<InformationData, String>(
                                      selector: (_, inforamationData) =>
                                      inforamationData
                                          .enemieInformation.name,
                                      builder: (_, name, __) {
                                        return Container(
                                            child: Text(
                                              '$name',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ));
                                      },
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            if(--gameRef.currentBestiaryIndex < 0)
                                              gameRef.currentBestiaryIndex = gameRef.bController.liste.length - 1;
                                            gameRef.informationData.enemieInformation = gameRef.bController.getEnemieInformation(gameRef.currentBestiaryIndex);
                                          },
                                          child: Text(
                                            'Before',
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                        Selector<InformationData, String>(
                                          selector: (_, inforamationData) =>
                                          inforamationData
                                              .enemieInformation.picture,
                                          builder: (_, picture, __) {
                                            return Image.asset(
                                              picture,
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              height: MediaQuery.of(context).size.width * 0.4,
                                              fit: BoxFit.fitWidth,
                                            );
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if(++gameRef.currentBestiaryIndex > gameRef.bController.liste.length - 1)
                                              gameRef.currentBestiaryIndex = 0;
                                            gameRef.informationData.enemieInformation = gameRef.bController.getEnemieInformation(gameRef.currentBestiaryIndex);
                                          },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Selector<InformationData, String>(
                                      selector: (_, inforamationData) =>
                                      inforamationData
                                          .enemieInformation.description,
                                      builder: (_, description, __) {
                                        return Container(
                                          //width: MediaQuery.of(context).size.height * 0.1,
                                            child: Text(
                                              '$description',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ));
                                      },
                                    ),
                                    Selector<InformationData, String>(
                                      selector: (_, inforamationData) =>
                                      inforamationData
                                          .enemieInformation.pros,
                                      builder: (_, pros, __) {
                                        return Container(
                                          //width: MediaQuery.of(context).size.height * 0.1,
                                            child: Text(
                                              '$pros',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ));
                                      },
                                    ),
                                    Selector<InformationData, String>(
                                      selector: (_, inforamationData) =>
                                      inforamationData
                                          .enemieInformation.cons,
                                      builder: (_, cons, __) {
                                        return Container(
                                          //width: MediaQuery.of(context).size.height * 0.1,
                                            child: Text(
                                              '$cons',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ));
                                      },
                                    ),
                                  ])),
                              SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: () async {
                                  ///The user click on "Ready",
                                  /// it start the game,
                                  /// change the unit of the user
                                  /// and emit a ready event
                                  /// (we need to ready to start the game),
                                  /// then the user go to the Hud menu

                                  gameRef.startGame();
                                  gameRef.setUnitType();

                                  gameRef.socket.emit('ready', 'true');
                                  //When the two player will be ready, then the wave start (server side)

                                  gameRef.overlays.remove(WaitingMenu.id);
                                  gameRef.overlays.add(Hud.id);
                                },
                                child: Text(
                                  'Ready',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ])
                    )))));
  }
}