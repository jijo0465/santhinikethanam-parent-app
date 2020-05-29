import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isImportant;
  final String text;
  final VoidCallback onPressed;
  const StudentCard({Key key, this.child, this.color, this.isImportant, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: Card(
          color: Colors.white,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side:
                  BorderSide(color: Colors.black12)),
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: child,
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
