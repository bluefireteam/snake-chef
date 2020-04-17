import 'package:flutter/material.dart';

import 'package:snake_chef/game/assets.dart';
import '../widgets/assets.dart';

import '../audio_manager.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(ctx) {

    final future = Future.wait([
      Assets.load(),
      WidgetsAssets.load(),
      AudioManager.load(),
    ]);

    return Container(
        color: Color(0xFF000000),
        child: Scaffold(
            body: Center(child: FutureBuilder(
                future: future,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    return RaisedButton(
                        child: Text('Play'),
                        onPressed: () {
                          Navigator.of(ctx).pushNamed('/title');
                        }
                    );
                  } else {
                    return Text('Loading....');
                  }
                }
            )),
        ),
    );
  }
}
