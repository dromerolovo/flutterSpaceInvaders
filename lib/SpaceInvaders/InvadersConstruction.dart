import 'package:flutter/material.dart';


class InvadersConstruction {


    static Path drawInvader(double originX, double originY, String typeOfInvader) {

      var transitionPath = Path();

      var pathList = <List<int>>[];

      const List<List<int>> octopusMatrix = [
        [1,1,0,0,0,0,0,0,0,0,1,1],
        [0,0,1,1,0,1,1,0,1,1,0,0],
        [0,0,0,1,1,0,0,1,1,0,0,0],
        [1,1,1,1,1,1,1,1,1,1,1,1],
        [1,1,1,0,0,1,1,0,0,1,1,1],
        [1,1,1,1,1,1,1,1,1,1,1,1],
        [0,1,1,1,1,1,1,1,1,1,1,0],
        [0,0,0,0,1,1,1,1,0,0,0,0],
      ];

      const List<List<int>> crabMatrix = [
        [0,0,0,1,1,0,1,1,0,0,0],
        [1,0,1,0,0,0,0,0,1,0,1],
        [1,0,1,1,1,1,1,1,1,0,1],
        [1,1,1,1,1,1,1,1,1,1,1],
        [0,1,1,0,1,1,1,0,1,1,0],
        [0,0,1,1,1,1,1,1,1,0,0],
        [0,0,0,1,0,0,0,1,0,0,0],
        [0,0,1,0,0,0,0,0,1,0,0]
      ];

      const List<List<int>> squidMatrix = [
        [1,0,1,0,0,1,0,1],
        [0,1,0,1,1,0,1,0],
        [0,0,1,0,0,1,0,0],
        [1,1,1,1,1,1,1,1],
        [1,1,0,1,1,0,1,1],
        [0,1,1,1,1,1,1,0],
        [0,0,1,1,1,1,0,0],
        [0,0,0,1,1,0,0,0]

      ];

      void drawSquare( int row, int isItSquare, int sqrPosition ) {

        double y;
        double x;
        Path secondaryPath = Path();

        y = originY + row * -4;

        if (sqrPosition == 0) {
          x = originX;
        } else {
          x = sqrPosition * 4 + originX;
        }

        if (isItSquare == 1) {
          secondaryPath.moveTo(x, y);
          secondaryPath.relativeLineTo(4, 0);
          secondaryPath.relativeLineTo(0, -4);
          secondaryPath.relativeLineTo(-4, 0);

          secondaryPath.close();


          transitionPath = Path.combine(PathOperation.union, transitionPath, secondaryPath);
          transitionPath.fillType = PathFillType.evenOdd;
        }
      }

      int counterRow = -1;
      int counterCol = -1;

      if(typeOfInvader == "octopus") {
        pathList = octopusMatrix;
      } else if(typeOfInvader == "crab") {
        pathList = crabMatrix;
      } else if(typeOfInvader == "squid") {
        pathList = squidMatrix;
      }

      for ( var row in pathList) {
        counterRow++;
        // print("This is the counter of the row: $counterRow");
        for (var sqr in row) {
          counterCol++;
          // print("This is the counter of the square position: $counterCol");
          drawSquare(counterRow, sqr, counterCol);
          if (counterCol == row.length -1) {
            counterCol = -1;
          }
        }
      }

      return transitionPath;
    }
}