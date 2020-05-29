import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';

class ExamTimelinePage extends StatefulWidget {
  final VoidCallback onDismissed;
  ExamTimelinePage({Key key, this.title, this.onDismissed}) : super(key: key);
  final String title;

  @override
  _ExamTimelinePageState createState() => _ExamTimelinePageState();
}

class _ExamTimelinePageState extends State<ExamTimelinePage> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;
  ScrollController _scrollController = ScrollController();

  final List<Map> examsList = [
    {
      "date": "05-05-2020",
      "subject": "Maths",
      "time": "9:30-11:30",
    },
    {"date": "05-05-2020", "subject": "English", "time": "12:30-2:30"},
    {"date": "06-05-2020", "subject": "Science", "time": "9:30-11:30"},
    {"date": "06-05-2020", "subject": "Social", "time": "12:30-2:30"},
    {"date": "07-05-2020", "subject": "Malayalam", "time": "9:30-11:30"},
    {"date": "07-05-2020", "subject": "Hindi", "time": "12:30-2:30"},
  ];

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset < -80) {
        widget.onDismissed();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return timelineModel(TimelinePosition.Left);
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      lineColor: Colors.deepOrange[400],
      itemBuilder: centerTimelineBuilder,
      itemCount: examsList.length,
      controller: _scrollController,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final exam = examsList[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
      Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(vertical: 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 290,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Image.network(doodle.doodle),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Text(exam['date'], style: textTheme.caption),
                  Text(
                    exam['time'],
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 8.0,
              // ),

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
      position:
          i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == doodles.length,
      iconBackground: Colors.white
    );
    //icon: Icon(Icons.child_care));
  }
}
