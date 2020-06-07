import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:parent_app/components/digi_alert.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/home_header.dart';
import 'package:parent_app/components/my_school_card.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/icons.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class MySchoolScreen extends StatefulWidget {
  const MySchoolScreen({Key key}) : super(key: key);

  @override
  _MySchoolScreenState createState() => _MySchoolScreenState();
}

class _MySchoolScreenState extends State<MySchoolScreen> {
  // const _MySchoolScreenState({this.title, Key key}) : super(key: key);
  // final String title;

  // final List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  //   const StaggeredTile.count(5, 4.5),
  //   const StaggeredTile.count(5, 5),
  //   const StaggeredTile.count(5, 5.5),
  //   const StaggeredTile.count(5, 3.5),
  //   const StaggeredTile.count(5, 5),
  //   const StaggeredTile.count(5, 5.5),
  //   const StaggeredTile.count(5, 4.5),
  //   const StaggeredTile.count(5, 5.5),
  //   const StaggeredTile.count(5, 4.5),
  //   const StaggeredTile.count(5, 5),
  //   const StaggeredTile.count(5, 4),
  //   const StaggeredTile.count(5, 4.5),
  //   const StaggeredTile.count(5, 4),
  //   const StaggeredTile.count(5, 3.5),
  //   const StaggeredTile.count(5, 3.5),
  // ];

  final List<String> menuInfo = const <String>[
    'My ClassRoom',
    'Digital School Diary',
    'Student\nAttendance',
    'Track Bus',
    'Upcoming\nExams/Tests',
    'Request Student\nPerformance List',
    'Fee Payment',
    'Student\nIn/Out Info',
    'Student Remarks', //8
    'HomeWorks &\nAssignments',
    'School Event\nUpdates', //10
    'TimeTable',
    'School\nAdministrators', //12
    'Fee Structure', //13
    'Faculty Members', //14
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  double _height = 100.0;
  ScrollController _scrollController;
  // bool stateChanged = false;
  bool isLoading = false;
  bool isStudentSelected = false;
  Student selectedStudent;
  List<Student> studentsList = [];
  // int selectedId;
  int i;

  @override
  void initState() {
    // selectedId = 0;
    super.initState();

    _scrollController = new ScrollController();
    // _scrollController.addListener(() {
    //   double offset = _scrollController.offset;
    //   double _h = 240;
    //   if (_scrollController.offset <=
    //           _scrollController.position.minScrollExtent &&
    //       !_scrollController.position.outOfRange) {
    //     setState(() {
    //       _height = 240;
    //     });
    //   }
    //   if (offset < 240 && _height > 140) {
    //     setState(() {
    //       _height = _h - offset;
    //     });
    //   } else {
    //     setState(() {
    //       _height = 140;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    state.addListener(() {
      setSelectedStudent(state.selectedstudent);
    });
    selectedStudent = state.selectedstudent;
    return Scaffold(
      body: Container(
          child: Consumer<StudentState>(builder: (context, studentState, _) {
        studentsList.addAll(studentState.allstudents);
        selectedStudent = studentState.selectedstudent;
        if (isStudentSelected == false) {
          for (i = 0; i < studentState.allstudents.length; i++) {
            if (studentState.allstudents[i].id == studentState.selectedstudent.id) {
              print('$i');
              // selectedId = i;
              studentsList.removeAt(i);
              studentsList.insert(0, studentState.selectedstudent);
              break;
            }
            print(
                '2: ${studentsList[0].id}, ${studentsList[1].id}, ${studentsList[2].id},');
          }
        }
        return Stack(
          children: <Widget>[
            BackdropFilter(
              filter: isStudentSelected
                  ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    DigiCampusAppbar(title:'Santhinikethanam',icon: Icons.close,onDrawerTapped: (){
                      Navigator.of(context).pop();
                    },),
                    SizedBox(height: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/attendance.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/attendance');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/hw_assignment.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/homeworks');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath: 'assets/images/menu/fee.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/feePayment');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/timetable.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/timetable');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath: 'assets/images/menu/events.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/events');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath: 'assets/images/menu/admin.png',
                                  ),
                                  MySchoolCard(
                                    menuPath: 'assets/images/menu/faculty.png',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/digital_diary.png',
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/diary');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/track_bus.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/schoolbus');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath: 'assets/images/menu/exams.png',
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/exams');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/student_in_out.png',
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/inOut');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath: 'assets/images/menu/remarks.png',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/remarks');
                                    },
                                  ),
                                  MySchoolCard(
                                    menuPath:
                                        'assets/images/menu/fee_structure.png',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: isStudentSelected ? Colors.black.withOpacity(0.6) : null,
            ),
            DigiAlert(title: 'Santhinikethanam',text: 'Subscribe for the complete digital school experience!', icon: DigiIcons.school_alt,)
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     child: Row(children: <Widget>[
            //       Expanded(child: Container()),
            //       Container(
            //         // height: MediaQuery.of(context).padding.top +_height -_height/ 1.6,
            //         margin: EdgeInsets.only(
            //             top: MediaQuery.of(context).padding.top +
            //                 _height -
            //                 _height / 1.6 -
            //                 16),
            //         child: Column(
            //           children: List.generate(studentState.allstudents.length,
            //               (index) {
            //             // student = studentState.allstudents[index];
            //             // student = studentState.allstudents[selectedId];

            //             return Column(
            //               children: <Widget>[
            //                 AnimatedContainer(
            //                   curve: Curves.easeInOut,
            //                   duration: Duration(
            //                       milliseconds: isStudentSelected ? 400 : 0),
            //                   height: index == 0
            //                       ? _height / 1.6
            //                       : isStudentSelected ? _height / 1.6 : 0,
            //                   child: GestureDetector(
            //                     behavior: HitTestBehavior.translucent,
            //                     onTap: () {
            //                       setState(() {
            //                         isStudentSelected = !isStudentSelected;
            //                       });
            //                       // setState(() {
            //                         // state.setStudent(studentState.allstudents
            //                         //       .elementAt(index));
            //                         if (isStudentSelected == true) {
            //                           state.setStudent(
            //                               studentsList.elementAt(index));
            //                           // isStudentSelected = false;
            //                           // selectedId = index;
            //                           // student = studentState.allstudents[index];
            //                         } 
            //                         // else
            //                         //   isStudentSelected = true;
            //                       // });
            //                     },
            //                     child: Container(
            //                       child: ClipOval(
            //                           child: Image.asset(
            //                               studentsList[index].photoUrl,
            //                               // index == 0 ?studentsList[index].photoUrl
            //                               // : index != selectedId
            //                               // ? studentState.allstudents[index].photoUrl
            //                               // : index < selectedId
            //                               // ? studentState.allstudents[index].photoUrl
            //                               // : studentState.allstudents[index-1].photoUrl,
            //                               fit: BoxFit.fill)),
            //                       height: _height / 1.6,
            //                       width: _height / 1.6,
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: isStudentSelected ? 12 : 0,
            //                 )
            //               ],
            //             );
            //           }),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 8,
            //       ),
            //     ])),
            // Container(
            //   // color: Colors.grey,
            //   // height: _height + MediaQuery.of(context).padding.top + 2*(_height/ 1.6) + 16,
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(child: Container()),
            //       Container(
            //         // width: 40,
            //         // height: 80,
            //         // color: Colors.black,
            //         child: AnimatedList(
            //           physics: NeverScrollableScrollPhysics(),
            //           key: _listKey,
            //             initialItemCount: 3,
            //             itemBuilder: (context, index, animation) {
            //               return Container(height: 50,width: 50,);
            //               // return studentsList(
            //               //     studentState.allstudents[index]);
            //             }),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        );
      })),
    );
  }

  // Widget studentsList(Student student) {
  //   // // i = selectedStudent.
  //   // for (i = 0; i < studentState.allstudents.length; i++) {
  //   //   if(studentState.allstudents[i].id == studentState.selectedstudent.id)
  //   //     id = i;
  //   // }
  //   print('ajith');
  //   print('${student.id}');
  //   return Column(
  //     children: <Widget>[
  //       SizedBox(
  //           height:
  //               _height - MediaQuery.of(context).padding.top - _height / 3.2),
  //       AnimatedContainer(
  //         duration: Duration(milliseconds: 400),
  //         height: isStudentSelected ? 50 : 0,
  //         child: GestureDetector(
  //           onTap: () {
  //             _listKey.currentState.insertItem(1);
  //           },
  //           child: Container(
  //             child: ClipOval(
  //                 child: Image.asset(student.photoUrl, fit: BoxFit.fill)),
  //             height: _height / 1.6,
  //             width: _height / 1.6,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void setSelectedStudent(Student student) async {
    selectedStudent = student;
    if (selectedStudent != null) {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 30.0;
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
