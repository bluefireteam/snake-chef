import 'package:flutter/material.dart';
import 'package:snake_chef/settings_manager.dart';
import '../widgets/button.dart';
import '../widgets/label.dart';
import '../widgets/pattern_container.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isMusicEnabled;
  bool _isSfxEnabled;
  bool _isGamepadEnabled;

  @override
  void initState() {
    super.initState();
    _isMusicEnabled = SettingsManager.isMusicEnabled;
    _isSfxEnabled = SettingsManager.isSfxEnabled;
    _isGamepadEnabled = SettingsManager.gamePadOptions.enabled;
  }

  @override
  Widget build(ctx) {
    return PatternContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Label(
              label: 'Settings',
              fontColor: Color(0xFF566c86),
              fontSize: 60,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Label(
                              label: 'Music:',
                              fontSize: 42,
                              fontColor: Color(0xFF333c57),
                            ),
                            SizedBox(height: 5),
                            Label(
                              label: 'Sounds:',
                              fontSize: 42,
                              fontColor: Color(0xFF333c57),
                            ),
                            SizedBox(height: 5),
                            Label(
                              label: 'Gamepad:',
                              fontSize: 42,
                              fontColor: Color(0xFF333c57),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Button(
                                buttonType: _isMusicEnabled
                                    ? ButtonType.SWITCH_ON
                                    : ButtonType.SWITCH_OFF,
                                label: '${_isMusicEnabled ? 'on' : 'off'}',
                                width: 70,
                                onPressed: () {
                                  setState(() {
                                    _isMusicEnabled = !_isMusicEnabled;
                                    SettingsManager.isMusicEnabled =
                                        _isMusicEnabled;
                                    SettingsManager.save();
                                  });
                                },
                              ),
                              SizedBox(height: 5),
                              Button(
                                buttonType: _isSfxEnabled
                                    ? ButtonType.SWITCH_ON
                                    : ButtonType.SWITCH_OFF,
                                label: '${_isSfxEnabled ? 'on' : 'off'}',
                                width: 70,
                                onPressed: () {
                                  setState(() {
                                    _isSfxEnabled = !_isSfxEnabled;
                                    SettingsManager.isSfxEnabled =
                                        _isSfxEnabled;
                                    SettingsManager.save();
                                  });
                                },
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Button(
                                    buttonType: _isGamepadEnabled
                                        ? ButtonType.SWITCH_ON
                                        : ButtonType.SWITCH_OFF,
                                    label:
                                        '${_isGamepadEnabled ? 'on' : 'off'}',
                                    width: 70,
                                    onPressed: () {
                                      setState(() {
                                        _isGamepadEnabled = !_isGamepadEnabled;
                                        SettingsManager.gamePadOptions.enabled =
                                            _isGamepadEnabled;
                                        SettingsManager.save();
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  _isGamepadEnabled
                                      ? (Button(
                                          buttonType: ButtonType.PLAIN,
                                          label: 'Edit',
                                          width: 150,
                                          onPressed: () {
                                            Navigator.of(ctx)
                                                .pushNamed('/gamepad_config');
                                          },
                                        ))
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Button(
              buttonType: ButtonType.PRIMARY,
              label: 'Back',
              onPressed: () {
                Navigator.of(ctx).pushNamed('/title');
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
