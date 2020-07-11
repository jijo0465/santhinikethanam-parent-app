import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_key_value_display.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/screens/homework_assignment_discussions.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class HomeworksScreen extends StatefulWidget {
  const HomeworksScreen({Key key}) : super(key: key);

  @override
  _HomeworksScreenState createState() => _HomeworksScreenState();
}

class _HomeworksScreenState extends State<HomeworksScreen> {
//  final List<Map> worksList = [];
//    {
//      "create": "Homework",
//      "topic": "Mjiv sahfbgu asvhbszhv",
//      "subject": "Java",
//      "subdate": "2020-06-02",
//    },
//    {
//      "create": "HomeWork",
//      "topic": "Dcgavsc hiWGBF IY",
//      "subject": "Android",
//      "subdate": "2020-05-05",
//    },
//    {
//      "create": "HomeWork",
//      "topic": "Edfutwf uyqrwtf yqwugfrrw as",
//      "subject": "Java",
//      "subdate": "2020-06-07",
//    },
//    {
//      "create": "Assignment",
//      "topic": "Ey ede r ewfaaef",
//      "subject": "Java",
//      "subdate": "2020-06-06",
//    },
//    {
//      "create": "Homework",
//      "topic": "Wer tdfas gakfjsrhrfar",
//      "subject": "Java",
//      "subdate": "2020-06-08",
//    },
//    {
//      "create": "Assignment",
//      "topic": "Lsuiudgrf waifeguwe",
//      "subject": "Java",
//      "subdate": "2020-06-12",
//    },
//    {
//      "create": "Homework",
//      "topic": "eOWIG FBVqduywu wrfESdc",
//      "subject": "Java",
//      "subdate": "2020-06-12",
//    }
//  ];
  Firestore firestore = Firestore.instance;
  final List<Map> assignments = [];
  final List<Map> homeworks = [];
  // bool assignment = false;
  bool assignmentTapped = false;
  bool homeworksTapped = false;
  Grade grade = Grade.empty();
//  Comparator<dynamic> dateComparator = (a, b) =>
//      DateTime.parse(a['subdate']).compareTo(DateTime.parse(b['subdate']));

  @override
  void initState() {
    // TODO: implement initState
    // worksList.forEach((create) {
    //   if (create.containsValue("Assignment")) {
    //     setState(() {
    //       assignment = true;
    //     });
    //   }
    // });
    // print(assignment);
//    worksList.sort(dateComparator);
//    print(worksList);
//    List.generate(worksList.length, (index) {
//      (worksList[index]['create'] == 'Assignment')
//          ? assignments.add(worksList[index])
//          : homeworks.add(worksList[index]);
//    });
    // worksList.sort();
//    getDatabaseUpdate();
    super.initState();
  }

  getDatabaseUpdate(List<DocumentSnapshot> doc) {
    homeworks.clear();
    assignments.clear();
    doc.forEach((element) {
      if(element.data.containsKey('homeworks'))
        {
          element.data['homeworks'].forEach((value){
//            String subDate = value['submissionDate'];
//            if(subDate.length == 8)
//              subDate = subDate.replaceRange(7, 7, '0');
//            if(subDate.length == 9)
////            print(subDate.length);
//              subDate = subDate.replaceRange(5, 5, '0');
          DateTime subDate = DateTime.fromMillisecondsSinceEpoch(value['submissionDate']);
              print('AFTER : $subDate');
            if(subDate.difference(DateTime.now()).inDays >= 0) {
              homeworks.add(value);
            }
          });
        }
      if((element.data.containsKey('assignments')))
        {
          element.data['assignments'].forEach((value){
//            String subDate = value['submissionDate'];
//            if(subDate.length == 8)
//              subDate = subDate.replaceRange(7, 7, '0');
//            if(subDate.length == 9)
////            print(subDate.length);
//              subDate = subDate.replaceRange(5, 5, '0');
          DateTime subDate = DateTime.fromMillisecondsSinceEpoch(value['submissionDate']);
            print('AFTER : $subDate');
            if(subDate.isAfter(DateTime.now())) {
              assignments.add(value);
            }
          });
        }
//      if((element.data.containsKey(widget.work == 0 ?'homeworks' :'assignments'))) {
//        element.data[widget.work == 0 ?'homeworks' :'assignments'].forEach((value){
//          print('EAch HomeworK');
//          if(value['subject'] == widget.subject) {
//            print(value['subject']);
//            worksList.add(value);
//          }
//        });
//      }
//      print(worksList);
    });
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    grade = state.selectedstudent.grade;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('grade_${grade.standard}').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)));
            }
          List<DocumentSnapshot> _items = snapshot.data.documents;
          getDatabaseUpdate(_items);
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                      child: Column(
                    children: <Widget>[
                      DigiCampusAppbar(
                        title: 'Home Activities',
                        icon: Icons.close,
                        onDrawerTapped: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.deferToChild,
                        onTap: () {
                          setState(() {
                            assignmentTapped = !assignmentTapped;
                          });
                        },
                        child: Column(
                          children: (assignments.isEmpty)
                              ? <Widget>[Container()]
                              : <Widget>[
                                Card(
                                    color: Colors.grey[300],
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: 50,
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(20),
//                                        color: Colors.grey
//                                        // gradient: LinearGradient(colors: [
//                                        //   Colors.blue[300],
//                                        //   Colors.blue[400],
//                                        //   Colors.blue[200]
//                                        // ])
//                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Assignments',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    3),
                                            Icon(CupertinoIcons.down_arrow,
                                                color: Colors.white, size: 24)
                                          ],
                                        )),
                                  )),
                                  Container(
                                      color: Colors.white,
                                      height: (assignmentTapped) ? null : 0,
                                      child: Column(
                                        children: List.generate(
                                            assignments.length,
                                            (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    elevation: 8,
                                                    color: Colors.grey[200],
                                                    child: IntrinsicHeight(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            width: 60,
                                                            color:
                                                                Colors.orange[200],
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Text(
                                                                  DateTime.fromMillisecondsSinceEpoch(assignments[index]['date']).day.toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 28),
                                                                ),
                                                                Text(DateFormat.MMM().format(DateTime.fromMillisecondsSinceEpoch(assignments[index]['date'])),
                                                                  style: TextStyle(fontSize: 16),)
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: <Widget>[
                                                                  DigiKeyValueDisplay(
                                                                      textKey:
                                                                          'Subject ',
                                                                      textValue:
                                                                          ' ${assignments[index]['subject']}'),
                                                                  DigiKeyValueDisplay(
                                                                      textKey:
                                                                          'Topic ',
                                                                      textValue:
                                                                          ' ${assignments[index]['title']}'),
                                                                  DigiKeyValueDisplay(
                                                                      textKey:
                                                                          'Submission Date ',
                                                                      textValue:
                                                                          ' ${DateTime.fromMillisecondsSinceEpoch(assignments[index]['submissionDate']).day}-'
                                                                              '${DateTime.fromMillisecondsSinceEpoch(assignments[index]['submissionDate']).month}-'
                                                                              '${DateTime.fromMillisecondsSinceEpoch(assignments[index]['submissionDate']).year}'
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                      ))
                                ],
                        ),
                      )
                    ],
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        homeworksTapped = !homeworksTapped;
                      });
                    },
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 12,
                        ),
                        Card(
                          color: Colors.grey[300],
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 50,
//                                      decoration: BoxDecoration(
//                                          borderRadius: BorderRadius.circular(20),
//                                          color: Colors.white
//                                          // gradient: LinearGradient(colors: [
//                                          //   Colors.blue[300],
//                                          //   Colors.blue[400],
//                                          //   Colors.blue[200]
//                                          // ])
//                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Homeworks',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                  width: (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      3),
                                              Icon(CupertinoIcons.down_arrow,
                                                  color: Colors.white, size: 24)
                                            ],
                                          )),
                                    ),
                        ),
                        Container(
                            height: (homeworksTapped) ? null : 0,
                            color: Colors.white,
                            child: Column(
                                children: List.generate(
                                    homeworks.length,
                                    (index) => GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>
                                          HADiscussionScreen(
                                            title: homeworks[index]['title'],
                                            date: homeworks[index]['date'],
                                            subDate: homeworks[index]['submissionDate'],
                                            url: homeworks[index]['fileUrl'],
                                          )));},
                                      child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              elevation: 12,
                                              color: Colors.grey[100],
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    DigiKeyValueDisplay(
                                                        textKey: 'Subject ',
                                                        textValue:
                                                            ' ${homeworks[index]['subject']}'),
                                                    DigiKeyValueDisplay(
                                                        textKey: 'Topic ',
                                                        textValue:
                                                            ' ${homeworks[index]['title']}'),
                                                    DigiKeyValueDisplay(
                                                        textKey: 'Submission\nDate ',
                                                        textValue:
                                                            ' ${DateTime.fromMillisecondsSinceEpoch(homeworks[index]['submissionDate']).day}-'
                                                                '${DateTime.fromMillisecondsSinceEpoch(homeworks[index]['submissionDate']).month}-'
                                                                '${DateTime.fromMillisecondsSinceEpoch(homeworks[index]['submissionDate']).year}'
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    ))))
                      ],
                    )),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
