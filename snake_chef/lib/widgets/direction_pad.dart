import 'package:flutter/material.dart';
import 'dart:math';

import './button.dart';

enum DpadKey {
  UP,
  DOWN,
  LEFT,
  RIGHT,
}

typedef OnKeyPress = void Function(DpadKey key);

class DirectionPad extends StatelessWidget {
  final OnKeyPress onPress;

  final double containerSize;
  final double opacity;

  DirectionPad({
    @required this.onPress,
    this.containerSize = 200,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext ctx) {
    final buttonSize = min(50.0, containerSize / 3);
    return Opacity(opacity: opacity, child: Container(
        width: containerSize,
        height: containerSize,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(5),
            width: buttonSize * 3,
            height: buttonSize * 3,
            child: Stack(children: [
              Positioned(
                left: buttonSize,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress(DpadKey.UP),
                ),
              ),
              Positioned(
                top: buttonSize,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress(DpadKey.LEFT),
                ),
              ),
              Positioned(
                top: buttonSize,
                left: buttonSize * 2,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress(DpadKey.RIGHT),
                ),
              ),
              Positioned(
                top: buttonSize * 2,
                left: buttonSize,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress(DpadKey.DOWN),
                ),
              ),
            ]),
          ))
        ));
      }
}
