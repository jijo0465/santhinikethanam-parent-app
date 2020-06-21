import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/screens/discussions_screen.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key key}) : super(key: key);

  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  ScrollController _scrollController = new ScrollController();
  DateTime launchDate = DateTime(2020,6,8);
  DateTime today = DateTime.now().add(Duration(days: 1));
  Firestore firestore = Firestore.instance;
//  String videoUrl;
  Grade gr = Grade.empty();
  StudentState studentState;
//  StorageReference ref;
  // ScrollController _controller2;
  // double iconOffset;
  // double offset;
  // bool watchLive;

  // @override
  // void initState() {
  //   _controller1.addListener(() {
  //     setState(() {
  //       _controller1.notifyListeners();
  //     });
  //     // offset = _controller1.offset;
  //     // setState(() {
  //     //   _controller2.animateTo(offset,
  //     //       duration: Duration(microseconds: 400), curve: null);
  //     //   _controller2.notifyListeners();
  //     //   print(offset);
  //     // });
  //   });
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   // iconOffset = 50.0;
  //   // watchLive = false;
  //   super.initState();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget dateTiles(int i) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    DateFormat _dateFormat = DateFormat.yMMMd();
    DateFormat _dateFormatDay = DateFormat.E();
    var date = today.subtract(Duration(days: i));
//    int hrs = 11;
//    String grade = '8';
    // print(hrs);
    // int mts = date.minute;
    String formattedDay = _dateFormatDay.format(date);
    String formattedDate = _dateFormat.format(date);
    String saveFormattedDate = DateFormat('dd-MM-yyyy').format(date);
    var startTime = ['10:00','10:45','11:30'];
    var endTime = ['10:30','11:15','12:00'];
    List<Map<String, dynamic>> timeTableList1 = [
      {
        'class':8,
        'day': 'Monday',
        'periods': [{'pdno': 1, 'subject': 'English'},
          {'pdno': 2, 'subject': 'Malayalam',},
          {'pdno': 3, 'subject': 'IT',}],
      },
      {
        'day': 'Tuesday',
        'class':8,
        'periods': [{'pdno': 1, 'subject': 'Maths'},
          {'pdno': 2, 'subject': 'Malayalam', },
          {'pdno': 3, 'subject': 'English', }],
      },
      {
        'day': 'Wednesday',
        'class':8,
        'periods': [{'pdno': 1, 'subject': 'Social'},
          {'pdno': 2, 'subject': 'Biology'},
          {'pdno': 3, 'subject': 'Geography'}],
      },
      {
        'day': 'Thursday',
        'class':8,
        'periods': [{'pdno': 1, 'subject': 'Physics'},
          {'pdno': 2, 'subject': 'Malayalam'},
          {'pdno': 3, 'subject': 'Maths'}],
      },
      {
        'day': 'Friday',
        'class':8,
        'periods': [{'pdno': 1, 'subject': 'Physics'},
          {'pdno': 2, 'subject': 'Politics'},
          {'pdno': 3, 'subject': 'Biology'}],
      },
    ];
    List<Map<String, dynamic>> timeTableList2 = [
      {
        'class':9,
        'day': 'Monday',
        'periods': [{'pdno': 1, 'subject': 'Maths'},
          {'pdno': 2, 'subject': 'Social',},
          {'pdno': 3, 'subject': 'Physics',}],
      },
      {
        'class':9,
        'day': 'Tuesday',
        'periods': [{'pdno': 1, 'subject': 'IT'},
          {'pdno': 2, 'subject': 'Chemistry',},
          {'pdno': 3, 'subject': 'Malayalam',}],
      },
      {
        'class':9,
        'day': 'Wednesday',
        'periods': [{'pdno': 1, 'subject': 'Biology'},
          {'pdno': 2, 'subject': 'English',},
          {'pdno': 3, 'subject': 'Maths',}],
      },
      {
        'class':9,
        'day': 'Thursday',
        'periods': [{'pdno': 1, 'subject': 'English'},
          {'pdno': 2, 'subject': 'Chemistry',},
          {'pdno': 3, 'subject': 'Malayalam',}],
      },
      {
        'class':9,
        'day': 'Friday',
        'periods': [{'pdno': 1, 'subject': 'Social'},
          {'pdno': 2, 'subject': 'Physics',},
          {'pdno': 3, 'subject': 'Maths',}],
      },
    ];

    List<Map<String, dynamic>> timeTableList3 = [
      {
        'class':10,
        'day': 'Monday',
        'periods': [{'pdno': 1, 'subject': 'Maths'},
          {'pdno': 2, 'subject': 'Malayalam',},
          {'pdno': 3, 'subject': 'Geography',}],
      },
      {
        'class':10,
        'day': 'Tuesday',
        'periods': [{'pdno': 1, 'subject': 'History'},
          {'pdno': 2, 'subject': 'English',},
          {'pdno': 3, 'subject': 'Physics',}],
      },
      {
        'class':10,
        'day': 'Wednesday',
        'periods': [{'pdno': 1, 'subject': 'Chemistry'},
          {'pdno': 2, 'subject': 'Maths',},
          {'pdno': 3, 'subject': 'IT',}],
      },
      {
        'class':10,
        'day': 'Thursday',
        'periods': [{'pdno': 1, 'subject': 'Malayalam'},
          {'pdno': 2, 'subject': 'English',},
          {'pdno': 3, 'subject': 'Geography',}],
      },
      {
        'class':10,
        'day': 'Friday',
        'periods': [{'pdno': 1, 'subject': 'Maths'},
          {'pdno': 2, 'subject': 'Biology',},
          {'pdno': 3, 'subject': 'English',}],
      },
    ];
    studentState = Provider.of<StudentState>(context, listen: true);
    gr =studentState.selectedstudent.grade;
    List<Map<String, dynamic>> timeTable = List();
    Map<String, dynamic> dayTable = Map();
    print(formattedDay);
    switch(studentState.selectedstudent.grade.standard){
      case 8:
        timeTable = timeTableList1;
        break;
      case 9:
        timeTable = timeTableList2;
        break;
      case 10:
        timeTable = timeTableList3;
        break;
    }
    switch (formattedDay) {
      case 'Mon':
        dayTable = timeTable[0];
        break;
      case 'Tue':
        dayTable = timeTable[1];
        break;
      case 'Wed':
        dayTable = timeTable[2];
        break;
      case 'Thu':
        dayTable = timeTable[3];
        break;
      case 'Fri':
        dayTable = timeTable[4];
        break;
      default:
        return Container();
    }
    print('num: $timeTable');

    // List<Widget> _periods = [];
    // for (int i = 0; i < 7; i++) _periods.add(periodWidgets(i, formattedDay));
    return Container(
        decoration: BoxDecoration(),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left:8.0,top: 8),
              child: Card(
                  elevation: 8,
                  color: Colors.grey[200],
                  child: IntrinsicHeight(
                      child: Row(children: <Widget>[
                        Container(
                          width: 70,
                          color: Colors.orange[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                formattedDate.substring(
                                    4, (formattedDate[6] == ',') ? 6 : 5),
                                style: TextStyle(fontSize: 28),
                              ),
                              Text(
                                formattedDate.substring(0, 3),
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              print('scrolling.... ${scrollInfo.metrics.pixels}');
                              _scrollController.jumpTo(scrollInfo.metrics.pixels);
                              return false;
                            },
                            child: SingleChildScrollView(
                              // controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.grey[100],
                                      Colors.grey[400]
                                    ])),
                                child: Row(
                                    children: List.generate(dayTable['periods'].length, (index) {
//                              ref = FirebaseStorage.instance.ref()
//                                      .child("videos/$grade/$saveFormattedDate/${timeTable['periods'][index]['pdno']}");
//                              ref!=null;
                                      // print(timeTable['$index'].toString());
//                                      videoUrl = null;
                                      return StreamBuilder<QuerySnapshot>(
                                        stream: firestore.collection('grade_${studentState.selectedstudent.grade.standard}').snapshots(),
                                        builder: (context, snapshot) {
                                          bool isVideoUploaded = false;
                                          String videoUrl;
                                          String subjectName;
                                          if (!snapshot.hasData)
                                            return Center(
                                                child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                        Theme.of(context).primaryColor)));
                                          else  {
                                            List<DocumentSnapshot> _items = snapshot.data.documents;
                                            if(_items.isNotEmpty)
                                              _items.forEach((element) {
                                                if(element.documentID == saveFormattedDate)
                                                  if(element['period_${dayTable['periods'][index]['pdno']}']!=null)
                                                  {
                                                    print(element['period_${dayTable['periods'][index]['pdno']}']['videoUrl']);
                                                    print('KEY --->> TRUE');
                                                    videoUrl = element['period_${dayTable['periods'][index]['pdno']}']['videoUrl'];
                                                    if(videoUrl != null)
                                                    isVideoUploaded = true;
                                                    print(saveFormattedDate);
                                                    print(element['period_${dayTable['periods'][index]['pdno']}']);
                                                    subjectName = element['period_${dayTable['periods'][index]['pdno']}']['subject'];
                                                  }
                                                  else  isVideoUploaded = false;
                                              });
                                          return Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                behavior: HitTestBehavior.translucent,
                                                onTap: (){
                                                  print(state.selectedstudent.grade.standard);
//                                                  firestore.collection('grade_${state.selectedstudent.grade.standard}').document(saveFormattedDate).get().then((value) {
//                                                    print(value.documentID);
//                                                    print(value.data.length);
//                                                    videoUrl = value['period_${dayTable['periods'][index]['pdno']}']['videoUrl'];
//                                                    print(videoUrl);
//                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
//                                                        DiscussionsScreen(date: saveFormattedDate, grade: studentState.selectedstudent.grade.standard.toString(),period: dayTable['periods'][index]['pdno'],url: videoUrl)));
//                                                  });
                                                  if(isVideoUploaded)
                                                    {
                                                      print('VIDEO : $videoUrl');
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                          DiscussionsScreen(date: saveFormattedDate, grade: studentState.selectedstudent.grade.standard.toString(),period: dayTable['periods'][index]['pdno'],url: videoUrl)));
                                                    }
                                                },
                                                child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(colors: [
                                                          !isVideoUploaded
                                                              ?Colors.grey[(index + 1) * 100]
                                                              :Colors.blueGrey[(index + 1) * 100],
                                                          !isVideoUploaded
                                                              ?Colors.grey[100 + ((index + 1) * 100)]
                                                              :Colors.blueGrey[100 + ((index + 1) * 100)]
                                                        ])),
                                                    // color: Colors.deepOrange[100+(index*100)],
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text(
                                                            '${isVideoUploaded ?subjectName :dayTable['periods'][index]['subject']}\n${startTime[dayTable['periods'][index]['pdno']-1]} - ${endTime[dayTable['periods'][index]['pdno']-1]}',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                            overflow: TextOverflow.clip,
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              VerticalDivider(
                                                thickness: 1,
                                                width: 1,
                                                color: Colors.white,
                                              )
                                            ],
                                          );}
                                        }
                                      );
                                    })),
                              ),
                            ),
                          ),
                        ),
                      ]))))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    int hr;
    List<Widget> _dateTileWidgets = [];
//    int i = DateTime.now().difference(launchDate).inDays;
    for (int i = 0; i <= today.difference(launchDate).inDays; i++)
      _dateTileWidgets.add(dateTiles(i));
    return Scaffold(
        body: Column(
          children: <Widget>[
            DigiCampusAppbar(
              title: 'Virtual Classroom',
              icon: Icons.close,
              onDrawerTapped: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              height: 50,
              child: SingleChildScrollView(
                // controller: _controller2,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Container(
                    height: 30,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 50),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                        children: List.generate(3, (index) {
                          hr = 10 + index;
                          return Row(
                            children: <Widget>[Text('$hr:00'), SizedBox(width: 65)],
                          );
                        }))),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: _dateTileWidgets,
                    ))),
          ],
        ));
  }
}
