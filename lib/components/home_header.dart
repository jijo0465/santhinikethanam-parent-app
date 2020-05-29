import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/page_header.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onPressed;
  final ValueChanged<DragEndDetails> onDragEnd;
  final ValueChanged<DragUpdateDetails> onDrag;
  final double height;
  final VoidCallback onStudentTapped;
  const HomeHeader(
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
                  color: Color(0xff00739e)),
              duration: Duration(milliseconds: 400),
              curve: Curves.decelerate,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                child: Container(
                  padding: EdgeInsets.only(top:35),
                  color: Colors.blue.withOpacity(0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 60+MediaQuery.of(context).padding.top),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Container(
                      //       child: IconButton(
                      //         onPressed: onPressed,
                      //         icon: Icon(Icons.dashboard),
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     Container(
                      //         padding: EdgeInsets.only(left: 12),
                      //         child: Text(
                      //           'Christ Nagar',
                      //           style: TextStyle(
                      //               fontSize: 15,
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w600),
                      //         )),
                      //     Container(
                      //       padding: EdgeInsets.only(right: 12),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           print('Pressed');
                      //         },
                      //         icon: Icon(Icons.notifications),
                      //         color: Colors.white,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Expanded(
                        child: Consumer<StudentState>(
                            builder: (context, studentState, _) {
                          return studentState.selectedstudent == null
                              ? Container()
                              : IntrinsicHeight(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  studentState.selectedstudent.name,
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'Id : 224578',
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 11,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                            ),
                                      ),
                                          SizedBox(width: 12,),
                                      Hero(
                                        tag: studentState.selectedstudent.id.toString(),
                                        child: GestureDetector(
                                          onTap: onStudentTapped,
                                          child: Container(
                                            child: ClipOval(
                                                child: Image.asset(
                                                    studentState.selectedstudent.photoUrl,
                                                    fit: BoxFit.fill)),
                                            height: height/2.5,
                                            width: height/2.5,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12,),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'V B',
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'Present : 80%',
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 11,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                            ),
                                      )
                                    ],
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
                      SizedBox(height: 20)
                    ],
                  ),
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
    path.quadraticBezierTo(size.width/2, size.height - roundnessFactor, size.width,
        size.height);
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
