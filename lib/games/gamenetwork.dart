import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monster_must_die/controller/wavecontroller.dart';
import 'package:monster_must_die/games/gameloader.dart';
import 'package:monster_must_die/models/enemy.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:oktoast/oktoast.dart';


class GameNetwork extends GameLoader {

  late IO.Socket socket;
  bool socketCreated = false;
  bool waveFinished = true;

  //It's the default type of unit that the player will have
  int playerType = 0;

  ///If the server is on local network and we don't want to write the IP
  /// it try all the adress, then the server send the right number
  /// and it add few events to the socket
  void unknowLocalIP() {
    bool ipFound = false;
    int i = 2;

    while(i <= 254 && ipFound == false)
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
        createCommonEvents(socket);
      });
      i++;
    }
  }

  ///If we know the IP of the server,
  /// we connect directly to it and create few events
  void socketFromIP(String adress) {
    socket = IO.io('http://' + adress + ':3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.on('fromServer', (msg) {
      print("connected");
      createCommonEvents(socket);
    });
  }

  ///Used when we have created the socket
  /// it add the events to the socket
  void createCommonEvents(IO.Socket socket) {
    unitEvent(socket);
    helpEvent(socket);
    createEvent(socket);
    waveEvent(socket);
    socket.emit('wait', 'true');
  }

  ///If the server send a 'create' event,
  /// then we add the good number and type of units
  /// msg.id type of enemy
  /// msg.nb number of enemy
  void createEvent(IO.Socket socket) {
    socket.on('create', (msg) {
      showToast('Your comrades are here !', position: ToastPosition.top, textStyle: TextStyle(color: Colors.white, fontSize: 30), backgroundColor: Colors.blue);
      var rng = Random();
      for(int i = 0; i < int.parse(msg['nb']); i++)
      {
        if(int.parse(msg['id'])>=16){
          startSpell(int.parse(msg['id'])-16); // convert to the spell number
        } else {
          double randomX = rng.nextInt(size.x.toInt()).toDouble();
          listUnit.add(UnitWidget.unitWidgetSpawn(randomX, size.y-40, int.parse(msg['id']), images, null, playerType));
        }
      }
    });
  }

  ///If the server send a 'help' event,
  /// it launch the toast with a enemy name (maybe the sprite in the futur)
  void helpEvent(IO.Socket socket) {
    socket.on('help', (msg) {
      showToast('Your comrade need help\n to kill a ' + Enemy.TypeToName(msg.round()), position: ToastPosition.top, textStyle: TextStyle(color: Colors.white, fontSize: 30), backgroundColor: Colors.red);
    });
  }

  ///Send a 'helptoother' to the server
  void sendHelp(int type) {
    socket.emit("helptoother", type);
  }

  ///If the server send a 'wave' event,
  /// it launch the wave of enemy !
  void waveEvent(IO.Socket socket) {
    socket.on('wave', (wave) async {
      listUnit.clear();
      print('wave number: ' + wave.toString());
      await WaveController.newWave(wave.round(), listEnemy, 0.toDouble(), size.x*0.8 , 0, size.y/3, images,playerData);
      waveFinished = false;
    });
  }

  ///If the server send a 'unit' event,
  /// it change the unit of the player
  void unitEvent(IO.Socket socket) {
    socket.on('unit', (type) {
      if(type == 1) {
        playerType = 1;
      }
      socketCreated = true;
    });
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    //Check if the wave is (localy) finished
    if(!waveFinished && listEnemy.length == 0) {
      waveFinished = true;
      socket.emit('ready', 'true');
    }
  }
}