import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_alert.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digi_subject_bar.dart';
import 'package:parent_app/components/digi_graph_chart.dart';
import 'package:parent_app/components/digi_time_line.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/screens/icons.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/student_state.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

enum Subjects { All, Mathematics, English, Social, Science, Malayalam, Hindi }

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Subjects selectedSubject = Subjects.All;
  static List<String> titleList = [
    'Overall Performance',
    'Maths',
    'English',
    'Social',
    'Science',
    'Malayalam',
    'Hindi'
  ];
  String title = titleList.first;
  //String percentTitle = titleList.first;
  int subjectIndex = 0;
  double percentValue = 0.95;
  double percentage;
  bool showTimeline = false;
  bool isLoading = false;
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: -500);
    _controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    percentage = percentValue * 100;
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Result',
        //         style: TextStyle(
        //             backgroundColor: Colors.blue,
        //             color: Colors.black87,
        //             fontWeight: FontWeight.bold))),
        body: isLoading
            ? Container()
            : Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: <Widget>[
                      AnimatedPadding(
                          padding: EdgeInsets.only(
                              top: showTimeline
                                  ? 60 - MediaQuery.of(context).padding.top
                                  : 100),
                          duration: Duration(milliseconds: 400)),
                      DigiScreenTitle(text: 'Academic Performances'),
                      SizedBox(height: 12),
                      // Container(
                      //   margin: EdgeInsets.only(left: 5),
                      //     child: LinearPercentIndicator(
                      //   percent: 0.9,
                      //   center: Text(title + '\t:\t$percentage%',
                      //       style: TextStyle(fontSize: 12.0)),
                      //   width: MediaQuery.of(context).size.width - 10,
                      //   lineHeight: 15.0,
                      //   animation: true,
                      //   animationDuration: 600,
                      //   backgroundColor: Colors.grey,
                      //   progressColor: (percentValue >= 0.90)
                      //       ? Colors.green[900]
                      //       : (percentValue >= 0.80
                      //           ? Colors.green[700]
                      //           : (percentValue >= 0.70)
                      //               ? Colors.orangeAccent
                      //               : (percentValue >= 0.60)
                      //                   ? Colors.yellow[400]
                      //                   : Colors.red),
                      // )),
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(titleList.length, (index) {
                                  return DigiSubjectBar(
                                    index: index,
                                    isSelected: index == subjectIndex,
                                    onPressed: () {
                                      title = titleList.elementAt(index);
                                      switch (index) {
                                        case 0:
                                          setState(() {
                                            selectedSubject = Subjects.All;
                                            subjectIndex = 0;
                                          });
                                          break;
                                        case 1:
                                          setState(() {
                                            selectedSubject =
                                                Subjects.Mathematics;
                                            subjectIndex = 1;
                                          });
                                          break;
                                        case 2:
                                          setState(() {
                                            selectedSubject = Subjects.English;
                                            subjectIndex = 2;
                                          });
                                          break;
                                        case 3:
                                          setState(() {
                                            selectedSubject = Subjects.Social;
                                            subjectIndex = 3;
                                          });
                                          break;
                                        case 4:
                                          setState(() {
                                            selectedSubject = Subjects.Science;
                                            subjectIndex = 4;
                                          });
                                          break;
                                        case 5:
                                          setState(() {
                                            selectedSubject =
                                                Subjects.Malayalam;
                                            subjectIndex = 5;
                                          });
                                          break;
                                        case 6:
                                          setState(() {
                                            selectedSubject = Subjects.Hindi;
                                            subjectIndex = 6;
                                          });
                                          break;
                                      }
                                    },
                                  );
                                }),
                              ))),
                      //SizedBox(height: 12),
                      Container(
                          margin: EdgeInsets.only(top: 12),
                          height: 24,
                          alignment: Alignment.topCenter,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                //backgroundColor: Colors.black26,
                                color: Colors.blue[900]),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 300,
                        width: (MediaQuery.of(context).size.width) - 20,
                        child: Charts(index: subjectIndex),
                      ),
                      SizedBox(height: 12),
                    ]),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 400),
                    top: showTimeline
                        ? 180
                        : MediaQuery.of(context).size.height - 48,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onVerticalDragStart: (details) {
                            setState(() {
                              showTimeline = !showTimeline;
                            });
                          },
                          onTap: () {
                            setState(() {
                              showTimeline = !showTimeline;
                            });
                          },
                          child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.9)
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                padding: EdgeInsets.only(left: 12, right: 12),
                                height: 40,
                                width: 120,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                        '${selectedSubject.toString().replaceFirst('Subjects.', '')}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red[300],
                                        )),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        CupertinoIcons.forward,
                                        size: 16,
                                        color: Colors.red[300],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, bottom: 70),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Theme.of(context).primaryColor.withOpacity(0.98),
                            Theme.of(context).primaryColor.withOpacity(0.8)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                          width: (MediaQuery.of(context).size.width),
                          height: MediaQuery.of(context).size.height -
                              120 -
                              30 -
                              12,
                          child: TimelinePage(
                            title: 'Last Month Results',
                            // onDismissed: () {
                            //   _pageController.animateToPage(0,
                            //       duration: Duration(milliseconds: 200),
                            //       curve: Curves.linear);
                            // },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<StudentState>(builder: (context, studentState, _) {
                    return DigiCampusAppbar(
                      icon: Icons.close,
                      onDrawerTapped: () {
                        Navigator.of(context).pop();
                      },
//                      onTrailingTapped: () {
//                        isLoading = true;
//                        Navigator.push(
//                          context,
//                          PageRouteBuilder(
//                            transitionDuration: Duration(milliseconds: 400),
//                            pageBuilder: (_, __, ___) => StudentDetailsScreen(),
//                          ),
//                        ).then((value) {
//                          setState(() {
//                            isLoading = false;
//                          });
//                        });
//                      },
                    );
                  }),
                  DigiAlert(title: 'Academics',text: 'On course to success? Subscribe to know.',icon: DigiIcons.noun_analytics_1014757,)
                ],
              ),

    );
  }
}
