import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class HomeScreen extends DrawerContent {
  HomeScreen({Key key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

HiddenDrawerController drawerController;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    drawerController = HiddenDrawerController(
      initialPage: HomePage(
        title: 'main',
      ),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
        ),
        DrawerItem(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () async {
            await Navigator.of(context).pushNamed('/settings');
            drawerController.close();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState value, Widget child) {
        if (value.status == Status.Unauthenticated) {
          return LoginScreen();
        } else {
          return Scaffold(
            body: HiddenDrawer(
              controller: drawerController,
              header: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 66,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/images/sir.jpg',
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Rachel green',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            RaisedButton(
                                child: Text('Signout'),
                                onPressed: () {
                                  value.signOut();
                                })
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 34, child: Container())
                  ],
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[300], Colors.blue[800], Colors.blue],
                  // tileMode: TileMode.repeated,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
// Consumer<StudentState>(
//                           builder: (context, studentState, _) {
//                         if(isFlag) {
//                         studentState.setStudent(
//                           Student().fromMap(
//                               '{"id":1001,"name":"Karthyaaayini","parentName":"Ajith"}'),
//                           );
//                           isFlag=false;
//                         }
//                         return

class HomePage extends DrawerContent {
  const HomePage({this.title, Key key}) : super(key: key);
  final String title;

  // @override
  // static final List<IconData> _menuIcons = [
  //   Icons.accessibility_new,
  //   Icons.account_balance,
  //   Icons.account_box,
  //   Icons.add_a_photo,
  //   Icons.adjust,
  //   Icons.airplanemode_active
  // ];

  final List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(5, 4.5),
    const StaggeredTile.count(5, 5),
    const StaggeredTile.count(5, 5.5),
    const StaggeredTile.count(5, 3.5),
    const StaggeredTile.count(5, 5),
    const StaggeredTile.count(5, 5.5),
    const StaggeredTile.count(5, 4.5),
    const StaggeredTile.count(5, 5.5),
    const StaggeredTile.count(5, 4.5),
    const StaggeredTile.count(5, 5),
    const StaggeredTile.count(5, 4),
    const StaggeredTile.count(5, 4.5),
    const StaggeredTile.count(5, 4),
    const StaggeredTile.count(5, 3.5),
    const StaggeredTile.count(5, 3.5),
  ];

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

  // static final List<Map<String, String>> _menuInfo = [
  //   {'title': 'Academics', 'subtitle': '90%', 'value': 'Check Result'},
  //   {'title': 'Bus No', 'subtitle': '15', 'value': 'Track School Bus'},
  //   {'title': 'Exam', 'subtitle': 'Mar 8th', 'value': 'Upcoming Exams'},
  //   {'title': 'Remarks', 'subtitle': '12', 'value': 'Write Remarks to Teacher'},
  //   {'title': 'Tasks', 'subtitle': '8', 'value': 'Digital School Diary'},
  //   {'title': 'Due Date', 'subtitle': 'Jan 12', 'value': 'Pay School Fees'}
  // ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ScrollController _pageController;
  int pageNo = 0;
  //double _schoolImageHeight = 0.0;
  //double _opacity = 0.0;
  double _height = 240.0;
  ScrollController _scrollController;
  bool stateChanged = false;
  bool isLoading = false;
  Student selectedStudent;
  // int count = 8;

  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double _h = 240;
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _height = 240;
        });
      }
      // print("This is offset");
      // print(_scrollController.positions.last.pixels);
      // if (_height > 140) {
      //   setState(() {
      //     _height -= _scrollController.offset * 0.1 ;
      //   });
      // }
      if (offset < 240 && _height > 140) {
        setState(() {
          _height = _h - offset;
          //_opacity = offset / 140;
        });
        // print(offset);
      } else {
        setState(() {
          _height = 140;
          //_opacity = offset / 140;
        });
      }
      // else if((offset>0)&&(offset+_h>0)) {
      //   if(_height>10)
      //   setState(() {
      //     _height-= offset;//0-20
      //   });
      //   else {
      //     _height=10;
      //   }
      // }
      // else
      // {
      //   setState(() {
      //     _top = offset + _h;
      //     _opacity = offset * 120;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    state.addListener(() {
      setSelectedStudent(state.selectedstudent);
    });
    selectedStudent = state.selectedstudent;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('About'))
        ]),
        body: Container(
                child:
                    Consumer<StudentState>(builder: (context, studentState, _) {
                  selectedStudent = studentState.selectedstudent;
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                          Colors.blue[100],
                          Colors.blue[100],
                          Colors.blue[300],
                          Colors.blue[400]
                        ])
                            // image: DecorationImage(
                            //     image: AssetImage(
                            //         'assets/images/blue_gradient.jpg'),
                            //     fit: BoxFit.cover)
                            ),
                      ),
                      Container(
                          child: Column(children: <Widget>[
                        DigiAppbar(
                          onStudentTapped: () {
                            // isLoading = true;
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
                                _height = 240;

                              });
                            }
                          },
                          onDrag: (dragUpdateDetails) {
                            // print(dragUpdateDetails.globalPosition.distance);
                            // print(dragUpdateDetails.globalPosition.dy);
                            if (dragUpdateDetails.delta.dy > 0) {
                              if (dragUpdateDetails.globalPosition.distance >
                                  350) {
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
                          onPressed: () {
                            drawerController.open();
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Container(
                              // decoration: BoxDecoration(
                              //   gradient: SweepGradient(colors: [Colors.blue[100],Colors.blue[200],Colors.blue[300]])
                              // ),
                              child: Column(children: [
                                // SizedBox(
                                //   height: _height<240?_height==140?0:240-_height:0,
                                // ),
                                AnimatedPadding(
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 650),
                                  padding: EdgeInsets.only(
                                      top: _height < 240
                                          ? _height == 140 ? 0 : 240 - _height
                                          : 0),
                                  child: Container(
                                    //height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: StaggeredGridView.countBuilder(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      scrollDirection: Axis.vertical,
                                      crossAxisCount: 10,
                                      itemCount: 15,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              new DigiMenuCard(
                                        imagePath:
                                            'assets/images/menu_$index.png',
                                        text: widget.menuInfo.elementAt(index),
                                        alignText: (index == 3 ||
                                                index == 8 ||
                                                index == 10 ||
                                                index == 12 ||
                                                index == 13 ||
                                                index == 14)
                                            ? true
                                            : false,
                                        textScale: (index == 0 ||
                                                index == 1 ||
                                                index == 2 ||
                                                index == 3)
                                            ? 1.1
                                            : 0.85,
                                        // begin: (index % 3 == 0)
                                        //     ? Alignment.bottomLeft
                                        //     : (index % 3 == 1)
                                        //         ? Alignment.topRight
                                        //         : Alignment.bottomRight,
                                        // end: (index % 3 == 0)
                                        //     ? Alignment.topRight
                                        //     : (index % 3 == 1)
                                        //         ? Alignment.bottomLeft
                                        //         : Alignment.topLeft,
                                        onPressed: () {
                                          switch (index) {
                                            case 0:
                                              Navigator.of(context)
                                                  .pushNamed('/classroom');
                                              break;
                                            case 1:
                                              Navigator.of(context)
                                                  .pushNamed('/diary');
                                              break;
                                            case 2:
                                              Navigator.of(context)
                                                  .pushNamed('/attendance');
                                              break;
                                            case 3:
                                              Navigator.of(context)
                                                  .pushNamed('/schoolbus');
                                              break;
                                            case 4:
                                              Navigator.of(context)
                                                  .pushNamed('/exams');
                                              break;
                                            case 5:
                                              Navigator.of(context)
                                                  .pushNamed('/result');
                                              break;
                                            case 6:
                                              Navigator.of(context)
                                                  .pushNamed('/feePayment');
                                              break;
                                            case 7:
                                              Navigator.of(context)
                                                  .pushNamed('/inOut');
                                              break;
                                            case 8:
                                              Navigator.of(context)
                                                  .pushNamed('/remarks');
                                              // Navigator.of(context)
                                              //     .pushNamed('/ratings');
                                              break;
                                            case 9:
                                              Navigator.of(context)
                                                  .pushNamed('/homeworks');
                                              break;
                                            case 10:
                                              Navigator.of(context)
                                                  .pushNamed('/events');
                                              break;
                                            case 11:
                                              Navigator.of(context)
                                                  .pushNamed('/timetable');
                                              break;
                                              // case 10:
                                              //   Navigator.of(context).pushNamed('/')
                                              // case 7:
                                              //   setState(() {
                                              //     _diarySelected =
                                              //         !_diarySelected;
                                              //     print(_diarySelected);
                                              //     _scrollController.animateTo(
                                              //         _scrollController.position
                                              //             .maxScrollExtent,
                                              //         duration: Duration(
                                              //             milliseconds: 300),
                                              //         curve: Curves.linear);
                                              //   });
                                              break;
                                          }
                                        },
                                        // menuIcon: HomePage._menuIcons[
                                        //     index], //_menuIcons(index),
                                        // title: HomePage._menuInfo[index]
                                        //     ['title'], //'Bus No',
                                        // subtitle: HomePage
                                        //     ._menuInfo[index]['subtitle'],
                                        // value: HomePage._menuInfo[index]
                                        //     ['value']
                                      ),
                                      staggeredTileBuilder: (int index) =>
                                          widget._staggeredTiles
                                              .elementAt(index),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Container(
                                //     padding: EdgeInsets.only(left: 12),
                                //     alignment: Alignment.centerLeft,
                                //     child: Text(
                                //       'Digital School Diary',
                                //       textAlign: TextAlign.start,
                                //     )),
                                // SizedBox(height: 12),
                                // Container(
                                //   height: 160,
                                //   //width: MediaQuery.of(context).size.width-6,
                                //   child: GridView.count(
                                //     mainAxisSpacing: 5,
                                //     scrollDirection: Axis.horizontal,
                                //     crossAxisCount: 1,
                                //     shrinkWrap: false,
                                //     children: List.generate(6, (index) {
                                //       return DigiMenuCard(
                                //           imagePath: 'assets/images/sir.jpg',
                                //           onPressed: () {
                                //             switch (index) {
                                //               case 0:
                                //                 Navigator.of(context)
                                //                     .pushNamed('/timetable');
                                //                 break;
                                //               case 1:
                                //                 Navigator.of(context)
                                //                     .pushNamed('/homeworks');
                                //                 break;
                                //               case 2:
                                //                 Navigator.of(context)
                                //                     .pushNamed('/events');
                                //                 break;
                                //             }
                                //           },
                                //           // menuIcon: HomePage._menuIcons[
                                //           //     index], //_menuIcons(index),
                                //           // title: HomePage._menuInfo[index]
                                //           //     ['title'], //'Bus No',
                                //           // subtitle: HomePage._menuInfo[index]
                                //           //     ['subtitle'],
                                //           // value: HomePage._menuInfo[index]
                                //           //     ['value']
                                //               );
                                //     }),
                                //   ),
                                // ),
                                //SizedBox(height: 120)
                              ]),
                            ),
                          ),
                        ),
                      ])),
                      // AnimatedPositioned(
                      //   bottom: 100,
                      //   duration: Duration(milliseconds: 300),
                      //   child: _diarySelected
                      //       ? BackdropFilter(
                      //           filter:
                      //               ImageFilter.blur(sigmaY: 2.5, sigmaX: 2.5),
                      //           child: Column(
                      //             children: <Widget>[
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   setState(() {
                      //                     _diarySelected = !_diarySelected;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                     width:
                      //                         MediaQuery.of(context).size.width,
                      //                     alignment: Alignment.topRight,
                      //                     child: Icon(Icons.close,
                      //                         color: Colors.white)),
                      //               ),
                      //               Container(
                      //                   // alignment: Alignment.center,
                      //                   padding: EdgeInsets.all(12),
                      //                   // margin: EdgeInsets.symmetric(horizontal: 40),
                      //                   width:
                      //                       MediaQuery.of(context).size.width -
                      //                           40,
                      //                   height: 280,
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.all(
                      //                         Radius.circular(12)),
                      //                     color: Colors.white38,
                      //                   ),
                      //                   child: GridView.count(
                      //                       padding: EdgeInsets.all(0),
                      //                       physics:
                      //                           NeverScrollableScrollPhysics(),
                      //                       mainAxisSpacing: 5,
                      //                       crossAxisSpacing: 5,
                      //                       //scrollDirection: Axis.horizontal,
                      //                       crossAxisCount: 2,
                      //                       shrinkWrap: true,
                      //                       children: List.generate(4, (index) {
                      //                         return DigiMenuCard(
                      //                             imagePath:
                      //                                 'assets/images/sir.jpg',
                      //                             onPressed: () {
                      //                               switch (index) {
                      //                                 case 0:
                      //                                   Navigator.of(context)
                      //                                       .pushNamed(
                      //                                           '/timetable');
                      //                                   break;
                      //                                 case 1:
                      //                                   Navigator.of(context)
                      //                                       .pushNamed(
                      //                                           '/homeworks');
                      //                                   break;
                      //                                 case 2:
                      //                                   Navigator.of(context)
                      //                                       .pushNamed(
                      //                                           '/events');
                      //                                   break;
                      //                                 case 3:
                      //                                   Navigator.of(context)
                      //                                       .pushNamed(
                      //                                           '/remarks');
                      //                                   break;
                      //                               }
                      //                             });
                      //                       }))),
                      //             ],
                      //           ))
                      //       : Container(),
                      // )
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
