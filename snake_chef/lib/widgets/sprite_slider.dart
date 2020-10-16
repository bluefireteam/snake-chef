import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flame/sprite.dart';

import 'dart:math';

import './assets.dart';

typedef SpriteSliderOnChange = void Function(double);

class SpriteSlider extends StatefulWidget {
  final Sprite leftTile;
  final Sprite rightTile;
  final Sprite middleTile;
  final Sprite bullet;

  final double tileSize;

  final double width;

  final double value;

  final SpriteSliderOnChange onChange;

  SpriteSlider({
    @required this.leftTile,
    @required this.rightTile,
    @required this.middleTile,
    @required this.bullet,
    @required this.tileSize,
    @required this.width,
    this.value = 0,
    this.onChange,
  }) {
    assert(
      leftTile.loaded() &&
          rightTile.loaded() &&
          middleTile.loaded() &&
          bullet.loaded(),
      'All sprites must be loaded!',
    );

    assert(value == null || (value >= 0 && value <= 1),
        'Value must be between 0 and 1');
  }

  SpriteSlider.primary({
    @required double width,
    double height,
    double value = 0,
    SpriteSliderOnChange onChange,
  }) : this(
          leftTile: SlideSprites.leftTile(),
          rightTile: SlideSprites.rightTile(),
          middleTile: SlideSprites.middleTile(),
          bullet: SlideSprites.bullet(),
          tileSize: 30,
          width: width,
          value: value,
          onChange: onChange,
        );

  @override
  State createState() => _SpriteSliderState();
}

class _SpriteSliderState extends State<SpriteSlider> {
  bool _moving = false;
  double _value = 0;

  @override
  void initState() {
    super.initState();

    _value = widget.value;
  }

  Rect _bulletRect() {
    return Rect.fromLTWH(
      (_value * widget.width) - widget.tileSize,
      0,
      widget.tileSize,
      widget.tileSize,
    );
  }

  @override
  Widget build(_) {
    return Container(
      width: widget.width,
      height: widget.tileSize,
      child: GestureDetector(
        onPanStart: (details) {
          final bulletRect = _bulletRect();
          final touchRect = Rect.fromCenter(
            center: details.localPosition,
            width: widget.tileSize,
            height: widget.tileSize,
          );

          if (bulletRect.overlaps(touchRect)) {
            setState(() => _moving = true);
          }
        },
        onPanEnd: (details) {
          widget.onChange?.call(_value);
          setState(() => _moving = false);
        },
        onPanUpdate: (details) {
          if (_moving) {
            final value =
                max(0.0, min(1.0, details.localPosition.dx / widget.width));
            setState(() => _value = value);
            widget.onChange?.call(_value);
          }
        },
        onPanCancel: () {
          setState(() => _moving = false);
        },
        child: CustomPaint(
          painter: _SliderPainter(
            widget.leftTile,
            widget.rightTile,
            widget.middleTile,
            widget.bullet,
            widget.tileSize,
            _value,
          ),
        ),
      ),
    );
  }
}

class _SliderPainter extends CustomPainter {
  Sprite leftTile;
  Sprite rightTile;
  Sprite middleTile;
  Sprite bullet;
  double tileSize;
  double value;

  _SliderPainter(
    this.leftTile,
    this.rightTile,
    this.middleTile,
    this.bullet,
    this.tileSize,
    this.value,
  );

  @override
  bool shouldRepaint(_SliderPainter old) => value != old.value;

  @override
  void paint(Canvas canvas, Size size) {
    leftTile.renderRect(
      canvas,
      Rect.fromLTWH(0, 0, tileSize, tileSize),
    );

    middleTile.renderRect(
      canvas,
      Rect.fromLTWH(tileSize, 0, size.width - tileSize * 2, tileSize),
    );

    rightTile.renderRect(
      canvas,
      Rect.fromLTWH(size.width - tileSize, 0, tileSize, tileSize),
    );

    bullet.renderRect(
      canvas,
      Rect.fromLTWH(
        size.width * value - tileSize / 2,
        0,
        tileSize,
        tileSize,
      ),
    );
  }
}
