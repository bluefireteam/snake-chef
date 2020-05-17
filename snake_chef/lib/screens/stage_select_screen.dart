import 'package:flutter/material.dart';
import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/screens/game_screen.dart';
import '../settings_manager.dart';

import '../stage_loader.dart';
import '../widgets/pattern_container.dart';
import '../widgets/button.dart';
import '../widgets/label.dart';

import '../audio_manager.dart';

class StageSelectScreen extends StatefulWidget {
  @override
  State createState() {
    return _StageSelectScreenState();
  }
}

class _StageSelectScreenState extends State<StageSelectScreen> {
  int _stageNumber;

  @override
  Widget build(ctx) {
    AudioManager.titleMusic();

    final itensPerColumn = 6;
    final rows = (StageLoader.STAGE_COUNT / itensPerColumn).ceil();

    List<Widget> children = [];

    children.add(
      Center(
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
                        final isEnabled = i <= SettingsManager.stageProgress.normal;
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Button.primaryButton(
                              disabled: !isEnabled,
                              label: '${i + 1}',
                              width: 80,
                              height: 80,
                              onPressed: () {
                                if (isEnabled) {
                                  setState(() {
                                    _stageNumber = i;
                                  });
                                }
                              }),
                        );
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

//Navigator.pushNamed(ctx, '/game', arguments: i);

    if (_stageNumber != null) {
      children.add(Center(
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 10, color: Color(0xFFe3e3e3)),
              color: const Color(0xFF333c57),
            ),
            width: 400,
            height: 380,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Label(label: 'Select Difficult', fontSize: 35, fontColor: Color(0xFF94b0c2)),
                Button.primaryButton(
                  label: 'Normal',
                  onPressed: () {
                    Navigator.pushNamed(ctx, '/game', arguments: GameScreenArgs(stageNumber: _stageNumber, difficult: StageDifficult.NORMAL));
                  },
                ),
                Button.primaryButton(
                  label: 'Medium',
                  disabled: !(_stageNumber < SettingsManager.stageProgress.normal),
                  onPressed: () {
                    Navigator.pushNamed(ctx, '/game', arguments: GameScreenArgs(stageNumber: _stageNumber, difficult: StageDifficult.MEDIUM));
                  },
                ),
                Button.primaryButton(
                  label: 'Hard',
                  disabled: !(_stageNumber < SettingsManager.stageProgress.medium),
                  onPressed: () {
                    Navigator.pushNamed(ctx, '/game', arguments: GameScreenArgs(stageNumber: _stageNumber, difficult: StageDifficult.HARD));
                  },
                ),
                Button.secondaryButton(
                  label: 'Cancel',
                  onPressed: () {
                    setState(() {
                      _stageNumber = null;
                    });
                  },
                ),
              ],
            )),
      ));
    }

    return PatternContainer(
      child: Stack(children: children),
    );
  }
}
