import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import '../SpaceInvaders/InvadersAnimationManager.dart';


class SpaceInvadersMainView extends StatelessWidget {
  const SpaceInvadersMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'Space Invaders',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Segoe UI',
        primarySwatch: Colors.lightBlue,
      ),
      home: SpaceCanvas(),
    );
  }
}

class SpaceCanvas extends StatefulWidget {
  SpaceCanvas({Key? key}) : super(key: key);

  @override
  State<SpaceCanvas> createState() => _SpaceCanvasState();
}

class _SpaceCanvasState extends State<SpaceCanvas> with TickerProviderStateMixin {
  late Ticker ticker;
  late ui.Image sprite; 
  final notifier = ValueNotifier(Duration.zero);
  late var keyLabel = "";
  double spaceShipMovementState = 0;
  late double number = 0;

  @override
  void initState() {
    super.initState();
    ticker = Ticker(tick);

    rootBundle.load('assets/invaders.png')
    .then((data) => decodeImageFromList(data.buffer.asUint8List()))
    .then((data) => setSprite(data));
  }

  @override
  void dispose() {
    super.dispose();
  }

  tick(Duration d ) => notifier.value = d;

  setSprite(ui.Image image) {
    setState(() {
      sprite = image;
      ticker.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        keyLabel = event.logicalKey.keyLabel;
        print(keyLabel);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Welcome to space Invaders!',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                    color: Colors.white70
                  )
                  ),
              ),
            ),
              Container(
                child: (
                  CustomPaint(
                    foregroundPainter : InvadersPaint(sprite, notifier, keyLabel, spaceShipMovementState),
                    child: Center()
                  )
                ),
              ),
          ])
        )
      ),
    );
  }
}


class InvadersPaint extends CustomPainter {

  late ui.Image sprite;
  final ValueNotifier<Duration> notifier;
  late var keyLabel;
  late double spaceShipMovementState;

  InvadersPaint(this.sprite, this.notifier, this.keyLabel, this.spaceShipMovementState) : super(repaint: notifier);

  @override
  void paint(Canvas canvas, Size size) {

    InvadersAnimationManager.keyLabelValuesToState(keyLabel, spaceShipMovementState);
    print(spaceShipMovementState);

    // canvas.clipRect(Offset.zero & size);
    if (sprite != null) {
      InvadersAnimationManager.getAnimation(sprite, notifier, size, canvas, spaceShipMovementState, keyLabel);
      keyLabel != "" ? () => print(keyLabel) : null;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}






