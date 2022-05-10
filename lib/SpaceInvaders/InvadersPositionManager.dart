import 'package:flutter/material.dart';
import 'InvadersConstruction.dart';

class InvadersPositionManager {
  
  static void placeInvadersOnLine(Canvas canvas, double originX, double originY, String invader, double inBetweenPixels, Color color) {
    
    int _rowElements = 12;
    Path _internalInvader;
    Paint _paint = Paint();

    double _invaderLength = 48;

    _paint.color = color;

    for(int i = 1; i <= 12 + 1; i++) {
      if(i == 1) {
        _internalInvader = InvadersConstruction.drawInvader(originX, originY, invader);
      } else {
      _internalInvader = InvadersConstruction.drawInvader(originX + _invaderLength + i * inBetweenPixels, originY, invader);
      canvas.drawPath(_internalInvader, _paint);
      }


    }
  }
}