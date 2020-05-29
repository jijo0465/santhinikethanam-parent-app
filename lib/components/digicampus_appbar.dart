import 'package:flutter/material.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class DigiCampusAppbar extends StatelessWidget {
  final VoidCallback onDrawerTapped;
  final VoidCallback onTrailingTapped;
  final IconData icon;
  final Widget trailing;
  const DigiCampusAppbar(
      {Key key,
      this.onDrawerTapped,
      this.icon,
      this.trailing,
      this.onTrailingTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).padding.top,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
            // tileMode: TileMode.repeated,
          )),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: GestureDetector(
                  onTap: onDrawerTapped,
                  child: Container(
                    child: Icon(icon, color: Colors.white),
                  ),
                ),
              ),
              // Text(
              //   'DigiCampus',
              //   style: TextStyle(
              //       letterSpacing: 1,
              //       color: Colors.white,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w600),
              // ),
              Container(
                  height: 28,
                  width: 28,
                  child: Image.asset('assets/images/digi_campus_logo.png',
                      fit: BoxFit.fill)),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: trailing == null
                      ? Consumer<StudentState>(
                          builder: (context, studentState, _) {
                          return Hero(
                              tag: studentState.selectedstudent.id.toString(),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/${studentState.selectedstudent.id}.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  )));
                        })
                      : trailing,
                  // Icon(
                  //   Icons.notification_important,
                  //   color: Colors.white,
                  // ),
                ),
                onTap: onTrailingTapped,
              )
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
                // tileMode: TileMode.repeated,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(34))),
          height: 50,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}
