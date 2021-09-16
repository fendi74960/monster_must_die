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

    createEvents(io, sockets, socket, readys, currentWave);
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