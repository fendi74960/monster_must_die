import 'dart:io';
import 'package:socket_io/socket_io.dart';

void sendLocalIp(socket) async {
  //Used if the client don't know the local IP of the server
  //He send a request on every ip
  //Then the server send him the end of the server local IP

  var myLocalIp = "";
  RegExp regExp = new RegExp(r"^192\.168\.1\..");

  for (var interface in await NetworkInterface.list()) {
    for (var addr in interface.addresses) {
      if (regExp.hasMatch(addr.address)) {
        myLocalIp = addr.address;
        break;
      }
    }
  }

  var val = "";
  for (int i = 10; i < myLocalIp.length; i++) {
    val += myLocalIp[i];
  }
  socket.emit('fromServer', val);
}

void createEvents(io, sockets, socket, readys, currentWave) async {
  //Create all the events used for the server

  toOtherEvent(sockets, socket);
  toAllEvent(io, socket);
}

void toOtherEvent(sockets, socket) async {
  //We call this event if one of the client
  // want to send unit to the other client

  socket.on('toother', (data) {
    print('toother');
    for (int i = 0; i < sockets.length; i++) {
      if (socket != sockets[i]) {
        print('--- only : 1 ---');
        sockets[i].emit('create', data);
      }
    }
  });
}

void toAllEvent(io, socket) async {
  //We call this event if one of the client
  // want to send unit to all the clients

  socket.on('toall', (data) {
    print('toall');
    io.to("room1").emit('create', data);
  });
}

void readyEvent(socket, readys) async {
  //Set one player as ready
  // to lauch a wave or other things

  socket.on('ready', (data) {
    print('One player is ready');
    readys.add(true);
  });
}

bool checkReady(readys) {
  //mettre wave++ quand appelé
  if (readys.length >= 2) {
    return true;
  }
  return false;
}

void startWave(io, currentWave) async {
  switch (currentWave) {
    case 1:
      {
        io.to("room1").emit('create', 30);
      }
      break;

    case 2:
      {
        io.to("room1").emit('create', 40);
      }
      break;

    case 3:
      {
        io.to("room1").emit('create', 50);
      }
      break;

    default:
      {
        io.to("room1").emit('create', 30);
      }
      break;
  }
}
