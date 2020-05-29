import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_navbar.dart';
import 'package:parent_app/components/home_card.dart';
import 'package:parent_app/components/home_header.dart';
import 'package:parent_app/components/page_header.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/digi_home.dart';
import 'package:parent_app/screens/home_pages/chat.dart';
import 'package:parent_app/screens/home_pages/knowledge_db.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:parent_app/screens/knowledge_base.dart';
import 'package:parent_app/screens/chat_screen.dart';
import 'package:parent_app/screens/call.dart';

class HomePage extends DrawerContent {
  const HomePage({this.onPressed, this.title, Key key}) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navState = 0;
  double _height = 280.0;
  bool stateChanged = false;
  bool isLoading = true;
  Student selectedStudent;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
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
            : Stack(
                children: <Widget>[
                  PageView(
                    controller: _pageController,
                    children: <Widget>[
                      Container(
                        child: Consumer<StudentState>(
                            builder: (context, studentState, _) {
                          selectedStudent = studentState.selectedstudent;
                          return Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Colors.grey[300],
                                  Colors.grey[100],
                                  Colors.grey[300]
                                ])),
                              ),
                              Container(
                                  child: Column(children: <Widget>[
                                HomeHeader(
                                  onStudentTapped: () {
                                    isLoading = true;
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 400),
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
                                      if (dragUpdateDetails
                                              .globalPosition.distance >
                                          MediaQuery.of(context).size.height *
                                              0.7) {
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
                                          _height +=
                                              dragUpdateDetails.delta.dy *
                                                  log(dragUpdateDetails
                                                          .globalPosition
                                                          .distance /
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
                                  onPressed: () {
                                    drawerController.open();
                                  },
                                ),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 4),
                                            HomeCard(
                                              icon: Icon(
                                                CupertinoIcons.profile_circled,
                                                size: 35,
                                                color: Color(0xff00739e),
                                              ),
                                              text: 'Evaluate Student 360',
                                              isImportant: false,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/student_360');
                                              },
                                            ),
                                            SizedBox(width: 0),
                                            HomeCard(
                                              icon: Icon(Icons.view_carousel,
                                                  size: 35,
                                                  color: Color(0xff00739e)),
                                              text: 'Virtual Classroom',
                                              isImportant: false,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/classroom');
                                              },
                                            ),
                                            SizedBox(width: 4),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 4),
                                            HomeCard(
                                              icon: Icon(
                                                  CupertinoIcons
                                                      .video_camera_solid,
                                                  size: 35,
                                                  color: Colors.white),
                                              text: 'Live Class',
                                              isImportant: true,
                                              color: Colors.red[400],
                                              onPressed: () async {
                                                await Permission.camera
                                                    .request();
                                                await Permission.microphone
                                                    .request();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CallPage(
                                                      id: selectedStudent.id,
                                                    ),
                                                  ),
                                                );
                                                // Navigator.pushNamed(
                                                //     context, '/call');
                                              },
                                            ),
                                            HomeCard(
                                              icon: Icon(
                                                  CupertinoIcons.heart_solid,
                                                  size: 25,
                                                  color: Colors.red[900]),
                                              text: 'Value\nEducation',
                                              isImportant: false,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/value_edu');
                                              },
                                            ),
                                            HomeCard(
                                              icon: Icon(Icons.school,
                                                  size: 35,
                                                  color: Color(0xff00739e)),
                                              text: 'My School',
                                              isImportant: false,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/mySchool');
                                              },
                                            ),
                                            SizedBox(width: 4),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 4),
                                            HomeCard(
                                              icon: Icon(
                                                  CupertinoIcons.eye_solid,
                                                  size: 40,
                                                  color: Color(0xff00739e)),
                                              text: 'Academic Reports',
                                              isImportant: false,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/result');
                                              },
                                            ),
                                            HomeCard(
                                              icon: Icon(
                                                  Icons.accessibility_new,
                                                  size: 35,
                                                  color: Color(0xff00739e)),
                                              text: 'Scholorships',
                                              isImportant: false,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/scholarship');
                                              },
                                            ),
                                            SizedBox(
                                              width: 4,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 64)
                                    ],
                                  ),
                                )),
                              ])),
                            ],
                          );
                        }),
                      ),
                      KnowledgeBaseScreen(),
                      ChatScreen()
                    ],
                  ),
                  PageHeader(
                    onPressed: widget.onPressed,
                  ),
                  Positioned(
                      bottom: 4,
                      child: DigiBottomNavBar(
                        selected: navState,
                        onChanged: (value) async {
                          await _pageController.animateToPage(value,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                          setState(() {
                            navState = value;
                          });
                        },
                      ))
                ],
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
