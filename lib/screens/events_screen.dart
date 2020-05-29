import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<Map> eventsList = [
    {
      "create": "Event",
      "name": "Annual Day 2020",
      "classes": "Java",
      "dateFrom": "2020-06-02",
      "dateTo": "2020-06-02",
      "image": "assets/images/ucevents.png"
    },
    {
      "create": "Event",
      "name": "Karate Tournament",
      "classes": "Java",
      "dateFrom": "2020-05-05",
      "dateTo": "2020-05-07",
      "image": "assets/images/ucevents.png"
    },
    {
      "create": "Event",
      "name": "Chess Competition",
      "classes": "Java",
      "dateFrom": "2020-06-07",
      "dateTo": "2020-06-07",
      "image": "assets/images/ucevents.png"
    },
    {
      "create": "Event",
      "name": "Football All Kerala Meet",
      "classes": "Java",
      "dateFrom": "2020-06-06",
      "dateTo": "2020-06-06",
      "image": "assets/images/ucevents.png"
    },
    {
      "create": "Event",
      "name": "Arts Workshop",
      "classes": "Java",
      "dateFrom": "2020-06-08",
      "dateTo": "2020-06-10",
      "image": "assets/images/ucevents.png"
    },
    // {
    //   "create": "Event",
    //   "name": "Mjiv sahfbgu asvhbszhv",
    //   "classes": "Java",
    //   "dateFrom": "2020-06-12",
    //   "dateTo": "2020-06-12",
    //   "image": "assets/images/ucevents.png"
    // },
    // {
    //   "create": "Event",
    //   "name": "Mjiv sahfbgu asvhbszhv",
    //   "classes": "Java",
    //   "dateFrom": "2020-06-23",
    //   "dateTo": "2020-06-23",
    //   "image": "assets/images/ucevents.png"
    // }
  ];
  Comparator<dynamic> dateComparator = (a, b) =>
      DateTime.parse(a['dateFrom']).compareTo(DateTime.parse(b['dateFrom']));

  @override
  void initState() {
    // TODO: implement initState
    eventsList.sort(dateComparator);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          child: Column(
            children: [
              DigiCampusAppbar(
                icon: Icons.close,
                onDrawerTapped: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12,
              ),
              DigiScreenTitle(text: 'Upcoming Events'),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                        children: List.generate(
                            eventsList.length,
                            (index) => Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                color: Theme.of(context).primaryColor.withOpacity(0.9),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: Container(
                                        height: 150,
                                        width: double.infinity,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/events/event_$index.jpg"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      // decoration: BoxDecoration(
                                      //   borderRadius:
                                      //       BorderRadius.circular(50),
                                      //   // backgroundBlendMode: BlendMode.dstATop),
                                      // )
                                    ),
                                    Container(
                                        color: Colors.white,
                                        child:
                                            // eventsList[index]['dateFrom'] !=
                                            //         eventsList[index]['dateTo']
                                            //     ?
                                            Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  color: Theme.of(context).primaryColor,
                                                  size: 30,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        eventsList[index][
                                                                    'dateFrom'] !=
                                                                eventsList[
                                                                        index]
                                                                    ['dateTo']
                                                            ? 'From:'
                                                            : 'On:',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontStyle: FontStyle
                                                                .italic)),
                                                    Text(
                                                        eventsList[index]
                                                            ['dateFrom'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            )),
                                            Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  color: eventsList[index]
                                                              ['dateFrom'] !=
                                                          eventsList[index]
                                                              ['dateTo']
                                                      ? Theme.of(context).primaryColor
                                                      : Colors.white,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('To:',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: eventsList[
                                                                            index]
                                                                        [
                                                                        'dateFrom'] !=
                                                                    eventsList[
                                                                            index]
                                                                        [
                                                                        'dateTo']
                                                                ? Colors.black
                                                                : Colors
                                                                    .white)),
                                                    Text(
                                                        eventsList[index]
                                                            ['dateTo'],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: eventsList[
                                                                            index]
                                                                        [
                                                                        'dateFrom'] !=
                                                                    eventsList[
                                                                            index]
                                                                        [
                                                                        'dateTo']
                                                                ? Colors.black
                                                                : Colors
                                                                    .white)),
                                                  ],
                                                )
                                              ],
                                            ))
                                          ],
                                        )
                                        //       : Container(
                                        //         // padding: MediaQuery.of(context).padding.left,
                                        //           margin: EdgeInsets.only(left: 20),
                                        //           child: Row(
                                        //             // mainAxisAlignment:
                                        //             //     MainAxisAlignment.center,
                                        //             children: [
                                        //               Icon(
                                        //                 Icons.date_range,
                                        //                 color: Colors.blue,
                                        //                 size: 30,
                                        //               ),
                                        //               Column(
                                        //                 crossAxisAlignment:
                                        //                     CrossAxisAlignment
                                        //                         .start,
                                        //                 children: <Widget>[
                                        //                   Text('On:',
                                        //                       style: TextStyle(
                                        //                           fontSize: 10,
                                        //                           fontStyle:
                                        //                               FontStyle
                                        //                                   .italic)),
                                        //                   Text(
                                        //                       eventsList[index]
                                        //                           ['dateFrom'],
                                        //                       style: TextStyle(
                                        //                         fontSize: 12,
                                        //                       )),
                                        //                 ],
                                        //               )
                                        //             ],
                                        //           )),
                                        // )
                                        ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      // decoration: BoxDecoration(
                                      //     color: Colors.blue,
                                      //     borderRadius:
                                      //         BorderRadius.only(
                                      //       bottomLeft:
                                      //           Radius.circular(12),
                                      //       bottomRight:
                                      //           Radius.circular(12),
                                      //     )),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(eventsList[index]['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )))),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
