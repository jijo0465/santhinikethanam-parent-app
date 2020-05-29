import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class DigiAppbar extends StatelessWidget {
  final VoidCallback onPressed;
  final ValueChanged<DragEndDetails> onDragEnd;
  final ValueChanged<DragUpdateDetails> onDrag;
  final double height;
  final VoidCallback onStudentTapped;
  const DigiAppbar(
      {Key key,
      this.onPressed,
      this.onDragEnd,
      this.onDrag,
      this.height,
      this.onStudentTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragEnd: onDragEnd,
      onVerticalDragUpdate: onDrag,
      child: ClipPath(
          clipper: BackgroundClipper(),
          child: AnimatedContainer(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/school.jpg'),
                    fit: BoxFit.fill)),
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
                              'A J Central',
                              style: TextStyle(
                                  fontSize: 17,
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
                    //Expanded(child: Hero(tag: 'background', child: Container())),
                    Expanded(
                      child: Consumer<StudentState>(
                          builder: (context, studentState, _) {
                        return studentState.selectedstudent == null
                            ? Container()
                            : Row(
                                // mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(left: 12),
                                      alignment: Alignment.bottomLeft,
                                      height: 60,
                                      child: Text(
                                        studentState.selectedstudent.name,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            color: Colors.white),
                                      )),
                                  Hero(
                                    tag: studentState.selectedstudent.id.toString(),
                                    child: GestureDetector(
                                      onTap: onStudentTapped,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 12),
                                        child: ClipOval(
                                            child: Image.asset(
                                                studentState.selectedstudent.photoUrl,
                                                fit: BoxFit.fill)),
                                        height: height/4.16,
                                        width: height/4.16,
                                      ),
                                    ),
                                  )
                                ],
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
            ),
          )),
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
    path.quadraticBezierTo(0, size.height - roundnessFactor, roundnessFactor,
        size.height - roundnessFactor);
    path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width, size.height - roundnessFactor, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
