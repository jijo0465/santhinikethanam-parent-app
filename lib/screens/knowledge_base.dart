import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expandable/expandable.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/digi_subject_bar.dart';
import 'package:parent_app/components/digi_knowledgedb_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent_app/models/grade.dart';

enum Subjects { Mathematics, English, Social, Science, Malayalam, Hindi }

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({Key key}) : super(key: key);

  @override
  _KnowledgeBaseScreenState createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  Firestore firestore = Firestore.instance;
  Subjects selectedSubject = Subjects.Mathematics;
  Grade grade = Grade.empty();
  List<DocumentSnapshot> _subjects;
  DocumentSnapshot subjectItem;
  static List<String> titleList = [
    'All',
    'Maths',
    'English',
    'Social',
    'Science',
    'Malayalam',
    'Hindi'
  ];
  String title = titleList.elementAt(1);
  ExpandableController controller;
  //String percentTitle = titleList.first;
  int subjectIndex = 1;
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
    grade.setId(4001);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    children: List.generate(7, (index) {
                      if (index == 0)
                        return Container();
                      else
                        return DigiSubjectBar(
                          index: index,
                          isSelected: index == subjectIndex,
                          onPressed: () {
                            title = titleList.elementAt(index);
                            // for (int i = 0; i < chapterLength; i++)
                            //   isTileSelected.insert(i, false);
                            switch (index) {
                              // case 0:
                              //   setState(() {
                              //     selectedSubject = Subjects.All;
                              //     subjectIndex = 0;
                              //   });
                              //   break;
                              case 1:
                                setState(() {
                                  // if(controller.expanded == true) controller.toggle();
                                  selectedSubject = Subjects.Mathematics;
                                  subjectIndex = 1;
                                  // chapterLength = 0;
                                });
                                break;
                              case 2:
                                setState(() {
                                  // if(controller.expanded == true) controller.toggle();
                                  selectedSubject = Subjects.English;
                                  subjectIndex = 2;
                                  // chapterLength = 0;
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
                                  selectedSubject = Subjects.Malayalam;
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
          SizedBox(height: 12),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                // key: _key,
                // stream: firestore.collection('classroom_${grade.id}').snapshots(),
                stream:
                    firestore.collection('class_8').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  else {
                    _subjects = snapshot.data.documents;
                    for (int i = 0; i < _subjects.length; i++)
                      if (_subjects[i].documentID == 'student_subject_$subjectIndex')
                        subjectItem = _subjects[i];
                    // chapterLength = subjectItem['chapter'].length;
                    // return viewList(subjectItem);
                    return Column(
                      children:
                          List.generate(subjectItem.data.length, (index) {
                        // print(subjectItem['chapter'].length);
                        // print('${subjectItem['chapter'][index]['name']}');
                        return subjectItem.documentID == 'student_subject_$subjectIndex'
                            ? ExpandablePanel(
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
                                                subjectItem['chapter'][index]
                                                    ['name'],
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
                                            subjectItem['chapter'][index]
                                                    ['topics']
                                                .length, (idx) {
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
                                      return (subjectItem['chapter']
                                                                  [index]['topics']
                                                              [idx]['shown'])
                                      ?GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      KnowledgeDbPlayer(
                                                          url: subjectItem['chapter']
                                                                  [index]['topics']
                                                              [idx]['url'])));
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
                                              Container(
                                                height: 80,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/tutorial$trlImageIndex.jpg'),
                                                        fit: BoxFit.fill)),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                      subjectItem['chapter']
                                                              [index]['topics']
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
                              )
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
                            : Text('No Inputs Yet!');
                      }),
                    );
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
                }),
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
