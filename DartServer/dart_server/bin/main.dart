import 'package:main/functions.dart';
import 'package:socket_io/socket_io.dart';

void main(List<String> arguments) async {
  var io = Server();
  var sockets = [];
  var readys = [];
  var players = []; //because i need pointer (so i can't use a int)
  int currentWave = 0;

  io.on('connection', (socket) async {
    print('A player is connected');
    socket.join('room');
    sockets.add(socket);

    sendLocalIp(socket);
    createEvents(io, sockets, socket, players, readys, currentWave);
  });

  //don't really work
  io.on('disconnect', (socket) async {
    sockets.remove(socket);
    readys.remove(0);
    players.remove(0);
  });

  io.listen(3000);
}

//Run with : dart run