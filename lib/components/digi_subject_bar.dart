import 'package:flutter/material.dart';

class DigiSubjectBar extends StatelessWidget {
  final int index;
  final String title;
  final VoidCallback onPressed;
  bool isSelected = false;
  DigiSubjectBar({Key key, this.index, this.onPressed, this.isSelected, this.title})
      : super(key: key);

  static List<Map<String, String>> subjects = [
    {'no': '0', 'sub': 'All'},
    {'no': '1', 'sub': 'Maths'},
    {'no': '2', 'sub': 'English'},
    {'no': '3', 'sub': 'Social'},
    {'no': '4', 'sub': 'Science'},
    {'no': '5', 'sub': 'Malayalam'},
    {'no': '6', 'sub': 'Hindi'}
  ];
  static Color borderColor = Colors.deepOrange[200],
      textColor = Colors.black54,
      backgroundColor = Colors.white38,
      indexBackgroundColor = Colors.deepOrange[200];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 80,
            height: 80,
            //margin: EdgeInsets.only(right: 3, top: 2, bottom: 2,left: 3),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.blueGrey,
                        blurRadius: 4,
                        spreadRadius: 0.4,
                      )
                    ]
                  : null,
              //color: (isSelected)?indexBackgroundColor:backgroundColor,
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: isSelected
                      ? ([
                          Colors.deepOrange[300],
                          Colors.deepOrange[200],
                          Colors.deepOrange[100]
                        ])
                      : ([Colors.white, Colors.white54, Colors.white10])),
              border: Border.all(
                  color: borderColor, style: BorderStyle.solid, width: 2.0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(title != null
              ? title
              : DigiSubjectBar.subjects[index]['sub'],
              style: TextStyle(
                  color: (isSelected) ? Colors.white : textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              textScaleFactor: 0.60,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            )));
  }
}
