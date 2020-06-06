import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_alert.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/screens/icons.dart';

class ScholarshipScreen extends StatefulWidget {
  const ScholarshipScreen({Key key}) : super(key: key);

  @override
  _ScholarshipScreenState createState() => _ScholarshipScreenState();
}

class _ScholarshipScreenState extends State<ScholarshipScreen> {
  final List<Map> scholarshipList = [
    {
      "create": "Scholarship",
      "name": "VFSE Scholarship",
      "date": "2020-06-02",
      "image": "assets/images/ucScholarshi.png"
    },
    {
      "create": "Scholarship",
      "name": "AIMST Registration",
      "date": "2020-05-07",
      "image": "assets/images/ucScholarshi.png"
    },
    {
      "create": "Scholarship",
      "name": "NSQ Competition",
      "date": "2020-06-07",
      "image": "assets/images/ucScholarshi.png"
    },
    {
      "create": "Scholarship",
      "name": "NTSE Registration",
      "date": "2020-06-06",
      "image": "assets/images/ucScholarshi.png"
    },
    // {
    //   "create": "Scholarship",
    //   "name": "Arts Workshop",
    //   "classes": "Java",
    //   "dateFrom": "2020-06-08",
    //   "dateTo": "2020-06-10",
    //   "image": "assets/images/ucScholarshi.png"
    // },
    // {
    //   "create": "Event",
    //   "name": "Mjiv sahfbgu asvhbszhv",
    //   "classes": "Java",
    //   "dateFrom": "2020-06-12",
    //   "dateTo": "2020-06-12",
    //   "image": "assets/images/ucScholarshi.png"
    // },
    // {
    //   "create": "Event",
    //   "name": "Mjiv sahfbgu asvhbszhv",
    //   "classes": "Java",
    //   "dateFrom": "2020-06-23",
    //   "dateTo": "2020-06-23",
    //   "image": "assets/images/ucScholarshi.png"
    // }
  ];
  Comparator<dynamic> dateComparator =
      (a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date']));

  @override
  void initState() {
    // TODO: implement initState
    scholarshipList.sort(dateComparator);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  // DigiScreenTitle(text: 'Upcoming Scholarshi'),
                  // SizedBox(
                  //   height: 12,
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Column(
                            children: List.generate(
                                scholarshipList.length,
                                (index) => Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.9),
                                    elevation: 4,
                                    child: Column(
                                      children: <Widget>[
                                        Stack(
                                          children: [
                                            BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 0.1, sigmaY: 0.1),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                child: Container(
                                                  color: Colors.white.withOpacity(0.6),
                                                  height: 150,
                                                  width: double.infinity,
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/images/scholarships/$index.jpg"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(50),
                                                //   // backgroundBlendMode: BlendMode.dstATop),
                                                // )
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12))),
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.date_range,
                                                      color: Colors.black,
                                                      // size: 18,
                                                      // scholarshipList[
                                                      //                 index][
                                                      //             'dateFrom'] !=
                                                      //         scholarshipList[
                                                      //                 index]
                                                      //             ['date']
                                                      //     ? Theme.of(context)
                                                      //         .primaryColor
                                                      //     : null,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text('On:',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontStyle:
                                                                    FontStyle.italic,
                                                                color: Colors.white)),
                                                        Text(
                                                            scholarshipList[index]
                                                                ['date'],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.white
                                                                // scholarshipList[index]
                                                                //             [
                                                                //             'dateFrom'] !=
                                                                //         scholarshipList[index]
                                                                //             [
                                                                //             'dateTo']
                                                                //     ? Colors
                                                                //         .black
                                                                //     : Colors
                                                                //         .white
                                                                )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 6,)
                                      ],
                                    )))),
                      ),
                    ),
                  )
                ],
              )),
          DigiAlert(title:'Global Scholorships',text:'Boost opportunities with a whole subscription!',icon: DigiIcons.scholarship,)
        ],
      ),
    );
  }
}
