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
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                          child: Column(children: <Widget>[
                        ProfileHeader(
                          onStudentTapped: () {
                            isLoading = true;
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 400),
                                pageBuilder: (_, __, ___) =>
                                    StudentDetailsScreen(),
                              ),
                            ).then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                          height: _height,
                          onDragEnd: (_) {
                            print(_height);
                            if (_height < 600) {
                              setState(() {
                                _height = 300;
                              });
                            }
                          },
                          onDrag: (dragUpdateDetails) {
                            // print(dragUpdateDetails.globalPosition.distance);
                            // print(dragUpdateDetails.globalPosition.dy);
                            if (dragUpdateDetails.delta.dy > 0) {
                              if (dragUpdateDetails.globalPosition.distance >
                                  MediaQuery.of(context).size.height * 0.7) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 400),
                                    pageBuilder: (_, __, ___) =>
                                        StudentDetailsScreen(),
                                  ),
                                ).then((value) {
                                  // setState(() {
                                  //   pageNo = StudentDetailsScreen.pageNo;
                                  // });
                                });
                              } else {
                                setState(() {
                                  _height += dragUpdateDetails.delta.dy *
                                      log(dragUpdateDetails
                                              .globalPosition.distance /
                                          175);
                                });
                              }
                            }
                            // else {
                            //   if (_height > 251) {
                            //     setState(() {
                            //       _height += dragUpdateDetails.delta.dy;
                            //     });
                            //   }
                            // }
                          },
                         
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(12),
                        )),
                      ])),
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
