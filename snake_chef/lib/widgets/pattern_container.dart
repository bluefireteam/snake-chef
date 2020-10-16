import 'package:flutter/material.dart';

class PatternContainer extends StatelessWidget {
  final Widget child;

  PatternContainer({this.child});

  @override
  Widget build(ctx) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: child,
      ),
    );
  }
}
