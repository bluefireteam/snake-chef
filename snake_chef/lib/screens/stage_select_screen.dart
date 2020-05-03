import 'package:flutter/material.dart';

import '../stage_loader.dart';
import '../widgets/pattern_container.dart';
import '../widgets/button.dart';
import '../widgets/label.dart';

import '../audio_manager.dart';

class StageSelectScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    AudioManager.titleMusic();

    final itensPerColumn = 6;
    final rows = (StageLoader.STAGE_COUNT / itensPerColumn).ceil();

    return PatternContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Label(
              label: "Stage Selection",
              fontColor: Color(0xFF566c86),
              fontSize: 60,
            ),
            Column(
              children: List.generate(rows, (r) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(itensPerColumn, (c) {
                      final i = r * itensPerColumn + c;

                      if (i < StageLoader.STAGE_COUNT) {
                        return Container(
                            padding: EdgeInsets.all(20),
                            child: Button.primaryButton(
                                label: '${i + 1}',
                                width: 80,
                                height: 80,
                                onPressed: () {
                                  Navigator.pushNamed(ctx, '/game', arguments: i);
                                }));
                      } else {
                        return Container();
                      }
                    }));
              }),
            ),
            Button.secondaryButton(
                label: 'Back',
                onPressed: () {
                  Navigator.of(ctx).pushReplacementNamed('/title');
                }),
          ],
        ),
      ),
    );
  }
}
