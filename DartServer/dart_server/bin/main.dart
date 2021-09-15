import 'dart:io';

import 'package:main/functions.dart';
import 'package:socket_io/socket_io.dart';

void main(List<String> arguments) async {
  var io = Server();
  var sockets = [];

  io.on('connection', (socket) async {
    print('A player is connected');

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

    socket.join('room1');
    sockets.add(socket);

    //Event:
    socket.on('msg', (data) {
      print('data from default => $data');
      socket.emit('fromServer', "ok");
    });
    socket.on('toother', (data) {
      print('toother');
      for (int i = 0; i < sockets.length; i++) {
        if (socket != sockets[i]) {
          print('--- only : 1 ---');
          sockets[i].emit('create', data);
        }
      }
    });
    socket.on('toall', (data) {
      print('toall');
      for (int i = 0; i < sockets.length; i++) {
        print('--- 1 ---');
        sockets[i].emit('create', data);
      }
      //io.to("room1").emit('create', data); //to retry
    });
  });

  io.on('disconnect', (socket) async {
    sockets.remove(socket);
  });

  io.listen(3000);
}

//Run with : dart run

/* old main
void main(List<String> arguments) {
  var io = new Server();
  var nsp = io.of('/some');
  nsp.on('connection', (client) {
    print('connection /some');
    client.on('msg', (data) {
      print('data from /some => $data');
      client.emit('fromServer', "ok 2");
    });
  });
  io.on('connection', (client) {
    print('connection default namespace');
    client.on('msg', (data) {
      print('data from default => $data');
      client.emit('fromServer', "ok");
    });
  });
  io.listen(3000);
}
*/