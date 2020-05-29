import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback onPressed;
  final ValueChanged<DragEndDetails> onDragEnd;
  final ValueChanged<DragUpdateDetails> onDrag;
  final double height;
  final VoidCallback onStudentTapped;
  const ProfileHeader(
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
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragEnd: onDragEnd,
        onVerticalDragUpdate: onDrag,
        child: ClipPath(
            clipper: BackgroundClipper(),
            child: AnimatedContainer(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.grey[300],
                Colors.grey[100],
                Colors.grey[300]
              ])),
              duration: Duration(milliseconds: 400),
              curve: Curves.decelerate,
              child: Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: Consumer<StudentState>(
                          builder: (context, studentState, _) {
                        return studentState.selectedstudent == null
                            ? Container()
                            : IntrinsicHeight(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(flex: 1, child: Container()),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Hero(
                                        tag: studentState.selectedstudent.id
                                            .toString(),
                                        child: GestureDetector(
                                          onTap: onStudentTapped,
                                          child: Container(
                                            child: ClipOval(
                                                child: Image.asset(
                                                    studentState.selectedstudent
                                                        .photoUrl,
                                                    fit: BoxFit.fill)),
                                            height: height / 2.5,
                                            width: height / 2.5,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                      }),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          CupertinoIcons.right_chevron,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 40.0;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - roundnessFactor, size.width, size.height);
    // path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    // path.quadraticBezierTo(
    //     size.width, size.height - roundnessFactor, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
