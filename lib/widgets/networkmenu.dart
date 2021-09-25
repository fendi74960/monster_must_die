import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'hud.dart';

import 'package:numberpicker/numberpicker.dart';

class NetworkMenu extends StatefulWidget {
  // An unique identified for this overlay.
  static const id = 'Net';

  // Reference to parent game.
  final GameSetting gameRef;

  const NetworkMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  _NetworkMenu createState() => _NetworkMenu(this.gameRef);
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _NetworkMenu extends State<NetworkMenu> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  GameSetting gameRef;

  _NetworkMenu(this.gameRef);

  String str = "";

  int _currentValue = 3;

  IPField field1 = IPField(192);
  IPField field2 = IPField(168);
  IPField field3 = IPField(1);
  IPField field4 = IPField(105);

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
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
                              Text(
                                'Where is the server ?',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                ),
                              ),
                              Row(children: [
                                field1,
                                field2,
                                field3,
                                field4,
                                ElevatedButton(
                                  onPressed: () {
                                    gameRef.startGame();
                                    gameRef.socketFromIP(
                                        field1.val.toString() +
                                            '.' +
                                            field2.val.toString() +
                                            '.' +
                                            field3.val.toString() +
                                            '.' +
                                            field4.val.toString()
                                    );

                                    gameRef.overlays.remove(NetworkMenu.id);
                                    gameRef.overlays.add(Hud.id);
                                  },
                                  child: Text(
                                    'Connect',
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ]),
                              Row(children: [
                                Text(
                                  'If the server is on local network',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 32),
                                ElevatedButton(
                                  onPressed: () {
                                    gameRef.startGame();
                                    gameRef.unknowLocalIP();

                                    gameRef.overlays.remove(NetworkMenu.id);
                                    gameRef.overlays.add(Hud.id);
                                  },
                                  child: Text(
                                    'Auto-connect',
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ]),
                            ]))))));
  }
}

class IPField extends StatefulWidget {
  late int val;

  IPField(this.val, {Key? key}) : super(key: key);

  @override
  IPFieldState createState() => IPFieldState();
}

class IPFieldState extends State<IPField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          textStyle: TextStyle(color: Colors.grey),
          selectedTextStyle: TextStyle(color: Colors.white),
          value: widget.val,
          minValue: 0,
          maxValue: 255,
          onChanged: (value) => setState(() => widget.val = value),
        ),
      ],
    );
  }
}
