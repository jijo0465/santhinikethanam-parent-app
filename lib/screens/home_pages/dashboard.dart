import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_alert.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/screens/student_profile_screen.dart';
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
import 'package:parent_app/screens/icons.dart';

class HomePage extends DrawerContent {
  const HomePage({this.onPressed, this.title, Key key}) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navState = 0;
  double _height = 240.0;
  bool stateChanged = false;
  bool isLoading = false;
  Student selectedStudent;
  PageController _pageController;
  bool showSubscribeAlert = false;
  double roundnessFactor = 40.0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
//    state.addListener(() {
//      setSelectedStudent(state.selectedstudent);
//    });
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
                                  roundnessFactor: roundnessFactor,
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
                                        roundnessFactor = 40;
                                        _height = 300;
                                      });
                                    }
                                  },
                                  onDrag: (dragUpdateDetails) {

                                     print(dragUpdateDetails.globalPosition.distance);
                                    // print(dragUpdateDetails.globalPosition.dy);
                                    if (dragUpdateDetails.delta.dy > 0) {
                                      if (dragUpdateDetails
                                              .globalPosition.distance >
                                          MediaQuery.of(context).size.height *
                                              0.7) {
//                                        roundnessFactor = 40;
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 400),
                                            pageBuilder: (_, __, ___) =>
                                                StudentDetailsScreen(),
//                                          StudentProfileScreen()
                                          ),
                                        ).then((value) {
                                          // setState(() {
                                          //   pageNo = StudentDetailsScreen.pageNo;
                                          // });
                                        });
                                      } else {
                                        setState(() {
                                          roundnessFactor = roundnessFactor - dragUpdateDetails.delta.dy;
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
                                                DigiIcons.student360_alt,
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
                                              icon: Icon(DigiIcons.virtual_class,
                                                  size: 40,
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
                                              icon: Icon(DigiIcons.school,
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
                                                  DigiIcons.noun_analytics_1014757,
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
                                                  DigiIcons.school_alt,
                                                  size: 45,
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
                                      SizedBox(height: 42)
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
//                  PageHeader(
//                    onPressed: widget.onPressed,
//                  ),
                  DigiCampusAppbar(icon: null,onDrawerTapped: widget.onPressed,title: 'Santhinikethanam',),
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
                      )),

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
