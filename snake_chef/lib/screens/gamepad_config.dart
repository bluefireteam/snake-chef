import 'package:flutter/material.dart';
import 'package:snake_chef/settings_manager.dart';
import '../widgets/button.dart';
import '../widgets/label.dart';
import '../widgets/pattern_container.dart';
import '../widgets/sprite_slider.dart';

class GamePadConfigScreen extends StatefulWidget {
  @override
  State createState() {
    return _GamePadConfigScreenState();
  }
}

class _GamePadConfigScreenState extends State<GamePadConfigScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(ctx) {
    return PatternContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Label(
              label: 'Game Pad Config',
              fontColor: Color(0xFF566c86),
              fontSize: 38,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _ScreenContainer(
                                child: Label(
                                    label: 'Size:',
                                    fontSize: 22,
                                    fontColor: Color(0xFF333c57),
                                ),
                            ),
                            _ScreenContainer(
                                child: Label(
                                    label: 'Border:',
                                    fontSize: 22,
                                    fontColor: Color(0xFF333c57),
                                ),
                            ),
                            _ScreenContainer(
                                child: Label(
                                    label: 'Opacity:',
                                    fontSize: 22,
                                    fontColor: Color(0xFF333c57),
                                ),
                            ),
                          ],
                      ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ScreenContainer(
                                child: SpriteSlider.primary(
                                    value: 0,
                                    width: 200,
                                ),
                            ),
                            _ScreenContainer(
                                child: SpriteSlider.primary(
                                    value: 0,
                                    width: 200,
                                ),
                            ),
                            _ScreenContainer(
                                child: SpriteSlider.primary(
                                    value: 0,
                                    width: 200,
                                ),
                            ),
                          ],
                      ),
                  ),
                ],
            ),
            Button(
                buttonType: ButtonType.PRIMARY,
                label: 'Back',
                onPressed: () {
                  Navigator.of(ctx).pushNamed('/settings');
                }),
          ],
        ),
      ),
    );
  }
}

class _ScreenContainer extends StatelessWidget {
  final Widget child;

  _ScreenContainer({ this.child });

  @override
  Widget build(_) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.only(right: 20),
        child: child,
    );
  }
}
