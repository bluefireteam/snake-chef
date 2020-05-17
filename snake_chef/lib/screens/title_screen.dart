import 'package:flutter/material.dart';
import 'dart:io';

import '../widgets/pattern_container.dart';
import '../widgets/button.dart';

import '../audio_manager.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    AudioManager.titleMusic();

    return PatternContainer(
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/title.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Button(
                        buttonType: ButtonType.PRIMARY,
                        label: 'Play',
                        onPressed: () {
                          Navigator.of(ctx).pushNamed('/stage_select');
                        }),
                    SizedBox(height: 5),
                    Button(
                        buttonType: ButtonType.SECONDARY,
                        label: 'Credits',
                        onPressed: () {
                          Navigator.of(ctx).pushNamed('/credits');
                        }),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Button(
                        buttonType: ButtonType.SECONDARY,
                        label: 'Settings',
                        onPressed: () {
                          Navigator.of(ctx).pushNamed('/settings');
                        }),
                    SizedBox(height: 5),
                    Button(
                        buttonType: ButtonType.SECONDARY,
                        label: 'Exit',
                        onPressed: () {
                          exit(0);
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
