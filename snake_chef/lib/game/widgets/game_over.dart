import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final VoidCallback restartGame;

  GameOver({this.restartGame});

  @override
  Widget build(_) {
    return Center(
      child: Container(
          width: 100,
          height: 100,
          color: const Color(0xFFFF0000),
          child: Column(
            children: [
              Text('Paused'),
              RaisedButton(
                  onPressed: restartGame,
                  child: Text('Restart', style: TextStyle(fontSize: 20)))
            ],
          )),
    );
  }
}
