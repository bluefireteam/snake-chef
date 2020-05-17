import 'package:flutter/material.dart';
import '../../widgets/label.dart';
import './game_modal.dart';

class PauseGame extends StatelessWidget {
  final VoidCallback resumeGame;

  PauseGame({this.resumeGame});

  @override
  Widget build(ctx) {
    return GameModal(
      title: Label(label: 'Pause', fontSize: 45, fontColor: Color(0xFF94b0c2)),
      primaryButtonLabel: 'Resume',
      primaryButtonPress: resumeGame,
      secondaryButtonLabel: 'Home',
      secondaryButtonPress: () {
        Navigator.of(ctx).pushReplacementNamed("/title");
      },
    );
  }
}
