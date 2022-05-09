import 'dart:html';
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

class _SpaceCanvasState extends State<SpaceCanvas> with SingleTickerProviderStateMixin {

  late AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000 )
  );
  late Animation<double> rightMovementAnimation;
  late double globalMovementCounter = 0;

  Tween<double> rightMovementTween = Tween<double>(
    begin: -700,
    end: 700
  );

  late var animation = TweenSequence<double>(InvadersAnimationManager.getTweenRightMovement(-700, 700, 24)).animate(controller);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30000 )
      
    );
    animation
      ..addListener(() {
        setState(() {
          globalMovementCounter++;
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
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Welcome to space Invaders!',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                  color: Colors.white70
                )
                ),
            ),
          ),
          CustomPaint(
            painter : InvadersPaint(animation)
          )
        ])
      )
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
    originPath = InvadersConstruction.drawInvader(animation.value, 100, "squid");

    basicSquarePaint.color = Colors.yellow;

    canvas.drawPath(originPath, basicSquarePaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}






