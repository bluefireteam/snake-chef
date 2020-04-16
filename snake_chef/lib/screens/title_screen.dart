import 'package:flutter/material.dart';

import '../widgets/pattern_container.dart';
import '../widgets/button.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    return PatternContainer(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('images/title.png', width: 700),
                  Button.primaryButton(
                      label: 'Play',
                      onPressed: () {
                        Navigator.of(ctx).pushNamed('/stage_select');
                      }
                  ),
                ],
            ),
        ),
    );
  }
}
