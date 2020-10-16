import 'package:flutter/material.dart';
import 'package:snake_chef/settings_manager.dart';
import '../widgets/button.dart';
import '../widgets/label.dart';
import '../widgets/pattern_container.dart';
import '../widgets/sprite_slider.dart';

import './gamepad_config/preview.dart';

class GamePadConfigScreen extends StatefulWidget {
  @override
  State createState() {
    return _GamePadConfigScreenState();
  }
}

class _GamePadConfigScreenState extends State<GamePadConfigScreen> {
  double _size;
  double _opacity;
  double _borderPercentage;

  @override
  void initState() {
    super.initState();

    _size = SettingsManager.gamePadOptions.buttonSize;
    _opacity = SettingsManager.gamePadOptions.opacity;
    _borderPercentage = SettingsManager.gamePadOptions.borderPercentage;
  }

  @override
  Widget build(ctx) {
    return PatternContainer(
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Label(
                label: 'Game Pad Config',
                fontColor: Color(0xFF566c86),
                fontSize: 38,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ControlInput(
                            label: 'Size',
                            initialValue: _size,
                            onChange: (value) {
                              SettingsManager.gamePadOptions.buttonSize = value;
                              SettingsManager.save();
                              setState(() => _size = value);
                            },
                          ),
                          _ControlInput(
                            label: 'Opacity',
                            initialValue: _opacity,
                            onChange: (value) {
                              SettingsManager.gamePadOptions.opacity = value;
                              SettingsManager.save();
                              setState(() => _opacity = value);
                            },
                          ),
                          _ControlInput(
                            label: 'Border',
                            initialValue: _borderPercentage,
                            onChange: (value) {
                              SettingsManager.gamePadOptions.borderPercentage =
                                  value;
                              SettingsManager.save();
                              setState(() => _borderPercentage = value);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Label(
                                label: "Vibrate: ",
                                fontSize: 18,
                                fontColor: Color(0xFF333c57),
                              ),
                              Button(
                                  width: 100,
                                  height: 30,
                                  buttonType: SettingsManager.isVibrateEnabled
                                      ? ButtonType.SWITCH_ON
                                      : ButtonType.SWITCH_OFF,
                                  label: SettingsManager.isVibrateEnabled
                                      ? "On"
                                      : "Off",
                                  onPress: () {
                                    setState(() {
                                      SettingsManager.isVibrateEnabled =
                                          !SettingsManager.isVibrateEnabled;
                                      SettingsManager.save();
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Label(
                              label: 'Preview',
                              fontColor: Color(0xFF566c86),
                              fontSize: 22,
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: GamepadPreview(
                                opacity: _opacity,
                                size: _size,
                                borderPercent: _borderPercentage,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Button(
                buttonType: ButtonType.PRIMARY,
                label: 'Back',
                onPressed: () {
                  Navigator.of(ctx).pushNamed('/settings');
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlInput extends StatelessWidget {
  final void Function(double) onChange;
  final String label;
  final double initialValue;

  _ControlInput({
    this.initialValue,
    this.label,
    this.onChange,
  });

  @override
  Widget build(ctx) {
    return LayoutBuilder(
      builder: (ctx, constrainsts) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Label(
                label: label,
                fontSize: 18,
                fontColor: Color(0xFF333c57),
              ),
              SpriteSlider.primary(
                width: constrainsts.maxWidth,
                value: initialValue,
                onChange: onChange,
              ),
            ],
          ),
        );
      },
    );
  }
}
