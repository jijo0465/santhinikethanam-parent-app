import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DigiCampusAppbar(
            icon: Icons.close,
            onDrawerTapped: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 12),
          DigiScreenTitle(text: 'TimeTable'),
          SizedBox(height: 12),
          Expanded(
            child: Container(
              child: TimetableView(
                laneEventsList: _buildLaneEvents(),
                timetableStyle: TimetableStyle(
                  startHour: 9,
                  endHour: 16,
                  laneColor: Colors.white,
                  cornerColor: Colors.red,
                  //timelineColor: Colors.teal[100],
                  timelineBorderColor: Colors.white,
                  //timelineItemColor: Colors.brown,
                  timeItemTextColor: Colors.black,
                  mainBackgroundColor: Colors.white,
                  laneHeight: 50,
                  laneWidth: 150,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<LaneEvents> _buildLaneEvents() {
    return [
      LaneEvents(
        lane: Lane(
            name: 'Monday',
            backgroundColor: Colors.blue[800],
            height: 50,
            width: 150,
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        events: [
          TableEvent(
              title: 'Period 1\n',
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              //backgroundColor: Colors.,
              start: TableEventTime(hour: 9, minute: 0),
              end: TableEventTime(hour: 10, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 2\n',
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 10, minute: 00),
              end: TableEventTime(hour: 11, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 00),
              end: TableEventTime(hour: 11, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 3\n',
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 15),
              end: TableEventTime(hour: 12, minute: 15),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Lunch Break\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 12, minute: 15),
              end: TableEventTime(hour: 13, minute: 00),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 4\n',
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 13, minute: 00),
              end: TableEventTime(hour: 14, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 00),
              end: TableEventTime(hour: 14, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 5\n',
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 15),
              end: TableEventTime(hour: 15, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 6\n',
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 15, minute: 00),
              end: TableEventTime(hour: 16, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: 'Tuesday',
            backgroundColor: Colors.blue[800],
            height: 50,
            width: 150,
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        events: [
          TableEvent(
              title: 'Period 1\n',
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              //backgroundColor: Colors.,
              start: TableEventTime(hour: 9, minute: 0),
              end: TableEventTime(hour: 10, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 2\n',
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 10, minute: 00),
              end: TableEventTime(hour: 11, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 00),
              end: TableEventTime(hour: 11, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 3\n',
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 15),
              end: TableEventTime(hour: 12, minute: 15),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Lunch Break\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 12, minute: 15),
              end: TableEventTime(hour: 13, minute: 00),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 4\n',
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 13, minute: 00),
              end: TableEventTime(hour: 14, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 00),
              end: TableEventTime(hour: 14, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 5\n',
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 15),
              end: TableEventTime(hour: 15, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 6\n',
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 15, minute: 00),
              end: TableEventTime(hour: 16, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: 'Wednesday',
            backgroundColor: Colors.blue[800],
            height: 50,
            width: 150,
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        events: [
          TableEvent(
              title: 'Period 1\n',
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              //backgroundColor: Colors.,
              start: TableEventTime(hour: 9, minute: 0),
              end: TableEventTime(hour: 10, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 2\n',
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 10, minute: 00),
              end: TableEventTime(hour: 11, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 00),
              end: TableEventTime(hour: 11, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 3\n',
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 15),
              end: TableEventTime(hour: 12, minute: 15),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Lunch Break\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 12, minute: 15),
              end: TableEventTime(hour: 13, minute: 00),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 4\n',
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 13, minute: 00),
              end: TableEventTime(hour: 14, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 00),
              end: TableEventTime(hour: 14, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 5\n',
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 15),
              end: TableEventTime(hour: 15, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 6\n',
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 15, minute: 00),
              end: TableEventTime(hour: 16, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: 'Thursday',
            backgroundColor: Colors.blue[800],
            height: 50,
            width: 150,
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        events: [
          TableEvent(
              title: 'Period 1\n',
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              //backgroundColor: Colors.,
              start: TableEventTime(hour: 9, minute: 0),
              end: TableEventTime(hour: 10, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 2\n',
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 10, minute: 00),
              end: TableEventTime(hour: 11, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 00),
              end: TableEventTime(hour: 11, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 3\n',
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 15),
              end: TableEventTime(hour: 12, minute: 15),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Lunch Break\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 12, minute: 15),
              end: TableEventTime(hour: 13, minute: 00),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 4\n',
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 13, minute: 00),
              end: TableEventTime(hour: 14, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 00),
              end: TableEventTime(hour: 14, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 5\n',
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 15),
              end: TableEventTime(hour: 15, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 6\n',
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 15, minute: 00),
              end: TableEventTime(hour: 16, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: 'Friday',
            backgroundColor: Colors.blue[800],
            height: 50,
            width: 150,
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        events: [
          TableEvent(
              title: 'Period 1\n',
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              //backgroundColor: Colors.,
              start: TableEventTime(hour: 9, minute: 0),
              end: TableEventTime(hour: 10, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 2\n',
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 10, minute: 00),
              end: TableEventTime(hour: 11, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 00),
              end: TableEventTime(hour: 11, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 3\n',
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 15),
              end: TableEventTime(hour: 12, minute: 15),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Lunch Break\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 12, minute: 15),
              end: TableEventTime(hour: 13, minute: 00),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 4\n',
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 13, minute: 00),
              end: TableEventTime(hour: 14, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 00),
              end: TableEventTime(hour: 14, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 5\n',
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 15),
              end: TableEventTime(hour: 15, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 6\n',
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 15, minute: 00),
              end: TableEventTime(hour: 16, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: 'Saturday',
            backgroundColor: Colors.blue[800],
            height: 50,
            width: 150,
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        events: [
          TableEvent(
              title: 'Period 1\n',
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              //backgroundColor: Colors.,
              start: TableEventTime(hour: 9, minute: 0),
              end: TableEventTime(hour: 10, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 2\n',
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 10, minute: 00),
              end: TableEventTime(hour: 11, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 00),
              end: TableEventTime(hour: 11, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 3\n',
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 11, minute: 15),
              end: TableEventTime(hour: 12, minute: 15),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Lunch Break\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 12, minute: 15),
              end: TableEventTime(hour: 13, minute: 00),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 4\n',
              decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 13, minute: 00),
              end: TableEventTime(hour: 14, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Interval\n',
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 00),
              end: TableEventTime(hour: 14, minute: 15),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          TableEvent(
              title: 'Period 5\n',
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 14, minute: 15),
              end: TableEventTime(hour: 15, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          TableEvent(
              title: 'Period 6\n',
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              start: TableEventTime(hour: 15, minute: 00),
              end: TableEventTime(hour: 16, minute: 00),
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    ];
  }
}
