import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/reward.dart';
import 'package:parent_app/models/teacher.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({Key key}) : super(key: key);

  @override
  _RatingsScreenState createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  List<Reward> reward = [];
  static Map<String, dynamic> teacherDetails = {
    "id": 005,
    "teacherId": 1010,
    "name": "Bhanumathi"
  };
  static Teacher teacher = Teacher.fromMap(teacherDetails);

  Map<String, dynamic> rewardDetails = {
    "id": 001,
    "reward": 2.3,
    "achievement": "Classil ulla kali thoookki!",
    "teacher": teacher
  };
  @override
  void initState() {
    reward.add(Reward.fromMap(rewardDetails));
    reward.add(Reward.fromMap(rewardDetails));
    reward.add(Reward.fromMap(rewardDetails));
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
              DigiScreenTitle(text: 'Student rewards'),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(itemCount: reward.length,itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(child: Text('${index + 1}.')),
                                Container(
                                  child: RatingBarIndicator(itemSize: 30,itemCount: 3,rating: reward[index].reward,itemBuilder: (BuildContext context,index){
                                    return Container(child:Icon(Icons.star,color: Colors.amber,));
                                  })
                                ),
                                Container(
                                    child: Text('${reward[index].achievement}',
                                        overflow: TextOverflow.ellipsis)),
                                
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Text('rewarded by ${reward[index].teacher.name}')),
                            ],
                          )
                        ],
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