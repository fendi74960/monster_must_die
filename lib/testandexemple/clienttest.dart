import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:monster_must_die/controller/wavecontroller.dart';
import 'package:monster_must_die/games/gamesetting.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


void main() {
  final myGame = ClientTest();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

class ClientTest extends GameSetting with TapDetector { //Don't forget the TapDetecor !

  late Sprite pressedButton;
  late Sprite unpressedButton;
  final buttonPosition = Vector2(0, 0);
  final buttonSize = Vector2(120, 30);
  bool isPressed = false;
  late IO.Socket socket;

  void createSocket() {

    bool ipFound = false;
    int i = 2;

    //Faire fct
    while(i <= 255 && ipFound == false)
    {
      socket = IO.io('http://192.168.1.' + i.toString() + ':3000',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build());

      socket.on('fromServer', (msg) {
        ipFound = true;
        socket = IO.io('http://192.168.1.' + msg+ ':3000',
            OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'foo': 'bar'}) // optional
                .build());
        print("connected to 192.168.1." + msg);
        socket.emit('ready', 'true');
      });
      socket.on('create', (msg) {
        print('create');
        for(int i = 0; i < int.parse(msg); i++)
        {
          listUnit.add(UnitWidget.unitWidgetSpawn(size.x/2,size.y-40,0,images));
        }
      });
      socket.on('wave', (wave) {
        print('wave nb: ' + wave.toString());
        WaveController.newWave(wave, listEnemy, 20, size.x - 20, 20, size.y - 20, images);
      });
      i++;
    }
  }

  @override
  Future<void> onLoad() async {

    //create socket
    createSocket();

    await super.onLoad();

    unpressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2.zero(), // this is zero by default
      srcSize: Vector2(60, 20),
    );

    pressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
  }

  @override
  void render(Canvas canvas) {

    final button = isPressed ? pressedButton : unpressedButton;
    button.render(canvas, position: buttonPosition, size: buttonSize);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo event) {

    final buttonArea = buttonPosition & buttonSize;

    if(buttonArea.contains(event.eventPosition.game.toOffset()) && isPressed == false)
    {
      print("envoie");
      socket.emit('ready', 'true');
      //socket.emit('toall', '1');
      //socket.emit('toother', '1');
    }
    isPressed = buttonArea.contains(event.eventPosition.game.toOffset());
  }

  @override
  void onTapUp(TapUpInfo event) {
    isPressed = false;
  }

  @override
  void onTapCancel() {
    isPressed = false;
  }
}