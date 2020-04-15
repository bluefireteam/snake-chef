import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

import './label.dart';
import './assets.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final Color labelColor;
  final Sprite sprite;
  final Sprite pressedSprite;
  final double width;
  final double height;

  Button({
    this.onPressed,
    this.label,
    this.labelColor,
    this.sprite,
    this.pressedSprite,

    this.width,
    this.height,
  });

  Button.primaryButton({
    VoidCallback onPressed,
    String label,

    double width,
    double height,
  }): this(
    onPressed: onPressed,
    label: label,
    width: width,
    height: height,

    labelColor: Color(0xFFb13e53),
    sprite: ButtonSprites.primaryButton(),
    pressedSprite: ButtonSprites.primaryButtonPressed(),
  );

  Button.secondaryButton({
    VoidCallback onPressed,
    String label,

    double width,
    double height,
  }): this(
    onPressed: onPressed,
    label: label,
    width: width,
    height: height,

    labelColor: Color(0xFF5d275d),
    sprite: ButtonSprites.secondaryButton(),
    pressedSprite: ButtonSprites.secondaryButtonPressed(),
  );

  @override
  State createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _pressed = false;

  @override
  Widget build(_) {
    final width = widget.width ?? 200;
    final height = widget.height ?? 50;

    return GestureDetector(
        onTapDown: (_) {
          setState(() {
            _pressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _pressed = false;
          });

          widget.onPressed?.call();
        },
        child: Container(
            width: width,
            height: height,
            child: CustomPaint(
                painter: _ButtonPainer(_pressed ? widget.pressedSprite : widget.sprite),
                child: Center(
                    child: Label(
                        label: widget.label,
                        fontColor: widget.labelColor,
                        fontSize: height * 0.6,
                    ),
                ),
            ),
        ),
    );
  }
}

class _ButtonPainer extends CustomPainter {
  Sprite _sprite;

  _ButtonPainer(this._sprite);

  @override
  bool shouldRepaint(_ButtonPainer old) => old._sprite != _sprite;

  @override
  void paint(Canvas canvas, Size size) {
    _sprite.renderRect(canvas, Rect.fromLTWH(0, 0, size.width, size.height));
  }
}
