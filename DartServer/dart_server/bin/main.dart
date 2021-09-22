import 'package:main/functions.dart';
import 'package:socket_io/socket_io.dart';

void main(List<String> arguments) async {
  var io = Server();
  var sockets = [];
  var readys = [];
  int currentWave = 0;

  io.on('connection', (socket) async {
    print('A player is connected');
    socket.join('room');
    sockets.add(socket);

    sendLocalIp(socket);
    setUnit(socket, readys);                      //peut etre await, check !!!!!!!!!!!!!!
    createEvents(io, sockets, socket, readys, currentWave);
  });

  io.on('disconnect', (socket) async {
    sockets.remove(socket);
  });

  io.listen(3000);
}

//Run with : dart run