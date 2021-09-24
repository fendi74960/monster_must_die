import 'dart:io';

void sendLocalIp(socket) async {
  ///Used if the client don't know the local IP of the server
  ///He send a request on every ip
  ///Then the server send him the end of the server local IP

  var myLocalIp = "";
  RegExp regExp = RegExp(r"^192\.168\.1\..");

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

void createEvents(io, sockets, socket, readys, int currentWave) async {
  ///Create all the events used for the server

  toOtherEvent(sockets, socket);
  toAllEvent(io, socket);
  readyEvent(io, socket, readys, currentWave);
}

void toOtherEvent(sockets, socket) async {
  ///We call this event if one of the client
  /// want to send unit to the other client

  socket.on('toother', (data) {
    print('Receive toother');
    for (int i = 0; i < sockets.length; i++) {
      if (socket != sockets[i]) {
        sockets[i].emit('create', data);
      }
    }
  });
}

void toAllEvent(io, socket) async {
  ///We call this event if one of the client
  /// want to send unit to all the clients

  socket.on('toall', (data) {
    print('Receive toall');
    io.to("room").emit('create', data);
  });
}

void readyEvent(io, socket, readys, int currentWave) async {
  ///Set one player as ready
  /// to lauch a wave or other things

  socket.on('ready', (data) {
    print('One player is ready');
    readys.add(true);
    if (currentWave == 0) {
      setUnit(socket, readys);
    }

    if (checkReady(readys)) {
      print("Create a new wave");
      currentWave++;
      io.to("room").emit('wave', currentWave);
      readys.clear();
    }
  });
}

void setUnit(socket, readys) async {
  ///The first player will have few units,
  /// and the second player the other units

  print("Setting the unit");
  if (readys.length == 2) {
    print("envoie 1");
    socket.emit('unit', 1);
  }
}

bool checkReady(readys) {
  ///Check if the two players are ready

  if (readys.length >= 2) {
    return true;
  }
  return false;
}
