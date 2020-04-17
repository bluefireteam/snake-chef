import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/label.dart';

class GameWin extends StatelessWidget {
  @override
  Widget build(ctx) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Color(0xFFe3e3e3)),
            color: const Color(0xFF333c57),
          ),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Label(label: 'Stage Clear!', fontSize: 35, fontColor: Color(0xFF94b0c2)),
              Button.primaryButton(
                label: 'Next stage',
                onPressed: () {
                  Navigator.of(ctx).pushNamed('/stage_select');
                },
              ),
              Button.secondaryButton(
                label: 'Home',
                onPressed: () {
                  Navigator.of(ctx).pushReplacementNamed("/title");
                },
              ),
            ],
          )),
    );
  }
}
