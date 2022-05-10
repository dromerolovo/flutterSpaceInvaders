import 'package:croco/SpaceInvaders/InvadersPositionManager.dart';
import '../SpaceInvaders/InvadersConstruction.dart';
import 'package:flutter/material.dart';
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

  late AnimationController controller;
  late Animation<double> rightMovementAnimation;
  String keyLabel = "";



  late var animation = TweenSequence<double>(InvadersAnimationManager.getTweenRightMovement(-600, 500, 24)).animate(controller);


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000 )
    );
    animation
      .addListener(() {
        setState(() {
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        keyLabel = event.logicalKey.keyLabel;
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
            Stack(
                children: <Widget>[
                  CustomPaint(
                    painter : InvadersPaint(animation)
                  ),
                ],
            )
          ])
        )
      ),
    );
  }
}


class InvadersPaint extends CustomPainter {

  Paint basicSquarePaint = Paint();
  Path originPath = Path();
  Animation animation;

  InvadersPaint(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {

    Path testPath = Path();
    Paint paint = Paint();
  
    paint.color = Colors.greenAccent;
    testPath = InvadersConstruction.drawInvader(-68, 670, "spaceShip");
    canvas.drawPath(testPath, paint);

    InvadersPositionManager.placeInvadersOnLine(canvas, animation.value + 6 + 2, 100, "squid", 58, Colors.purpleAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animation.value + 2, 144, "crab", 58, Colors.lightBlueAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animation.value + 2, 188, "crab", 58, Colors.lightBlueAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animation.value, 232, "octopus", 58, Colors.yellowAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animation.value, 276, "octopus", 58, Colors.yellowAccent);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}






