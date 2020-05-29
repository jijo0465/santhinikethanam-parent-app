import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final VoidCallback onPressed;
  final ValueChanged<DragEndDetails> onDragEnd;
  final ValueChanged<DragUpdateDetails> onDrag;
  final double height;
  final VoidCallback onStudentTapped;
  const PageHeader(
      {Key key,
      this.onPressed,
      this.onDragEnd,
      this.onDrag,
      this.height,
      this.onStudentTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 60+MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.dashboard),
                  color: Colors.white,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'A J Central School',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                padding: EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {
                    print('Pressed');
                  },
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                ),
              )
            ],
          ),
          
          SizedBox(height: 4)
        ],
      ),
    );
  }
}


