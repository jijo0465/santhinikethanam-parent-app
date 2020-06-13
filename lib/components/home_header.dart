import 'dart:io';
import 'dart:math';
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
  final double roundnessFactor;
  final VoidCallback onStudentTapped;
  const HomeHeader(
      {Key key,
      this.onPressed,
      this.onDragEnd,
      this.onDrag,
      this.height,
      this.onStudentTapped,
        this.roundnessFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragEnd: onDragEnd,
        onVerticalDragUpdate: onDrag,
        child: ClipPath(
            clipper: BackgroundClipper(roundnessFactor),
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
                      SizedBox(height: 30+MediaQuery.of(context).padding.top),

                      Expanded(
                        child: Consumer<StudentState>(
                            builder: (context, studentState, _) {
                              print(studentState.selectedstudent.photoUrl);
                          return studentState.selectedstudent == null
                              ? Container()
                              : IntrinsicHeight(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            titleCase(studentState.selectedstudent.name)
                                            ,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(

                                                decoration: TextDecoration.none,
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                          SizedBox(width: 4,),
                                      Expanded(
                                        child: Hero(
                                          tag: studentState.selectedstudent.id.toString(),
                                          child: GestureDetector(
                                            onTap: onStudentTapped,
                                            child: Container(
                                              child: ClipOval(
                                                  child: studentState.selectedstudent.photoUrl==null||
                                                      studentState.selectedstudent.photoUrl==''?
                                                  Image.asset('assets/images/user.png',color: Colors.black87,):

                                                      Image(image: FileImage(File(studentState.selectedstudent.photoUrl)),fit: BoxFit.cover,)
//                                                  File(studentState.selectedstudent.photoUrl)
//                                                  Image.asset(
//                                                      studentState.selectedstudent.photoUrl,
//                                                      fit: BoxFit.cover)
                                              ),
                                              height: height/2.5*1-log(height),
                                              width: height/2.5*1-log(height),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Container(
//                                        width: 120,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${studentState.selectedstudent.grade.standardInRoman}  ${studentState.selectedstudent.grade.division}',
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'Present : 0%',
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
  String titleCase(String text) {
    text = text.toLowerCase();
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  double roundnessFactor ;

  BackgroundClipper(this.roundnessFactor);
  @override
  Path getClip(Size size) {
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
