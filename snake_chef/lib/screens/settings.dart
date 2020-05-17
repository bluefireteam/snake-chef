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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button.secondaryButton(
                  label: 'Music enabled: ${_isMusicEnabled ? 'on' : 'off'}',
                  width: 320,
                  onPress: () {
                    setState(() {
                      _isMusicEnabled = !_isMusicEnabled;
                      SettingsManager.isMusicEnabled = _isMusicEnabled;
                      SettingsManager.save();
                    });
                  },
                ),
                Button.secondaryButton(
                  label: 'Sound effects enabled: ${_isSfxEnabled ? 'on' : 'off'}',
                  width: 320,
                  onPress: () {
                    setState(() {
                      _isSfxEnabled = !_isSfxEnabled;
                      SettingsManager.isSfxEnabled = _isSfxEnabled;
                      SettingsManager.save();
                    });
                  },
                )
              ],
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
