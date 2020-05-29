//import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:parent_app/components/digi_key_value_display.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class InOutScreen extends StatefulWidget {
  final DateTime amBusInTime,
      amBusOutTime,
      pmBusInTime,
      pmBusOutTime,
      schoolInTime,
      schoolOutTime;

  const InOutScreen(
      {Key key,
      this.amBusInTime,
      this.amBusOutTime,
      this.pmBusInTime,
      this.pmBusOutTime,
      this.schoolInTime,
      this.schoolOutTime})
      : super(key: key);

  @override
  _InOutScreenState createState() => _InOutScreenState();
}

class _InOutScreenState extends State<InOutScreen> {
  DateTime startDate = DateTime(2019, 05, 15);
  DateTime endDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  CalendarController _calendarController;
  double _height = 180;
  //Map _calendarFormats={CalendarFormat.week:''};

  @override
  void initState() {
    initializeDateFormatting();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _height = 0;
      });
    });
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void updateCalendar() {
    setState(() {
      _calendarController.setSelectedDay(selectedDate, runCallback: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(children: [
        DigiCampusAppbar(
          icon: Icons.close,
          onDrawerTapped: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(height: 12),
        DigiScreenTitle(text: 'Student In/Out Details'),
        Container(
          alignment: Alignment.center,
          child: TableCalendar(
            calendarController: _calendarController,
            formatAnimation: FormatAnimation.slide,
            availableGestures: AvailableGestures.horizontalSwipe,
            initialCalendarFormat: CalendarFormat.week,
            availableCalendarFormats: {
              CalendarFormat.week: 'Week',
              CalendarFormat.twoWeeks: '2 Weeks'
            },
            calendarStyle: CalendarStyle(
              outsideStyle:
                  TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              selectedColor: Theme.of(context).primaryColor,
              selectedStyle: TextStyle(color: Colors.red[300], fontSize: 16),
              todayColor: Colors.blue[800],
            ),
            headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey
                ),
                titleTextStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800])),
            onHeaderTapped: (date) {
              showMonthPicker(
                      context: context,
                      initialDate: date,
                      firstDate: startDate,
                      lastDate: endDate)
                  .then((date) {
                selectedDate = date;
                updateCalendar();
              });
            },
            onDaySelected: (date, list) {},
          ),
        ),
        SizedBox(height: 6),
        AnimatedPadding(
          padding: EdgeInsets.only(top: _height),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInSine,
          ),
        Expanded(
          flex: 1,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                Text(
                  'School Campus In/Out Details :',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8)),
                ),
                Column(children: <Widget>[
                  DigiKeyValueDisplay(
                      textKey: 'In-Time ',
                      textValue: widget.schoolInTime.toString(),
                      textColor: Colors.black),
                  DigiKeyValueDisplay(
                      textKey: 'Out-Time ',
                      textValue: widget.schoolOutTime.toString(),
                      textColor: Colors.black),
                ]),
                Text(
                  'SchoolBus In/Out Details :',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      ' Morning :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DigiKeyValueDisplay(
                        textKey: 'In-Time ',
                        textValue: widget.amBusInTime.toString(),
                        textColor: Colors.black),
                    DigiKeyValueDisplay(
                        textKey: 'Out-Time ',
                        textValue: widget.amBusOutTime.toString(),
                        textColor: Colors.black),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      ' Evening :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DigiKeyValueDisplay(
                        textKey: 'In-Time ',
                        textValue: widget.pmBusInTime.toString(),
                        textColor: Colors.black),
                    DigiKeyValueDisplay(
                        textKey: 'Out-Time ',
                        textValue: widget.pmBusOutTime.toString(),
                        textColor: Colors.black),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            //height: 120 - MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
          ),
        )
      ])
    ]));
  }
  // Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 100,
  //     child:
//                  CalendarStrip(
//                     monthNameWidget: monthNameWidget,
//                     addSwipeGesture: true,
//                     containerHeight: 100,
//                     selectedDate: markedDates.first,
//                     startDate: _startDate,
//                     endDate: DateTime.now(),
//                     markedDates: markedDates,
//                     onDateSelected: (date) {
//                       setState(() {
//                         selectedDate = date;
//                       });
//                     },
//                     iconColor: Colors.black87,
//                     //containerDecoration: BoxDecoration(color: Colors.black12),
//                     dateTileBuilder: dateTileBuilder
//                     )])
//           ]),
//     );
//   }

//   monthNameWidget(monthName) {
//     print(monthName);
//     return GestureDetector(
//       onTap: () {
//         showMonthPicker(
//                 context: context,
//                 initialDate: selectedDate,
//                 firstDate: _startDate,
//                 lastDate: DateTime.now())
//             .then((date) async* {

//           if (date != null) {
//             //dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange);
//             //await Future.delayed(Duration(milliseconds: 500));
//             markedDates.removeLast();
//             setState(() {
//               selectedDate = date;
//               markedDates.add(selectedDate);
//               _startDate=DateTime(date.year,date.month,1);
//               _endDate=DateTime(date.year,date.month+1,1).subtract(Duration(days:1));
//             });
//           }
//           //_startDate=DateTime(_pickedMonth.year,_pickedMonth.month,1);
//           //isMonthTapped = false;
//         });
//         // setState(() {
//         //   isMonthTapped = true;
//         // });
//       },
//       child: Container(
//         child: Text(
//           monthName,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w800,
//             color: Colors.blue[800],
//             //fontStyle: FontStyle.italic,
//           ),
//         ),
//         padding: EdgeInsets.only(top: 8, bottom: 4),
//       ),
//     );
//   }

//   getMarkedIndicatorWidget() {
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Container(
//         margin: EdgeInsets.only(left: 1, right: 1),
//         width: 7,
//         height: 7,
//         decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//       ),
//       Container(
//         width: 7,
//         height: 7,
//         decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//       )
//     ]);
//   }

//   dateTileBuilder(
//       date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
//     bool isSelectedDate = date.compareTo(selectedDate) == 0;
//     Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
//     TextStyle normalStyle =
//         TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: fontColor);
//     TextStyle selectedStyle =
//         TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.red);
//     TextStyle dayNameStyle = TextStyle(fontSize: 12, color: fontColor);
//     List<Widget> _children = [
//       Text(dayName, style: dayNameStyle),
//       Text(date.day.toString(),
//           style: !isSelectedDate ? normalStyle : selectedStyle),
//     ];
//     if (isDateMarked == true) {
//       _children.add(getMarkedIndicatorWidget());
//     }
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       alignment: Alignment.center,
//       padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
//       decoration: BoxDecoration(
//         color: !isSelectedDate ? Colors.transparent : Colors.blue[100],
//         borderRadius: BorderRadius.all(Radius.circular(60)),
//       ),
//       child: Column(
//         children: _children,
//       ),
//     );
//   }
// }
}
