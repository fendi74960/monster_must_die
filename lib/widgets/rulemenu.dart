import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'package:monster_must_die/widgets/main_menu.dart';

class RuleMenu extends StatefulWidget {
  // An unique identified for this overlay.
  static const id = 'Rule';

  // Reference to parent game.
  final GameSetting gameRef;

  const RuleMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  _RuleMenu createState() => _RuleMenu(this.gameRef);
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _RuleMenu extends State<RuleMenu> {
  GameSetting gameRef;

  _RuleMenu(this.gameRef);

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
                        child: Container(
                          child: Column(children: [
                            ElevatedButton(
                              onPressed: () {
                                gameRef.overlays.remove(RuleMenu.id);
                                gameRef.overlays.add(MainMenu.id);
                              },
                              child: Text(
                                'Go back',
                                style: TextStyle(
                                  fontSize: textSizeDefault * 50,
                                ),
                              ),
                            ),
                            Container(
                              child: ListView(children: [
                                Text(
                                  RuleText.getTextEN(),
                                  style: TextStyle(
                                    fontSize: textSizeDefault * 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ]),
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                        ))))));
  }
}

class RuleText {
  static String getTextEN() {
    return "\nWelcome adventurer!\nCome with us to pass this test.\nYou are going to face an army of monsters, each with their own speciality.\nFortunately, you and your teammate have the possibility to call units or to cast spells. Be careful, this uses score points.\nBut some types of enemies are resistant, or even invulnerable to your abilities, so ask your ally for help (either by speaking directly or by clicking on an enemy).\nTo learn more about these monsters, you can consult the bestiary (after logging in).\nThe goal of this game is to survive the waves of enemies as long as possible.\nTo play this game you need a Dart server (Socket IO) that runs on the port 3000 preferably locally to be able to use the \"Auto-connect\" button.\nPS : the function to track what the players are doing requires that the players are under android.";
  }

  static String getTextFR() {
    return "\nBienvenu aventurier!\nViens accompagné pour réussir cette épreuve.\nVous allez faire face a une armée de monstre, qui ont chacun leur spécialité.\nHeureusement, toi et ton coéquipier, vous avez la possibilité d’appeler des unités ou encore de jeter des sorts. Attention cela utilise des points de score.\nMais certain type d’ennemies sont résistants, voire invulnérable face a tes capacités, donc demande de l’aide à ton allié (soit directement a l’oral, soit en cliquant sur un ennemi).\nPour en apprendre plus sur ces monstres, vous pouvez consulter le bestiaire (après vous être connecté).\nLe but de ce jeu est de survivre le plus longtemps aux vagues d’ennemies.\nPour fonctionner ce jeu nécessite un serveur Dart (Socket IO) qui fonctionne sur le port 3000 en local de préférence pour pouvoir utiliser le bouton \"Auto-connect\".\nPS : la fonction pour traquer ce que les joueurs font nécessite à ce que les joueurs soit sous android.";
  }
}
