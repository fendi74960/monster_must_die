import 'package:flutter/material.dart';
import 'package:monster_must_die/controller/wavecontroller.dart';
import 'package:monster_must_die/games/gameloader.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class GameNetwork extends GameLoader {

  late IO.Socket socket;

  void createSocket() {
    //We can choose here if we connect directly to an IP adress
    //socketFromIP("192.168.1.105");

    //Or if the server is in the local network
    // we found the IP
    unknowLocalIP();
  }

  void unknowLocalIP() {
    bool ipFound = false;
    int i = 254;

    while(i >= 2 && ipFound == false)
    {
      socket = IO.io('http://192.168.1.' + i.toString() + ':3000',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build());

      socket.on('fromServer', (msg) {
        ipFound = true;
        socket = IO.io('http://192.168.1.' + msg+ ':3000',
            IO.OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'foo': 'bar'}) // optional
                .build());
        print("connected to 192.168.1." + msg);
        socket.emit('ready', 'true');
      });
      createEvent(socket);
      waveEvent(socket);
      i--;
    }
  }

  void socketFromIP(String adress) {
    socket = IO.io('http://' + adress + ':3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.on('fromServer', (msg) {
      socket = IO.io('http://192.168.1.' + msg+ ':3000',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build());
      print("connected");
      socket.emit('ready', 'true');
    });
    createEvent(socket);
    waveEvent(socket);
  }

  void createEvent(IO.Socket socket) {
    socket.on('create', (msg) {
      print('create ennemies');
      for(int i = 0; i < int.parse(msg); i++)
      {
        listUnit.add(UnitWidget.unitWidgetSpawn(size.x/2,size.y-40,0,images));
      }
    });
  }

  void waveEvent(IO.Socket socket) {
    socket.on('wave', (wave) {
      print('wave number: ' + wave.toString());
      WaveController.newWave(wave.round(), listEnemy, 20.toDouble(), size.x - 20.toDouble(), 20.toDouble(), size.y - 20.toDouble(), images);
    });
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //create the socket
    createSocket();           //maybe call it in the main or gamesetting
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}