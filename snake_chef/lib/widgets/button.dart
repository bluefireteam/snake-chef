import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

import './label.dart';
import './assets.dart';

enum ButtonType {
  PRIMARY,
  SECONDARY,
  SILVER,
  BRONZE,
  SWITCH_ON,
  SWITCH_OFF,
  PLAIN,
}

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onPress;
  final VoidCallback onPressReleased;
  final String label;
  final ButtonType buttonType;

  final double width;
  final double height;
  final bool disabled;

  Button({
    this.onPressed,
    this.onPress,
    this.onPressReleased,
    this.label,
    this.buttonType,
    this.width,
    this.height,
    this.disabled = false,
  });

  @override
  State createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _pressed = false;

  void _press() {
    widget.onPress?.call();
    setState(() {
      _pressed = true;
    });
  }

  void _release() {
    setState(() {
      _pressed = false;
    });

    widget.onPressReleased?.call();
    widget.onPressed?.call();
  }

  @override
  Widget build(_) {
    final width = widget.width ?? 200;
    final height = widget.height ?? 50;

    Sprite _sprite;
    Sprite _pressedSprite;
    Color _labelColor;

    switch (widget.buttonType) {
      case ButtonType.PRIMARY:
        {
          _labelColor = Color(0xFFb13e53);
          _sprite = ButtonSprites.primaryButton();
          _pressedSprite = ButtonSprites.primaryButtonPressed();
          break;
        }
      case ButtonType.SECONDARY:
        {
          _labelColor = Color(0xFF5d275d);
          _sprite = ButtonSprites.secondaryButton();
          _pressedSprite = ButtonSprites.secondaryButtonPressed();
          break;
        }
      case ButtonType.SILVER:
        {
          _labelColor = Color(0xFF333c57);
          _sprite = ButtonSprites.dpadButton();
          _pressedSprite = ButtonSprites.dpadButtonPressed();
          break;
        }
      case ButtonType.SWITCH_ON:
        {
          _labelColor = Color(0xFFa7f070);
          _sprite = ButtonSprites.onButton();
          _pressedSprite = ButtonSprites.onButtonPressed();
          break;
        }
      case ButtonType.SWITCH_OFF:
        {
          _labelColor = Color(0xFF5d275d);
          _sprite = ButtonSprites.offButton();
          _pressedSprite = ButtonSprites.offButtonPressed();
          break;
        }
      case ButtonType.BRONZE:
        {
          _labelColor = Color(0xFFb13e53);
          _sprite = ButtonSprites.bronzeButton();
          _pressedSprite = ButtonSprites.bronzeButtonPressed();
          break;
        }
      case ButtonType.PLAIN:
        {
          _labelColor = Color(0xFF566c86);
          _sprite = ButtonSprites.plainButton();
          _pressedSprite = ButtonSprites.plainButtonPressed();
          break;
        }
    }

    return Opacity(
        opacity: widget.disabled ? 0.3 : 1,
        child: GestureDetector(
          onTapDown: (_) {
            if (widget.disabled) {
              return;
            }
            _press();
          },
          onTapUp: (_) {
            if (widget.disabled) {
              return;
            }
            _release();
          },
          onTapCancel: () {
            if (widget.disabled) {
              return;
            }
            _release();
          },
          child: Container(
            width: width,
            height: height,
            child: CustomPaint(
              painter: _ButtonPainer(_pressed ? _pressedSprite : _sprite),
              child: Center(
                child: widget.label != null
                    ? Label(
                        label: widget.label,
                        fontColor: _labelColor,
                        fontSize: height * 0.6,
                      )
                    : null,
              ),
            ),
          ),
        ));
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
