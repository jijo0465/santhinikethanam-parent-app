import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final Widget icon;
  final Color color;
  final bool isImportant;
  final String text;
  final VoidCallback onPressed;
  const HomeCard({Key key, this.icon, this.color, this.isImportant, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side:
                  BorderSide(color: isImportant ? Colors.red : Colors.black12)),
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 2,
                    ),
                    icon,
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          isImportant ? 'Enter\nLive Class' : text,
                          style: TextStyle(
                              fontSize: 12,
                              color: isImportant
                                  ? Colors.white.withOpacity(0.8)
                                  : Color(0xff00739e)),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
