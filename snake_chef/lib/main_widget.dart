import 'package:flutter/material.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:snake_chef/audio_manager.dart';
import 'package:snake_chef/screens/control_select_screen.dart';
import 'package:snake_chef/screens/settings.dart';
import 'package:flutter/foundation.dart';

import './screens/credits_screen.dart';
import './screens/title_screen.dart';
import './screens/game_screen.dart';
import './screens/stage_select_screen.dart';
import './screens/gamepad_config.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainWidgetState();
  }
}

class _MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      AudioManager.pauseMusic();
    } else {
      AudioManager.resumeMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/splash_screen': (ctx) => FlameSplashScreen(
            theme: FlameSplashTheme.dark,
            showBefore: (BuildContext context) {
              return Image.asset('assets/images/fireslime-banner.png',
                  width: 400);
            },
            onFinish: (BuildContext context) {
              Navigator.pushNamed(context, "/title");
            },
          ),
      '/title': (ctx) => TitleScreen(),
      '/game': (ctx) => GameScreen(),
      '/stage_select': (ctx) => StageSelectScreen(),
      '/settings': (ctx) => SettingsScreen(),
      '/gamepad_config': (ctx) => GamePadConfigScreen(),
      '/credits': (ctx) => CreditsScreen(),
      '/control_select_screen': (ctx) => ControlSelectScreen(),
    }, initialRoute: kReleaseMode ? '/splash_screen' : '/title');
  }
}
