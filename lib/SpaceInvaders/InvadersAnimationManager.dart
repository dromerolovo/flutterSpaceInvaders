import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:html';


class InvadersAnimationManager {

  //This method  maps the right direction movement(-x -> x) of invaders in a List of Tween Sequence Items, that it's
  //going to be procesed by the TweenSequence constructor '../Views/SpaceInvadersMainView.dart' line: 37

  static List<TweenSequenceItem<double>> getTweenRightMovement (double originX, double finalX, double pixelsToRight) {

    double steps = 16;
    
    var tweenSequence = <TweenSequenceItem<double>>[];

      for(int i = 1; i <= steps; i++ ) {
        if(i % 2 == 0) {
          var tweenItem = TweenSequenceItem<double>(
          tween: Tween<double>(begin: originX + pixelsToRight * i -1, end: originX + pixelsToRight * i -1),
          weight: 100/steps
          );
          tweenSequence.add(tweenItem); 
        } else {
          var tweenItem = TweenSequenceItem<double>(
          tween: Tween<double>(begin: originX + pixelsToRight * i, end: originX + pixelsToRight * i),
          weight: 100/steps
          );
          tweenSequence.add(tweenItem);
        }
      }     
    return tweenSequence;
    }

    static double getSpaceShipMovement(String keyLabel) {

      double movementValue = 0;

      if(keyLabel == "Arrow Right") {
        movementValue = 10;
      } else if (keyLabel == "Arrow Left") {
        movementValue = -10;
      } else if(keyLabel == "" || keyLabel == null ) {
        movementValue = 0;
      }

      return movementValue;
    }

  }
