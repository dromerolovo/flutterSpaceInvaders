import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'dart:math';


class InvadersAnimationManager {

  static void getAnimation (ui.Image sprite, ValueNotifier<Duration> notifier, Size size, Canvas canvas, double keyLabelValueState) {
    final ms = notifier.value.inMilliseconds;
    final frame = ms ~/200;

    //Every 32 frames the invaders change movement, so 32 frames go to the right and then 32 frames to the left.
    const extent = 32; 
    // So basically is a way of mapping the size of the window if it gets smaller.
    // The multiplication 12 * 16 is the length of a row of invaders, and the -2 is an arbitrary number to make 
    // the invaders smaller
    final scale = size.width / (12 * 16 + extent) - 2;
    final phase = frame % (extent * 2); //Puts a limit to the frame, so it go from 0 to 63

    //Basically this operation increases until certain point and then decreases. 
    final invadersMovement = scale * (phase > extent ? phase : 2 * extent - phase);

    // Because the spaceShip needs a continuos flow, it is necesary the raw ms value. Also, the sin function is used 
    // to achieve an increase and a decrease in value and the power cancels the negative values. 

    // final spaceShipMovement = (size.width - 16 * scale) * pow(sin(2 * pi * ms / 10000 ), 2);

    final transforms = [
      for(int i = 0; i < 5; i++) 
        ...List.generate(12, (index) => RSTransform(scale, 0, invadersMovement + scale * index * 16 + 50, scale * i * 16 + 100)),
        RSTransform(scale, 0, size.width / 2 + keyLabelValueState * 12, scale * 5 * 16 + 250),
    ];

    final rects = [
      for (int i = 0; i < 12; i++) Rect.fromLTWH(0, frame % 2 * 8, 16, 8),
      for (int i = 0; i < 12; i++) Rect.fromLTWH(16, frame % 2 * 8, 16, 8),
      for (int i = 0; i < 12; i++) Rect.fromLTWH(16, frame % 2 * 8, 16, 8),
      for (int i = 0; i < 12; i++) Rect.fromLTWH(32, frame % 2 * 8, 16, 8),
      for (int i = 0; i < 12; i++) Rect.fromLTWH(32, frame % 2 * 8, 16, 8),
      Rect.fromLTWH(0, 16, 16, 8),
    ];

    final colors = [
      for (int i = 0; i < 12; i++) Colors.purpleAccent,
      for (int i = 0; i < 12; i++) Colors.lightBlueAccent,
      for (int i = 0; i < 12; i++) Colors.lightBlueAccent,
      for (int i = 0; i < 12; i++) Colors.yellowAccent,
      for (int i = 0; i < 12; i++) Colors.yellowAccent,
      Colors.greenAccent,
  ];

  canvas.drawAtlas(sprite, transforms, rects, colors, BlendMode.dstATop, null, Paint());

    
  }
}