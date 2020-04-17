import 'package:flutter/material.dart';

import '../widgets/pattern_container.dart';
import '../widgets/button.dart';

import '../audio_manager.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(ctx) {

    AudioManager.loopBackgroundMusic('title.ogg');

    return PatternContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/title.png', width: 700),
            Column(
              children: [
                Button.primaryButton(
                    label: 'Play',
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/stage_select');
                    }),
                SizedBox(
                  height: 15,
                ),
                Button.secondaryButton(
                    label: 'Credits',
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/credits');
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
