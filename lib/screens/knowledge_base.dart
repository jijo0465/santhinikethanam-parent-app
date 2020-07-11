import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expandable/expandable.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/digi_subject_bar.dart';
import 'package:parent_app/components/digi_knowledgedb_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

//enum Subjects { Mathematics, English, Social, Science, Malayalam, Hindi }

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({Key key}) : super(key: key);

  @override
  _KnowledgeBaseScreenState createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  Firestore firestore = Firestore.instance;
//  Subjects selectedSubject = Subjects.Mathematics;
  Grade grade = Grade.empty();
  StudentState studentState;
  List<DocumentSnapshot> _subjects;
  bool isActivated = true;
  List<String> titleList = List();
  String title;
//  ValueNotifier<String> title;
  ExpandableController controller;
  //String percentTitle = titleList.first;
  int subjectIndex = 0;
  int trlImageIndex;
  // int chapterLength = 0;
  // List<bool> isTileSelected = [];

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.
    // addPostFrameCallback((timestamp){
    //   print(chapterLength);
    // });
    // Future.delayed(Duration(milliseconds: 300)).then((value) {
    //   print(chapterLength);
    //   setState(() {
    //     for (var i = 0; i < chapterLength; i++) isTileSelected.insert(i, false);
    //   });
    // });
    // isTileSelected.insert(0, false);
    // isTileSelected.insert(1, false);
    super.initState();
  }

  getSubjects() {
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
          {'pdno': 2, 'subject': 'Hindi', },
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
    grade =studentState.selectedstudent.grade;
    List<Map<String, dynamic>> timeTable = List();
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
    timeTable.forEach((element) {
      element['periods'].forEach((value){
        bool flag = false;
        titleList.forEach((item)  {
            if(value['subject']==item)
              flag = true;
        });
        if (!flag)
          titleList.add(value['subject']);
      });
    });
    print('TITELLIST');
    print(titleList);
    title = titleList.elementAt(subjectIndex);
  }

  @override
  Widget build(BuildContext context) {
    getSubjects();
    print('title : ${title}\n titleLIST : $titleList');
    return Container(
      child: Column(
        children: <Widget>[
          DigiCampusAppbar(
              icon: Icons.close,
              onDrawerTapped: () {
                Navigator.of(context).pop();
              }),
          // SizedBox(height: 12),
          // Text('Notes & Discussion Materials'),
          SizedBox(height: 20),
          Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              //height: 500,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(titleList.length, (index) {
//                      if (index == 0)
//                        return Container();
//                      else
                        return DigiSubjectBar(
                          index: titleList.length,
                          title: titleList[index],
                          isSelected: index == subjectIndex,
                          onPressed: () {
                            setState(() {
//                              title = titleList.elementAt(index);
                              subjectIndex = index;
                            });
                            // for (int i = 0; i < chapterLength; i++)
                            //   isTileSelected.insert(i, false);
//                            switch (index) {
//                              // case 0:
//                              //   setState(() {
//                              //     selectedSubject = Subjects.All;
//                              //     subjectIndex = 0;
//                              //   });
//                              //   break;
//                              case 1:
//                                setState(() {
//                                  // if(controller.expanded == true) controller.toggle();
//                                  selectedSubject = Subjects.Mathematics;
//                                  subjectIndex = 1;
//                                  // chapterLength = 0;
//                                });
//                                break;
//                              case 2:
//                                setState(() {
//                                  // if(controller.expanded == true) controller.toggle();
//                                  selectedSubject = Subjects.English;
//                                  subjectIndex = 2;
//                                  // chapterLength = 0;
//                                });
//                                break;
//                              case 3:
//                                setState(() {
//                                  selectedSubject = Subjects.Social;
//                                  subjectIndex = 3;
//                                });
//                                break;
//                              case 4:
//                                setState(() {
//                                  selectedSubject = Subjects.Science;
//                                  subjectIndex = 4;
//                                });
//                                break;
//                              case 5:
//                                setState(() {
//                                  selectedSubject = Subjects.Malayalam;
//                                  subjectIndex = 5;
//                                });
//                                break;
//                              case 6:
//                                setState(() {
//                                  selectedSubject = Subjects.Hindi;
//                                  subjectIndex = 6;
//                                });
//                                break;
//                            }
                          },
                        );
                    }),
                  ))),
          SizedBox(height: 12),
          isActivated?
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                  // key: _key,
                  // stream: firestore.collection('classroom_${grade.id}').snapshots(),
                  stream:
                      firestore.collection('knowledge_db').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<Map<String, dynamic>> eachSubject = [];
                    List<String> eachKey = [];
                    DocumentSnapshot doc;
                    Map<String, dynamic> subjectItem;
                    print(title);
                    if (!snapshot.hasData)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor, // Red
                            ),
                          ),
                        ),
                      );
                    else {
                      _subjects = snapshot.data.documents;
                      for (int i = 0; i < _subjects.length; i++)
                        if (_subjects[i].documentID == 'grade_${grade.standard}')
                          doc = _subjects[i];
                        print('TITLE : :  $title');
                      subjectItem = doc.data['$title'];
                      print(doc.data);
                      // chapterLength = subjectItem['chapter'].length;
                      // return viewList(subjectItem);
                      if(subjectItem != null)
                      subjectItem.forEach((key, value) {
//                      print('$key : $value');
                        if(key.compareTo('chapters') == 0) {
                          print('CHAPTERS');
//                        eachSubject.add(value);
//                        eachSubject.insert(j,{key: value});
//                        j++;
                        }
                        else  {
                          eachSubject.add({key: value});
                          eachKey.add(key);
                          print('ADDED');
                        }
                      });
//                      print(eachSubject);
//                    print(eachSubject[0]['Air'][0]['chapterName']);
                      return eachSubject.isNotEmpty
                          ? Column(
                        children:
                            List.generate(eachSubject.length, (index) {

                          // print(subjectItem['chapter'].length);
                          // print('${subjectItem['chapter'][index]['name']}');
                          return ExpandablePanel(
                                  controller: controller,
                                  hasIcon: false,
                                  // tapBodyToCollapse: true,
                                  // tapHeaderToExpand: true,
                                  header: ExpandableButton(
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        elevation: 8,
                                        color: Colors.grey[100],
                                        // color: Theme.of(context)
                                        //     .primaryColor
                                        //     .withOpacity(0.5),
                                        child: Column(
                                          children: <Widget>[
                                            IntrinsicHeight(
                                                child: Row(children: <Widget>[
                                              Container(
                                                height: 60,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12)),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  width: 60,
                                                  height: 50,
                                                  // decoration: BoxDecoration(
                                                  //   borderRadius:
                                                  //       BorderRadius.only(
                                                  //           topLeft:
                                                  //               Radius.circular(
                                                  //                   12),
                                                  //           bottomLeft:
                                                  //               Radius.circular(
                                                  //                   12)),
                                                  //   // color: Colors.orange[200],
                                                  // ),
                                                  child: Text(
                                                    '${index + 1} .',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                  // Column(
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment.center,
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.center,
                                                  //   children: <Widget>[
                                                  //     Text(
                                                  //       "12",
                                                  //       style: TextStyle(fontSize: 28),
                                                  //     ),
                                                  //     Text(
                                                  //       "Sep",
                                                  //       style: TextStyle(fontSize: 16),
                                                  //     )
                                                  //   ],
                                                  // ),
                                                  ),
                                              Expanded(
                                                child: Text(
                                                  eachSubject[index][eachKey[index]][0]
                                                      ['chapterName'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      // color:
                                                      //     Colors.deepOrange[300],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ])),
                                          ],
                                        )),
                                  ),
                                  // collapsed: Text(
                                  //   article.body,
                                  //   softWrap: true,
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  expanded: Container(
                                      // shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.only(
                                      //   bottomLeft: Radius.circular(12),
                                      //   bottomRight: Radius.circular(12),
                                      // )),
                                      // color: Colors.blue,
                                      // decoration: BoxDecoration(

                                      // ),
                                      child: IntrinsicHeight(
                                    child: SingleChildScrollView(
                                      child: Column(
                                          children: List.generate(
                                              eachSubject[index][eachKey[index]]
                                                  .length, (idx) {
                                                String url;
                                                url = eachSubject
                                                [index][eachKey[index]]
                                                [idx]['videoId'];
                                        switch (index) {
                                          case 0:
                                            subjectIndex == 2
                                                ? trlImageIndex = 0
                                                : idx == 0
                                                    ? trlImageIndex = 1
                                                    : trlImageIndex = 2;
                                            break;
                                          case 1:
                                            trlImageIndex = 1;
                                            break;
                                          default:
                                        }
                                        return (true)
                                        ?GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        KnowledgeDbPlayer(
                                                            url: url)));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: 10),
                                            margin: EdgeInsets.only(
                                                right: 10, left: 12),
                                            height: 80,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                              style: BorderStyle.solid,
                                              color:
                                                  Theme.of(context).primaryColor,
                                            )),
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 3,
                                                  child: Container(
                                                    height: 80,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                eachSubject[index][eachKey[index]]
                                                                [idx]['thumbnailUrl']),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  flex: 3,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                          eachSubject
                                                                  [index][eachKey[index]]
                                                              [idx]['name'],
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                              child: Icon(
                                                            Icons.brightness_1,
                                                            size: 10,
                                                            color: Colors.grey,
                                                          )),
                                                          Text('V',
                                                              style: TextStyle(
                                                                  fontSize: 10)),
                                                          Container(
                                                              child: Icon(
                                                            Icons.brightness_1,
                                                            size: 10,
                                                            color: Colors.grey,
                                                          )),
                                                          Text(
                                                              '${titleList[subjectIndex]}',
                                                              style: TextStyle(
                                                                  fontSize: 10)),
                                                          Container(
                                                              child: Icon(
                                                            Icons.timer,
                                                            size: 10,
                                                            color: Colors.grey,
                                                          )),
                                                          Text('10 min',
                                                              style: TextStyle(
                                                                  fontSize: 10)),
                                                        ],
                                                      ),
                                                      Text(
                                                          'Description of the topic')
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                        :Container();
                                      })
                                          // ],
                                          ),
                                    ),
                                  )),
                                  // tapHeaderToExpand: true,
                                  // hasIcon: true,
                                );
                              // ExpandableNotifier(
                              //     // onTap: () {
                              //     //   setState(() {
                              //     //     for (var i = 0;
                              //     //         i < subjectItem['chapter'].length;
                              //     //         i++) {
                              //     //       if (i == index)
                              //     //         isTileSelected.insert(
                              //     //             index, !isTileSelected[index]);
                              //     //       else
                              //     //         isTileSelected.insert(i, false);
                              //     //     }
                              //     //   });
                              //     // },
                              //     controller: controller,
                              //     child: Column(
                              //       children: <Widget>[
                              //         Expandable(
                              //           // controller: ,
                              // collapsed: ExpandableButton(
                              //   child: Card(
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius:
                              //             BorderRadius.circular(12.0),
                              //       ),
                              //       elevation: 8,
                              //       color: Theme.of(context)
                              //           .primaryColor
                              //           .withOpacity(0.5),
                              //       child: Column(
                              //         children: <Widget>[
                              //           IntrinsicHeight(
                              //               child:
                              //                   Row(children: <Widget>[
                              //             Container(
                              //                 alignment:
                              //                     Alignment.center,
                              //                 width: 60,
                              //                 height: 60,
                              //                 decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.only(
                              //                           topLeft: Radius
                              //                               .circular(
                              //                                   12),
                              //                           bottomLeft: Radius
                              //                               .circular(
                              //                                   12)),
                              //                   color:
                              //                       Colors.orange[200],
                              //                 ),
                              //                 child: Text(
                              //                   '${index + 1} .',
                              //                   textAlign:
                              //                       TextAlign.center,
                              //                   style: TextStyle(
                              //                       fontWeight:
                              //                           FontWeight
                              //                               .bold),
                              //                 )
                              //                 // Column(
                              //                 //   crossAxisAlignment:
                              //                 //       CrossAxisAlignment.center,
                              //                 //   mainAxisAlignment:
                              //                 //       MainAxisAlignment.center,
                              //                 //   children: <Widget>[
                              //                 //     Text(
                              //                 //       "12",
                              //                 //       style: TextStyle(fontSize: 28),
                              //                 //     ),
                              //                 //     Text(
                              //                 //       "Sep",
                              //                 //       style: TextStyle(fontSize: 16),
                              //                 //     )
                              //                 //   ],
                              //                 // ),
                              //                 ),
                              //             Expanded(
                              //               child: Text(
                              //                 subjectItem['chapter']
                              //                     [index]['name'],
                              //                 textAlign:
                              //                     TextAlign.center,
                              //                 style: TextStyle(
                              //                     color: Colors
                              //                         .deepOrange[300],
                              //                     fontWeight:
                              //                         FontWeight.bold),
                              //               ),
                              //             ),
                              //           ])),
                              //         ],
                              //       )),
                              // ),
                              //           expanded: ExpandableButton(
                              // child: Card(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.only(
                              //     bottomLeft: Radius.circular(12),
                              //     bottomRight: Radius.circular(12),
                              //   )),
                              //   color: Colors.blue,
                              //   child: IntrinsicHeight(
                              //     child: SingleChildScrollView(
                              //       child: Column(
                              //           children: List.generate(
                              //               subjectItem['chapter']
                              //                       [index]['topics']
                              //                   .length, (idx) {
                              //         return Container(
                              //           // padding: EdgeInsets.all(2),
                              //           margin: EdgeInsets.only(
                              //               left: 20, top: 2),
                              //           decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(
                              //                       12),
                              //               color: Theme.of(context)
                              //                   .primaryColor
                              //                   .withOpacity(0.5)),
                              //           child: IntrinsicHeight(
                              //               child: Row(
                              //                   children: <Widget>[
                              //                 Container(
                              //                     alignment: Alignment
                              //                         .center,
                              //                     width: 40,
                              //                     height: 40,
                              //                     // decoration: BoxDecoration(
                              //                     //   borderRadius: BorderRadius.only(
                              //                     //       topLeft:
                              //                     //           Radius.circular(12),
                              //                     //       bottomLeft:
                              //                     //           Radius.circular(12)),
                              //                     //   // color: Colors.orange[200],
                              //                     // ),
                              //                     child: Text(
                              //                       '${idx + 1} .',
                              //                       textAlign:
                              //                           TextAlign
                              //                               .center,
                              //                       style: TextStyle(
                              //                           fontWeight:
                              //                               FontWeight
                              //                                   .w600),
                              //                     )),
                              //                 Expanded(
                              //                   child: Text(
                              //                     subjectItem['chapter']
                              //                                 [index]
                              //                             ['topics']
                              //                         [idx]['name'],
                              //                     textAlign: TextAlign
                              //                         .center,
                              //                     style: TextStyle(
                              //                         color: Colors
                              //                                 .deepOrange[
                              //                             200],
                              //                         fontWeight:
                              //                             FontWeight
                              //                                 .w600),
                              //                   ),
                              //                 ),
                              //               ])),
                              //         );
                              //       })
                              //           // ],
                              //           ),
                              //     ),
                              //   ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ))
//                              : Center(child: Text('No Inputs Yet!'));
                        }),
                      ):Center(child: Text('No Inputs Yet!'));
                      // _items = snapshot.data.documents;
                      // listItem(_items);
                      // print('item: ${_items[0]}');
                      // setState(() {
                      // AnimatedList.of(context).insertItem(0);
                      // Future.delayed(Duration(milliseconds: 200))
                      //     .then((value) => _listKey.currentState.insertItem(0));

                      // });
                      // return listItem(_items[0]);'
                      // commentData.addAll(_items[0]['']['']);
                      // return (_items.isNotEmpty)
                      //     ? Expanded(
                      //         child: SingleChildScrollView(
                      //             child: Column(
                      //                 children: discussionListWidget.reversed.toList())
                      //             // child: listItem(_items[0]['disussion'])
                      //             ))
                      // : Container(child: Text('No Discussions yet!!'));
                    }
                  }
            ),
          ):Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Text(
                  'Not Subscribed!'
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: AnimatedList(
          //     itemBuilder: (BuildContext context, int index,
          //         Animation<double> animation) {
          //       // return CardItem(
          //       //   animation: animation,
          //       //   item: _list[index],
          //       //   selected: _selectedItem == _list[index],
          //       //   onTap: () {
          //       //     setState(() {
          //       //       _selectedItem =
          //       //           _selectedItem == _list[index] ? null : _list[index];
          //       //     });
          //       //   },
          //       return Padding(
          //           padding: const EdgeInsets.all(2.0),
          //           child: SizeTransition(
          //               axis: Axis.vertical,
          //               sizeFactor: animation,
          //               child: GestureDetector(
          //                   behavior: HitTestBehavior.opaque,
          //                   onTap: () {
          //                     setState(() {
          //                       subjectIndex = index;
          //                     });
          //                     // setState(() {
          //                     //   _selectedItem = _selectedItem == _list[index]
          //                     //       ? null
          //                     //       : _list[index];
          //                     // });
          //                   },
          //                   child: Card(
          //                     child: ,
          //                   ))));
          //     },
          //     // itemCount: 1,
          //     // itemBuilder: (BuildContext context, int index) {
          //     // return ;
          //     //  },
          //   ),
          // )
        ],
      ),
    );
  }

  Widget viewList(DocumentSnapshot subject) {
    return SingleChildScrollView(
      // controller: controller,
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  // Widget _buildDiscussionList(
  //     BuildContext context, int index, Animation<double> animation) {
  //   return CardItem(
  //     animation: animation,
  //     item: _list[index],
  //     selected: _selectedItem == _list[index],
  //     onTap: () {
  //       setState(() {
  //         _selectedItem = _selectedItem == _list[index] ? null : _list[index];
  //       });
  //     },
  //   );
  // }
}
