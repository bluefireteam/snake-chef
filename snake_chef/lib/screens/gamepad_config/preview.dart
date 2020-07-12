import 'package:flutter/material.dart';

import '../../widgets/direction_pad.dart';
import '../../widgets/action_button.dart';

class GamepadPreview extends StatelessWidget {
  final double size;
  final double opacity;
  final double borderPercent;

  GamepadPreview({
    this.size,
    this.opacity,
    this.borderPercent,
  });

  @override
  Widget build(ctx) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final gamepadButtonSize = size * constraints.maxHeight;
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Color(0xFF1a1c2c),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: DirectionPad(
                containerSize: gamepadButtonSize,
                opacity: opacity,
                borderPercent: borderPercent,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ActionButton(
                dpadSize: gamepadButtonSize,
                opacity: opacity,
                borderPercent: borderPercent,
              ),
            ),
          ],
        ),
      );
    });
  }
}
