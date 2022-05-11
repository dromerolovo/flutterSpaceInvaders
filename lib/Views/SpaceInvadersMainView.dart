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
  double animationStateValue = 0;
  String keyLabel = "";

  late AnimationController controllerAsync;
  late double animationStateValueAsync;

  late var animation = TweenSequence<double>(InvadersAnimationManager.getTweenRightMovement(-600, 500, 24)).animate(controller);
  late var animationAsync = Tween<double>(begin: -700, end: 700).animate(controllerAsync);


  @override
  void initState() {
    super.initState();
    controllerAsync = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000)
    );
    animationAsync
      .addListener(() {
        setState(() {
          print(animationAsync.value);
        });
      });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000 )
    );
    animation
      .addListener(() {
        setState(() {
          animationStateValue = animation.value;
        });
      });
    controller.forward();
    controllerAsync.forward();
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
                    painter : InvadersPaint(animationStateValue, animation, animationAsync.value)
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
  late Animation animation;
  late double animationStateValue;
  late double animationAsync;

  InvadersPaint(this.animationStateValue, this.animation, this.animationAsync) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
  
    Path testPath = Path();
    Paint paint = Paint();
  
    paint.color = Colors.greenAccent;
    testPath = InvadersConstruction.drawInvader(0, 670, "spaceShip");
    canvas.drawPath(testPath, paint);

    InvadersPositionManager.placeInvadersOnLine(canvas, animationStateValue + 6 + 2, 100, "squid", 58, Colors.purpleAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animationStateValue + 2, 144, "crab", 58, Colors.lightBlueAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animationStateValue + 2, 188, "crab", 58, Colors.lightBlueAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animationStateValue, 232, "octopus", 58, Colors.yellowAccent);
    InvadersPositionManager.placeInvadersOnLine(canvas, animationStateValue, 276, "octopus", 58, Colors.yellowAccent);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}






