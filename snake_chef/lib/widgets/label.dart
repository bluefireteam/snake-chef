import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;
  final Color fontColor;
  final double fontSize;

  Label({
    this.label,
    this.fontColor,
    this.fontSize,
  });

  @override
  Widget build(_) {
    return Text(
      label,
      style: TextStyle(
          color: fontColor, fontFamily: "VictorPixel", fontSize: fontSize),
    );
  }
}
