import 'package:flutter/material.dart';

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
  final double borderPercent;

  DirectionPad({
    this.onPress,
    this.containerSize = 200,
    this.opacity = 0.5,
    this.borderPercent = 0.0,
  });

  @override
  Widget build(BuildContext ctx) {
    final buttonSize = containerSize / 3;
    final border = containerSize * borderPercent;
    return Opacity(opacity: opacity, child: Container(
        width: containerSize,
        height: containerSize,
        margin: EdgeInsets.all(border),
        child: Center(
          child: Container(
            width: containerSize,
            height: containerSize,
            child: Stack(children: [
              Positioned(
                left: buttonSize,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress?.call(DpadKey.UP),
                ),
              ),
              Positioned(
                top: buttonSize,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress?.call(DpadKey.LEFT),
                ),
              ),
              Positioned(
                top: buttonSize,
                left: buttonSize * 2,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress?.call(DpadKey.RIGHT),
                ),
              ),
              Positioned(
                top: buttonSize * 2,
                left: buttonSize,
                child: Button(
                  buttonType: ButtonType.SILVER,
                  width: buttonSize,
                  height: buttonSize,
                  onPressed: () => onPress?.call(DpadKey.DOWN),
                ),
              ),
            ]),
          ))
        ));
      }
}
