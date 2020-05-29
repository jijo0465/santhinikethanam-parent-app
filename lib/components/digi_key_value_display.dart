import 'package:flutter/material.dart';

class DigiKeyValueDisplay extends StatelessWidget {
  final String textKey,textValue;
  final Color textColor;
  const DigiKeyValueDisplay({Key key, this.textKey, this.textValue, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
            child: Container(
                alignment: Alignment.topRight,
                child: Text(textKey,
                    style: TextStyle(color: textColor,fontSize: 16)))),
        Container(child: Text(' :  ',
                    style: TextStyle(color: textColor,fontSize: 16))),
        Expanded(child: Container(child: Text(textValue,
                    style: TextStyle(color: textColor,fontSize: 16))))
      ],
    ));
  }
}
