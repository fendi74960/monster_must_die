import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';


void main() async {
  final dashbook = Dashbook(
    title: 'Flame Examples',
    theme: ThemeData.dark(),
  );


  addWidgetsStories(dashbook);

  runApp(dashbook);
}
void addWidgetsStories(Dashbook dashbook) {
  dashbook.storiesOf('Widgets')
    ..decorator(CenterDecorator())

    ..add(
      'Overlay',
      overlayBuilder,
    );
}

Widget overlayBuilder(DashbookContext ctx) {
  return const OverlayExampleWidget();
}

class OverlayExampleWidget extends StatefulWidget {
  const OverlayExampleWidget({Key? key}) : super(key: key);

  @override
  _OverlayExampleWidgetState createState() => _OverlayExampleWidgetState();
}

class _OverlayExampleWidgetState extends State<OverlayExampleWidget> {
  ExampleGame? _myGame;

  Widget pauseMenuBuilder(BuildContext buildContext, ExampleGame game) {
    return Center(
      child: GestureDetector(
        onTap:(){game.chiffre=2;},
        child:Container(width: 100,
          height: 100,
          color: const Color(0xFFFF0000),
          child: const Center(
            child: Text('Paused'),
          ),)

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myGame = _myGame;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing addingOverlay'),
      ),
      body: myGame == null
          ? const Text('Wait')
          : GameWidget<ExampleGame>(
        game: myGame,
        overlayBuilderMap: {
          'PauseMenu': pauseMenuBuilder,
        },
        initialActiveOverlays: const ['PauseMenu'],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newGame,
        child: const Icon(Icons.add),
      ),

    );

  }

  void newGame() {
    setState(() {
      _myGame = ExampleGame();
      print('New game created');
    });
  }
}

class ExampleGame extends Game with TapDetector {
  @override
  void update(double dt) {}
  int chiffre=0;
  @override
  Future<void> onLoad() async {
    print('game loaded');
    chiffre=1;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(100, 100, 100, 100),
      Paint()..color = BasicPalette.white.color,
    );
    print(chiffre);
  }

  @override
  void onTap() {
    if (overlays.isActive('PauseMenu')) {
      overlays.remove('PauseMenu');
    } else {
      overlays.add('PauseMenu');
    }
  }
}