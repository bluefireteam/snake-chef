import 'package:flutter/material.dart';
import 'package:snake_chef/screens/game_screen.dart';
import 'package:snake_chef/settings_manager.dart';
import 'package:snake_chef/widgets/label.dart';
import 'package:snake_chef/widgets/pattern_container.dart';

class ControlSelectScreen extends StatelessWidget {
  void confirmEdition(BuildContext ctx, bool useGamepad) async {
    SettingsManager.setControlsInFirstAccess(useGamepad);

    GameScreenArgs gameArgs = ModalRoute.of(ctx).settings.arguments;

    Navigator.pushNamed(ctx, '/game',
        arguments: GameScreenArgs(
            stageNumber: gameArgs.stageNumber, difficult: gameArgs.difficult));
  }

  @override
  Widget build(BuildContext ctx) {
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
            SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          color: Colors.red,
                        ),
                        onTap: () => confirmEdition(ctx, false),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(color: Colors.blue),
                        onTap: () => confirmEdition(ctx, true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
