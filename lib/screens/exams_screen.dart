import 'package:flutter/material.dart';
import 'package:parent_app/components/data.dart';
import 'package:parent_app/components/digi_exam_timeline.dart';
import 'package:parent_app/components/digi_screen_title.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;
  ScrollController _scrollController = ScrollController();
  final List<Map> subjectList = [
    {
      "create": "Class Test",
      "topic": "02-06-2020",
      "subject": "Java",
      "testType": "0",
    },
    {
      "create": "Class Test",
      "topic": "05-05-2020",
      "subject": "Android",
      "testType": "0",
    },
    {
      "create": "Class Test",
      "topic": "06-06-2020",
      "subject": "Java",
      "testType": "0",
    },
    {
      "create": "Mid-Term",
      "topic": "07-06-2020",
      "subject": "Java",
      "testType": "1",
    },
    {
      "create": "Class Test",
      "topic": "08-06-2020",
      "subject": "Java",
      "testType": "0",
    },
    {
      "create": "Mid-Term",
      "topic": "12-06-2020",
      "subject": "Java",
      "testType": "1",
    },
    {
      "create": "Class Test",
      "topic": "12-06-2020",
      "subject": "Java",
      "testType": "0",
    }
  ];
  List<bool> isExamTapped = [];

  // @override
  // void initState() {
  //   // _scrollController.addListener(() {
  //   //   print(_scrollController.offset);
  //   //   // if (_scrollController.offset < -80) {
  //   //   widget.onDismissed();
  //   // }
  //   // });
  //   super.initState();
  // }

  void initState() {
    // TODO: implement initState
    List.generate(subjectList.length, (i) {
      isExamTapped.insert(i, false);
    });
    // print(isSliderSelected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: <Widget>[
      DigiCampusAppbar(
        icon: Icons.close,
        onDrawerTapped: () {
          Navigator.of(context).pop();
        },
      ),
      SizedBox(height: 20),
      DigiScreenTitle(text: 'Upcoming Examinations'),
      Expanded(child: timelineModel(TimelinePosition.Left))
    ])));
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      lineColor: Colors.blue[600],
      itemBuilder: centerTimelineBuilder,
      itemCount: subjectList.length,
      controller: _scrollController,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final exam = subjectList[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            if (exam['testType'] == '1') isExamTapped[i] = !isExamTapped[i];
            // print(isExamTapped);
          });
        },
        child: Card(
          elevation: 6,
          margin: EdgeInsets.symmetric(vertical: i == 0 ? 0.0 : 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  // height: 110,
                  // width: 290,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Image.network(doodle.doodle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(exam['create'], style: textTheme.caption),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        exam['topic'],
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        exam['subject'],
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: isExamTapped[i] && exam['testType'] == '1'
                    ? (105.0 * subjectList.length)
                    : exam['testType'] == '0' ? 0 : 20,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.only(
                        topLeft: isExamTapped[i] && exam['testType'] == '1'
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        topRight: isExamTapped[i] && exam['testType'] == '1'
                            ? Radius.circular(20)
                            : Radius.circular(0))),
                // color: Colors.blue[600],
                child: isExamTapped[i] && exam['testType'] == '1'
                    ? ExamTimelinePage(title: 'Exams')
                    : SizedBox(height: 20),
              )
            ],
          ),
        ),
      ),
      position:
          i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == doodles.length,
      iconBackground: Colors.deepOrange[300],
    );
    //icon: Icon(Icons.child_care));
  }
}

//   @override
//   void initState() {
//     // TODO: implement initState
//     List.generate(subjectList.length, (i) {
//       isSliderSelected.insert(i, false);
//     });
//     print(isSliderSelected);
//     super.initState();
//   }

//   void onSlideTapped() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           DigiCampusAppbar(),
//           SizedBox(height: 12),
//           DigiScreenTitle(
//             text: 'Upcoming Exams',
//           ),
//           SizedBox(height: 12),
//           Expanded(
//             child: Container(
//               child: CustomScrollView(
//                 shrinkWrap: true,
//                 semanticChildCount: 4,
//                 slivers: <Widget>[
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate((context, index) {
//                       return GestureDetector(
//                         behavior: HitTestBehavior.translucent,
//                         onTap: () {
//                           setState(() {
//                             isSliderSelected[index] = !isSliderSelected[index];
//                           });
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: !isSliderSelected[index]
//                                     ? [
//                                         Colors.blue[600],
//                                         Colors.blue[400],
//                                         Colors.blue[200]
//                                       ]
//                                     : [
//                                         Colors.green[300],
//                                         Colors.green[200],
//                                         Colors.green[100],
//                                       ]),
//                             borderRadius:
//                                 index==0
//                                 ? BorderRadius.only(
//                                   topLeft: Radius.circular(34),
//                                   topRight: Radius.circular(34))
//                                 : isSliderSelected[index]
//                                 ? BorderRadius.only(
//                                   topLeft: Radius.circular(34),
//                                   bottomRight: Radius.circular(34))
//                                 : null,
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               SizedBox(height: 10.0),
//                               Row(
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(subjectList[index]["topic"]),
//                                         SizedBox(
//                                           height: 5.0,
//                                         ),
//                                         Text(subjectList[index]["create"],
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .subhead
//                                                 .merge(
//                                                     TextStyle(fontSize: 12.0))),
//                                         SizedBox(
//                                           height: 5.0,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Text(subjectList[index]["subject"],
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .title
//                                           .merge(TextStyle(
//                                               fontSize: 16.0,
//                                               color: Colors.black))),
//                                   // IconButton(
//                                   //   icon: Icon(Icons.favorite_border),
//                                   //   onPressed: () {},
//                                   // ),
//                                   // IconButton(
//                                   //   icon: Icon(Icons.add_shopping_cart),
//                                   //   onPressed: () {},
//                                   // )
//                                 ],
//                               ),
//                               SizedBox(height: 10.0),
//                               isSliderSelected[index]
//                                   ? Container(
//                                       height: 150.0,
//                                       color: Colors.black,
//                                       width: double.infinity,
//                                     )
//                                   : Container(),
//                             ],
//                           ),
//                         ),
//                       );
//                     }, childCount: subjectList.length),
//                   ),
//                   //_buildSlider(),
//                   // _title(context, 'Sliver Grid in Flutter'),
//                   // _buildPopularRestaurant(),
//                   // _title(context, 'Sliver List in Flutter'),
//                   // _buildRecommendedList()
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //   _title(BuildContext context, String title) {
// //     return SliverToBoxAdapter(
// //       child: Container(
// //         padding: EdgeInsets.only(left: 20.0, top: 20.0),
// //         child: Text(title,
// //             style: Theme.of(context)
// //                 .textTheme
// //                 .title
// //                 .merge(TextStyle(fontSize: 16.0, color: Colors.blue))),
// //       ),
// //     );
// //   }
// //    _buildSlider() {
// //     return SliverToBoxAdapter(
// //       child: Stack(
// //         children: <Widget>[
// //           Container(
// //             height: 200,
// //             child: Swiper(
// //               itemCount: subjectList.length,
// //               autoplay: true,
// //               curve: Curves.easeIn,
// //               itemBuilder: (BuildContext context, int index){
// //                 return Text(subjectList[index]["topic"],);
// //               },
// //             ),
// //           ),
// //           Container(
// //             height: 200,
// //             color: Colors.blue.withOpacity(0.5),
// //           ),
// //           Positioned(
// //             bottom: 20,
// //             left: 20,
// //             child: Text("Flutter Tutorial", style: TextStyle(
// //                 color: Colors.white
// //             )),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //   _buildPopularRestaurant() {
// //     return SliverGrid(
// //       gridDelegate:
// //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
// //       delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
// //         return Container(
// //           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: <Widget>[
// //               Container(
// //                   color: Colors.grey, height: 100.0, width: double.infinity),
// //               Text(subjectList[index]["topic"],
// //                   style: Theme.of(context)
// //                       .textTheme
// //                       .title
// //                       .merge(TextStyle(fontSize: 14.0)))
// //             ],
// //           ),
// //         );
// //       }, childCount: subjectList.length),
// //     );
// //   }
// //   _buildRecommendedList() {
// //     return SliverList(
// //       delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
// //         return Container(
// //           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: <Widget>[
// //               Container(
// //                 height: 150.0,
// //                 color: Colors.black,
// //                 width: double.infinity,
// //               ),
// //               SizedBox(height: 10.0),
// //               Row(
// //                 children: <Widget>[
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: <Widget>[
// //                         Text(subjectList[index]["topic"]),
// //                         SizedBox(
// //                           height: 5.0,
// //                         ),
// //                         Text(subjectList[index]["create"],
// //                             style: Theme.of(context)
// //                                 .textTheme
// //                                 .subhead
// //                                 .merge(TextStyle(fontSize: 12.0))),
// //                         SizedBox(
// //                           height: 5.0,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Text(subjectList[index]["subject"],
// //                       style: Theme.of(context).textTheme.title.merge(
// //                           TextStyle(fontSize: 16.0, color: Colors.black))),
// //                   IconButton(
// //                     icon: Icon(Icons.favorite_border),
// //                     onPressed: () {},
// //                   ),
// //                   IconButton(
// //                     icon: Icon(Icons.add_shopping_cart),
// //                     onPressed: () {},
// //                   )
// //                 ],
// //               ),
// //             ],
// //           ),
// //         );
// //       }, childCount: subjectList.length),
// //     );
// //   }
// // }
