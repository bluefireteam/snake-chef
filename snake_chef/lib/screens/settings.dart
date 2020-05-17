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
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Label(
                        label: 'Music:',
                        fontSize: 42,
                        fontColor: Color(0xFF333c57),
                      ),
                      SizedBox(width: 10),
                      Button(
                        buttonType: _isMusicEnabled ? ButtonType.SWITCH_ON : ButtonType.SWITCH_OFF,
                        label: '${_isMusicEnabled ? 'on' : 'off'}',
                        width: 70,
                        onPressed: () {
                          setState(() {
                            _isMusicEnabled = !_isMusicEnabled;
                            SettingsManager.isMusicEnabled = _isMusicEnabled;
                            SettingsManager.save();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Label(
                        label: 'Sounds:',
                        fontSize: 42,
                        fontColor: Color(0xFF333c57),
                      ),
                      SizedBox(width: 10),
                      Button(
                        buttonType: _isSfxEnabled ? ButtonType.SWITCH_ON : ButtonType.SWITCH_OFF,
                        label: '${_isSfxEnabled ? 'on' : 'off'}',
                        width: 70,
                        onPressed: () {
                          setState(() {
                            _isSfxEnabled = !_isSfxEnabled;
                            SettingsManager.isSfxEnabled = _isSfxEnabled;
                            SettingsManager.save();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Label(
                        label: 'Gamepad:',
                        fontSize: 42,
                        fontColor: Color(0xFF333c57),
                      ),
                      SizedBox(width: 10),
                      Button(
                        buttonType: _isGamepadEnabled ? ButtonType.SWITCH_ON : ButtonType.SWITCH_OFF,
                        label: '${_isGamepadEnabled ? 'on' : 'off'}',
                        width: 70,
                        onPressed: () {
                          setState(() {
                            _isGamepadEnabled = !_isGamepadEnabled;
                            SettingsManager.gamePadOptions.enabled = _isGamepadEnabled;
                            SettingsManager.save();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Button(
                buttonType: ButtonType.PRIMARY,
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
