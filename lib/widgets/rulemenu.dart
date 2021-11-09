import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monster_must_die/controller/bestiarycontroller.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'package:monster_must_die/widgets/hud.dart';
import 'package:provider/provider.dart';

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
                          child: ListView(
                              children: [
                                Text(
                                  RuleText.getText(),
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  RuleText.getText(),
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ]
                          ),
                            height: MediaQuery.of(context).size.height* 0.7,
                            width: MediaQuery.of(context).size.width,
                              )
                            )
                        )
                    )));
  }
}

class RuleText {
  static String getText() {
    return " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis posuere odio non viverra. Ut euismod leo pretium metus scelerisque, id vestibulum nulla malesuada. Duis iaculis aliquam lacus, tincidunt porta lorem ultrices mattis. Nullam ultricies vel sem ut pretium. Praesent eu sapien lectus. Nulla ultricies suscipit turpis, nec imperdiet velit lacinia vel. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce quis varius enim. Donec orci justo, porttitor non neque vitae, blandit ornare mi. Vivamus ut ipsum congue, malesuada arcu vel, congue dui.     Integer blandit pellentesque est et convallis. Donec luctus ac sem sed finibus. Nullam interdum nibh quam, vel porta ipsum molestie quis. Proin non malesuada sapien, in feugiat ligula. Pellentesque pretium, urna id euismod euismod, eros magna ultricies leo, at semper nisi erat eget lectus. Aenean ut fringilla urna. Nulla consectetur, nibh sit amet dignissim aliquet, risus nibh mollis neque, ut pharetra nibh turpis nec sapien. Sed tempus erat et turpis elementum, vitae efficitur metus pulvinar. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; In eu sapien ac ligula vulputate lobortis nec et lectus. Cras blandit velit eu quam dignissim, mollis lacinia lorem tincidunt.";
  }
}