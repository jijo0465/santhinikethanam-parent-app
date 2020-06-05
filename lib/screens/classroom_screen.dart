import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key key}) : super(key: key);

  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  ScrollController _scrollController = new ScrollController();
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget dateTiles(int i) {
    DateFormat _dateFormat = DateFormat.yMMMd();
    DateFormat _dateFormatDay = DateFormat.E();
    var date = DateTime.now().subtract(Duration(days: i));
    int hrs = 11;
    // print(hrs);
    // int mts = date.minute;
    String formattedDay = _dateFormatDay.format(date);
    String formattedDate = _dateFormat.format(date);
    List<Map<String, dynamic>> timeTableList = [
      {
      'day': 'Monday',
      'periods': [{'pdno': 1, 'subject': 'Maths', 'startTime': '9:00', 'endTime': '11:00'},
                  {'pdno': 2, 'subject': 'English', 'startTime': '11:00', 'endTime': '1:00'},
                  {'pdno': 3, 'subject': 'Science', 'startTime': '2:00', 'endTime': '3:30'}],
      },
      {
        'day': 'Tuesday',
        'periods': [{'pdno': 1, 'subject': 'Science', 'startTime': '9:00', 'endTime': '11:00'},
                    {'pdno': 2, 'subject': 'Social', 'startTime': '11:00', 'endTime': '1:00'},
                    {'pdno': 3, 'subject': 'Hindi', 'startTime': '2:00', 'endTime': '3:30'}],
      },
      {
        'day': 'Wednesday',
        'periods': [{'pdno': 1, 'subject': 'Maths', 'startTime': '9:00', 'endTime': '11:00'},
                    {'pdno': 2, 'subject': 'Social', 'startTime': '11:00', 'endTime': '1:00'},
                    {'pdno': 3, 'subject': 'Science', 'startTime': '2:00', 'endTime': '3:30'}],
      },
      {
        'day': 'Thursday',
        'periods': [{'pdno': 1, 'subject': 'Hindi', 'startTime': '9:00', 'endTime': '11:00'},
                    {'pdno': 2, 'subject': 'Maths', 'startTime': '11:00', 'endTime': '1:00'},
                    {'pdno': 3, 'subject': 'Science', 'startTime': '2:00', 'endTime': '3:30'}],
      },
      {
        'day': 'Friday',
        'periods': [{'pdno': 1, 'subject': 'Maths', 'startTime': '9:00', 'endTime': '11:00'},
                    {'pdno': 2, 'subject': 'Malayalam', 'startTime': '11:00', 'endTime': '1:00'},
                    {'pdno': 3, 'subject': 'English', 'startTime': '2:00', 'endTime': '3:30'}],
      },
  ];
    Map<String, dynamic> timeTable;
    print(formattedDay);
    switch (formattedDay) {
      case 'Mon':
        timeTable = timeTableList[0];
        break;
      case 'Tue':
        timeTable = timeTableList[1];
        break;
      case 'Wed':
        timeTable = timeTableList[2];
        break;
      case 'Thu':
        timeTable = timeTableList[3];
        break;
      case 'Fri':
        timeTable = timeTableList[4];
        break;
      default:
        return Container();
    }
    print('num: ${timeTable['0']}');

    // List<Widget> _periods = [];
    // for (int i = 0; i < 7; i++) _periods.add(periodWidgets(i, formattedDay));
    return Container(
        child: Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 8,
              color: Colors.grey[200],
              child: IntrinsicHeight(
                  child: Row(children: <Widget>[
                Container(
                  width: 60,
                  color: Colors.orange[200],
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
                          Colors.greenAccent[100],
                          Colors.greenAccent[400]
                        ])),
                        child: Row(
                            children: List.generate(6, (index) {
                          // print(timeTable['$index'].toString());
                          return Row(
                            children: <Widget>[
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: (){
                                  print(hrs);
                                  hrs == (9+index) && i == 0
                                  ? Navigator.of(context).pushNamed('/call')
                                  : Navigator.of(context).pushNamed('/discussions');
                                },
                                child: Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        gradient: i == 0
                                            ? LinearGradient(colors: [
                                                Colors.deepOrange[
                                                    (index + 1) * 100],
                                                Colors.deepOrange[
                                                    100 + ((index + 1) * 100)]
                                              ])
                                            : null),
                                    // color: Colors.deepOrange[100+(index*100)],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            timeTable['$index'].toString(),
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
    for (int i = 0; i < 20; i++) _dateTileWidgets.add(dateTiles(i));
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                    children: List.generate(8, (index) {
                  hr = 9 + index;
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
