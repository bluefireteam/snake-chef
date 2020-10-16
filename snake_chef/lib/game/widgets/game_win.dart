import 'package:flutter/material.dart';
import '../../widgets/label.dart';
import './game_modal.dart';

class GameWin extends StatelessWidget {
  @override
  Widget build(ctx) {
    return GameModal(
      title: Label(
          label: 'Stage Clear!', fontSize: 35, fontColor: Color(0xFF94b0c2)),
      primaryButtonLabel: 'Next stage',
      primaryButtonPress: () {
        Navigator.of(ctx).pushNamed('/stage_select');
      },
      secondaryButtonLabel: 'Home',
      secondaryButtonPress: () {
        Navigator.of(ctx).pushReplacementNamed("/title");
      },
    );
  }
}
