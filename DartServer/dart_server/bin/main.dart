import 'dart:io';

import 'package:main/functions.dart';
import 'package:socket_io/socket_io.dart';

void main(List<String> arguments) async {
  var io = Server();

  io.on('connection', (client) async {
    print('connected');

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
    client.emit('fromServer', val); //On envoie la fin de l'ip local

    //Event:
    client.on('msg', (data) {
      print('data from default => $data');
      client.emit('fromServer', "ok");
    });
    client.on('toother', (data) {
      io.clients((cl) {
        if (client != cl) {
          cl.emit('fromServer', "ok");
        }
      });
    });
    client.on('toall', (data) {
      io.clients((cl) {
        cl.emit('fromServer', "ok");
      });
    });
  });
  io.listen(3000);
}

//Web socket exemple :
/*
  var nsp = io.of('/some');
  nsp.on('connection', (client) {
    client.on('msg', (data) {
      print('data from /some => $data');
      client.emit('fromServer', "ok 2");
    });
  });
*/

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