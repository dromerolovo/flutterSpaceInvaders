import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'Views/SpaceInvadersMainView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Invaders',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Segoe UI',
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
    _controller!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ Container(
                padding: const EdgeInsets.only(),
                child: const Text("Welcome to Flutter Space Invaders",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                        color: Colors.white70))),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white70,
                      side: BorderSide(color: Colors.white70),
                    ),
                    onPressed : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpaceInvadersMainView())
                      );
                    },
                    child: const Text('Enter')
                  )
                )
            ]),
          Container(
              child: AnimatedBuilder(
            animation: _controller!,
            builder: (context, child) {
              return Transform.rotate(
                  angle: _controller!.value * 2 * math.pi, child: child);
            },
            child: Image(
              image: AssetImage('assets/AnimatedMoon.png'),
              height: 470,
            ),
          ))
        ]))));
  }
}
