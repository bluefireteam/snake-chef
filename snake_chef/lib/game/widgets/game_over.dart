import 'package:flutter/material.dart';
import '../../widgets/label.dart';
import './game_modal.dart';

class GameOver extends StatelessWidget {
  final VoidCallback restartGame;
  final String label;

  GameOver({this.restartGame, this.label});

  @override
  Widget build(ctx) {
    return GameModal(
      title: Label(label: label, fontSize: 45, fontColor: Color(0xFF94b0c2)),
      primaryButtonLabel: 'Restart',
      primaryButtonPress: restartGame,
      secondaryButtonLabel: 'Home',
      secondaryButtonPress: () {
        Navigator.of(ctx).pushReplacementNamed("/title");
      },
    );
  }
}
