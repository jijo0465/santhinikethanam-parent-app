import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/components/home_card.dart';
import 'package:parent_app/components/home_header.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:parent_app/components/profile_header.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({this.title, Key key}) : super(key: key);
  final String title;

  @override
  _StudentProfileScreen createState() => _StudentProfileScreen();
}

class _StudentProfileScreen extends State<StudentProfileScreen> {
  int pageNo = 0;

  double _height = 300.0;
  bool stateChanged = false;
  bool isLoading = false;
  Student selectedStudent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    state.addListener(() {
      setSelectedStudent(state.selectedstudent);
    });
    selectedStudent = state.selectedstudent;

    return Scaffold(
        body: isLoading
            ? Container(
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        )
            : Container(
          child:
          Consumer<StudentState>(builder: (context, studentState, _) {
            selectedStudent = studentState.selectedstudent;
            return Stack(
              children: <Widget>[
                Container(
//                  padding: EdgeInsets.only(top: 35),
                  height: 300,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: Image.asset(
                    'assets/images/school.jpg',
                    fit: BoxFit.cover,

                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
                  child: Container(
                      child: Column(children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).padding.top+20,),
                        Text(studentState.selectedstudent.name,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Container(
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
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  child: ClipOval(
                                      child: Image.asset(
                                          studentState.selectedstudent
                                              .photoUrl,
                                          fit: BoxFit.cover)),
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
                        SizedBox(height: 20,),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0)),
                                color: Colors.white,
                              ),

                              padding: EdgeInsets.all(12),
                            )),
                      ])),
                ),
              ],
            );
          }),
        ));
  }

  void setSelectedStudent(Student student) async {
    selectedStudent = student;
    if (selectedStudent != null) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
