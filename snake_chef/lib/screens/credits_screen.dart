import 'package:flutter/material.dart';

import '../widgets/label.dart';
import '../widgets/pattern_container.dart';
import '../widgets/button.dart';

class CreditsScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    return PatternContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Label(
              label: 'Credits',
              fontColor: Color(0xFF566c86),
              fontSize: 60,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 10, color: Color(0xFFe3e3e3)),
                color: Color(0xFF333c57),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(
                    label: 'Developers',
                    fontColor: Color(0xFF94b0c2),
                    fontSize: 40,
                  ),
                  Label(
                    label: ' - Erick (CptBlackPixel)',
                    fontColor: Color(0xFFbecfda),
                    fontSize: 30,
                  ),
                  Label(
                    label: ' - Ty',
                    fontColor: Color(0xFFbecfda),
                    fontSize: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Label(
                      label: 'Musics by Fabri (fabrisounds.com.br)',
                      fontColor: Color(0xFFdfe7ed),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Button.primaryButton(
                label: 'Back',
                onPressed: () {
                  Navigator.of(ctx).pushNamed('/title');
                }),
          ],
        ),
      ),
    );
  }
}
