import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/label.dart';

class GameOver extends StatelessWidget {
  final VoidCallback restartGame;

  GameOver({this.restartGame});

  @override
  Widget build(ctx) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 10, color: Color(0xFFe3e3e3)),
              color: const Color(0xFF566c86),
          ),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Label(label: 'Game Over', fontSize: 45, fontColor: Color(0xFF94b0c2)),
              Button.primaryButton(
                  label: 'Restart',
                  onPressed: restartGame,
              ),
              Button.secondaryButton(
                  label: 'Back',
                  onPressed: () {
                    Navigator.of(ctx).pushReplacementNamed("/title");
                  },
              ),
            ],
          )),
    );
  }
}
