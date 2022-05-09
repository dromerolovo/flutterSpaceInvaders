import 'package:flutter/material.dart';


class InvadersAnimationManager {

  static List<TweenSequenceItem<double>> getTweenRightMovement (double originX, double finalX, double pixelsToRight) {

    double steps = 58;
    
    var tweenSequence = <TweenSequenceItem<double>>[];

      for(int i = 1; i <= steps; i++ ) {
        if(i % 2 == 0) {
          var tweenItem = TweenSequenceItem<double>(
          tween: Tween<double>(begin: originX + pixelsToRight * i -1, end: originX + pixelsToRight * i -1),
          weight: 100/58/2
          );
          tweenSequence.add(tweenItem); 
        } else {
          var tweenItem = TweenSequenceItem<double>(
          tween: Tween<double>(begin: originX + pixelsToRight * i, end: originX + pixelsToRight * i),
          weight: 100/58/2
          );
          tweenSequence.add(tweenItem);
        }
      }     
    return tweenSequence;
    }

    
  }
