import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/label.dart';
import '../widgets/pattern_container.dart';
import '../widgets/button.dart';
import '../widgets/link.dart';

class CreditsScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    return PatternContainer(
        child: SafeArea(
      child: Column(children: [
        SizedBox(height: 40),
        Label(label: "Credits", fontSize: 32, fontColor: Color(0xFF566c86)),
        Expanded(
            child: Row(children: [
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Color(0xFFe3e3e3)),
                    color: Color(0xFF333c57),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/fireslime-banner.png',
                            width: 160),
                        Label(
                            label: "Game made by Fireslime",
                            fontSize: 18,
                            fontColor: Color(0xFF94b0c2)),
                        Link(
                            link: "https://fireslime.xyz",
                            fontSize: 18,
                            fontColor: Color(0xFF41a6f6))
                      ]))),
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Color(0xFFe3e3e3)),
                    color: Color(0xFF333c57),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Label(
                            label: "Music by Fabri",
                            fontSize: 16,
                            fontColor: Color(0xFF94b0c2)),
                        Link(
                            link: "https://fabrisounds.com.br",
                            fontSize: 16,
                            fontColor: Color(0xFF41a6f6)),
                      ]))),
        ])),
        SizedBox(height: 20),
        Button(
            buttonType: ButtonType.SECONDARY,
            label: 'Back',
            onPress: () {
              Navigator.of(ctx).pushNamed('/title');
            }),
        SizedBox(height: 20),
      ]),
    ));
  }
}
