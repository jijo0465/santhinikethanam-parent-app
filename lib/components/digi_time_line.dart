import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';

class TimelinePage extends StatefulWidget {
  final VoidCallback onDismissed;
  TimelinePage({Key key, this.title, this.onDismissed}) : super(key: key);
  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;
  ScrollController _scrollController = ScrollController();

  final List<Map> examsList = [
    {
      "name": "Class Test",
      "date": "02-06-2020",
      "subject": "Mathematics",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "25"
    },
    {
      "name": "Class Test",
      "date": "25-05-2020",
      "subject": "English",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "30"
    },
    {
      "name": "Class Test",
      "date": "22-05-2020",
      "subject": "Social",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "30"
    },
    {
      "name": "Class Test",
      "date": "20-05-2020",
      "subject": "English",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "43"
    },
    {
      "name": "Class Test",
      "date": "12-05-2020",
      "subject": "Malayalam",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "15"
    },
    {
      "name": "Class Test",
      "date": "10-05-2020",
      "subject": "Hindi",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "46"
    },
    {
      "name": "Class Test",
      "date": "05-05-2020",
      "subject": "Malayalam",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "46"
    },
    {
      "name": "Class Test",
      "date": "30-04-2020",
      "subject": "Science",
      "testType": "0",
      "totalMarks": "50",
      "scoredMarks": "46"
    },
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
      lineColor: Colors.white,
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
                Text(exam['date'], style: textTheme.caption),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  exam['name'],
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
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: Colors.deepOrange[300],);
        //icon: Icon(Icons.child_care));
  }
}
