import 'package:flutter/material.dart';

import '../haptic.dart';
import '../widgets/button.dart';

class ActionButton extends StatelessWidget {
  final double opacity;
  final double dpadSize;
  final double borderPercent;
  final VoidCallback onAction;
  final VoidCallback onActionRelease;

  ActionButton({
    this.onAction,
    this.onActionRelease,
    this.opacity,
    this.dpadSize,
    this.borderPercent = 0.0,
  });

  @override
  Widget build(ctx) {
    final gamepadButtonSize = dpadSize / 3;
    final border = dpadSize * borderPercent;
    return Opacity(
        opacity: opacity,
        child: Container(
          margin: EdgeInsets.all(border),
          child: Button(
            buttonType: ButtonType.SILVER,
            width: gamepadButtonSize,
            height: gamepadButtonSize,
            onPress: () {
              onAction?.call();
              hapticFeedback();
            },
            onPressReleased: () {
              onActionRelease?.call();
            },
          ),
        ));
  }
}
