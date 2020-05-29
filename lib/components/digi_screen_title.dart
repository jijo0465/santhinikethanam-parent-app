import 'package:flutter/material.dart';

class DigiScreenTitle extends StatelessWidget {
  final String text;
  const DigiScreenTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blue[800]),
        ));
  }
}
