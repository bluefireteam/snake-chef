import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class GameModal extends StatelessWidget {
  final Widget title;
  final primaryButtonLabel;
  final primaryButtonPress;

  final secondaryButtonLabel;
  final secondaryButtonPress;

  GameModal(
      {this.title,
      this.primaryButtonLabel,
      this.primaryButtonPress,
      this.secondaryButtonLabel,
      this.secondaryButtonPress});

  @override
  Widget build(ctx) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Color(0xFFe3e3e3)),
            color: const Color(0xFF333c57),
          ),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              title,
              Button(
                buttonType: ButtonType.PRIMARY,
                label: primaryButtonLabel,
                onPressed: primaryButtonPress,
              ),
              Button(
                buttonType: ButtonType.SECONDARY,
                label: secondaryButtonLabel,
                onPressed: secondaryButtonPress,
              ),
            ],
          )),
    );
  }
}
