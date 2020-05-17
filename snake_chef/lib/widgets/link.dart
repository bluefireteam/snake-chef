import 'package:flutter/material.dart';
import 'package:snake_chef/widgets/label.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String link;
  final double fontSize;
  final Color fontColor;

  Link({this.link, this.fontSize, this.fontColor});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onTap,
        child: Label(label: link, fontSize: fontSize, fontColor: fontColor),
      );

  void _onTap() async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
