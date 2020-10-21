import 'package:flutter/material.dart' hide Animation;
import 'package:flame/flame.dart';
import 'package:flame/animation.dart';
import 'package:flame/widgets/animation_widget.dart';
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
              label: "How do you want to play?",
              fontColor: Color(0xFF566c86),
              fontSize: 38,
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 25, left: 50, right: 50, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Column(
                          children: [
                            Label(
                              label: "Touch",
                              fontColor: Color(0xFF29366f),
                              fontSize: 20,
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: _AnimationContainer(
                                    image: 'touch_tutorial.png'),
                              ),
                            ),
                          ],
                        ),
                        onTap: () => confirmEdition(ctx, false),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Column(
                          children: [
                            Label(
                              label: "Screen gamepad",
                              fontColor: Color(0xFF29366f),
                              fontSize: 20,
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: _AnimationContainer(
                                    image: 'gamepad_tutorial.png'),
                              ),
                            ),
                          ],
                        ),
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

class _AnimationContainer extends StatelessWidget {
  final String image;

  _AnimationContainer({this.image});

  @override
  Widget build(_) {
    return FutureBuilder(
        future: Flame.images.load(image).then((_) => Animation.sequenced(
              image,
              4,
              stepTime: 0.4,
              textureWidth: 144,
              textureHeight: 128,
            )),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return AnimationWidget(animation: snapshot.data);
          }

          return Container();
        });
  }
}
