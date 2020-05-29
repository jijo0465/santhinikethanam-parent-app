import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/remark.dart';
import 'package:parent_app/models/teacher.dart';

class RemarksScreen extends StatefulWidget {
  const RemarksScreen({Key key}) : super(key: key);

  @override
  _RemarksScreenState createState() => _RemarksScreenState();
}

class _RemarksScreenState extends State<RemarksScreen> {
  List<Remark> remark = [];
  static Map<String, dynamic> teacherDetails = {
    "id": 005,
    "teacherId": 1010,
    "name": "Linda Mathew"
  };
  static Teacher teacher = Teacher.fromMap(teacherDetails);

  Map<String, dynamic> remarkDetails = {
    "id": 001,
    "remarks": "Doesn't submit assignments",
    "teacher": teacher
  };
  @override
  void initState() {
    remark.add(Remark.fromMap(remarkDetails));
    remark.add(Remark.fromMap(remarkDetails));
    remark.add(Remark.fromMap(remarkDetails));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              DigiCampusAppbar(
                  icon: Icons.close,
                  onDrawerTapped: () {
                    Navigator.of(context).pop();
                  }),
              SizedBox(height: 12),
              DigiScreenTitle(text: 'Student Remarks'),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(itemCount: remark.length,itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    // Container(child: Text('${index + 1}.')),
                                    Container(
                                        child: Text('${remark[index].remarks}',style: TextStyle(fontSize: 17),
                                            overflow: TextOverflow.ellipsis))
                                  ],
                                ),
                              ),
                              SizedBox(height: 8,),
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          '22/01/2012')),
                                  Container(
                                    alignment: Alignment.centerRight,
                                      child: Text('Remark From : ${remark[index].teacher.name}')),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          )),
    );
  }
}
