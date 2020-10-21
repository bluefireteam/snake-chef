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

  ButtonType getStageButtonType(int stage) {
    final difficult = SettingsManager.stageProgress.progress[stage];

    if (difficult == StageDifficult.HARD) {
      return ButtonType.PRIMARY;
    } else if (difficult == StageDifficult.MEDIUM) {
      return ButtonType.SILVER;
    } else if (difficult == StageDifficult.NORMAL) {
      return ButtonType.BRONZE;
    } else {
      return ButtonType.PLAIN;
    }
  }

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
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(rows, (r) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(itensPerColumn, (c) {
                          final i = r * itensPerColumn + c;

                          if (i < StageLoader.STAGE_COUNT) {
                            final isEnabled = i == 0 ||
                                SettingsManager.stageProgress.progress[i - 1] !=
                                    null;
                            return Container(
                              padding: EdgeInsets.all(15),
                              child: Button(
                                  buttonType: getStageButtonType(i),
                                  disabled: !isEnabled,
                                  label: '${i + 1}',
                                  width: 75,
                                  height: 75,
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
              ),
            ),
            SizedBox(height: 15),
            Button(
              buttonType: ButtonType.SECONDARY,
              label: 'Back',
              onPressed: () {
                Navigator.of(ctx).pushReplacementNamed('/title');
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Label(
                        label: 'Select Difficult',
                        fontSize: 35,
                        fontColor: Color(0xFF94b0c2)),
                    SizedBox(height: 20),
                    Button(
                      buttonType: ButtonType.BRONZE,
                      label: 'Normal',
                      onPressed: () {
                        if (SettingsManager.isFirstAccess) {
                          Navigator.pushNamed(ctx, '/control_select_screen',
                              arguments: GameScreenArgs(
                                  stageNumber: _stageNumber,
                                  difficult: StageDifficult.NORMAL));
                        } else {
                          Navigator.pushNamed(ctx, '/game',
                              arguments: GameScreenArgs(
                                  stageNumber: _stageNumber,
                                  difficult: StageDifficult.NORMAL));
                        }
                      },
                    ),
                    SizedBox(height: 5),
                    Button(
                      buttonType: ButtonType.SILVER,
                      label: 'Medium',
                      disabled: SettingsManager
                              .stageProgress.progress[_stageNumber] ==
                          null,
                      onPressed: () {
                        Navigator.pushNamed(ctx, '/game',
                            arguments: GameScreenArgs(
                                stageNumber: _stageNumber,
                                difficult: StageDifficult.MEDIUM));
                      },
                    ),
                    SizedBox(height: 5),
                    Button(
                      buttonType: ButtonType.PRIMARY,
                      label: 'Hard',
                      disabled: !(SettingsManager
                                  .stageProgress.progress[_stageNumber] ==
                              StageDifficult.MEDIUM ||
                          SettingsManager
                                  .stageProgress.progress[_stageNumber] ==
                              StageDifficult.HARD),
                      onPressed: () {
                        Navigator.pushNamed(ctx, '/game',
                            arguments: GameScreenArgs(
                                stageNumber: _stageNumber,
                                difficult: StageDifficult.HARD));
                      },
                    ),
                  ],
                ),
                Button(
                  buttonType: ButtonType.SECONDARY,
                  label: 'Cancel',
                  onPressed: () {
                    setState(() {
                      _stageNumber = null;
                    });
                  },
                ),
                SizedBox(height: 5),
              ],
            )),
      ));
    }

    return PatternContainer(
      child: Stack(children: children),
    );
  }
}
