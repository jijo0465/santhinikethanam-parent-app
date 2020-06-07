import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/digi_home.dart';
import 'package:parent_app/screens/home_screen.dart';
import 'package:parent_app/screens/loading_screen.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Redirect extends StatefulWidget {
  const Redirect({Key key}) : super(key: key);

  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  bool _loginStatus = false;
  // GetIt locator =  GetIt();
  // LoginState loginState = locator<>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StudentState studentState = Provider.of<StudentState>(context, listen: false);
    return Consumer<LoginState>(
        builder: (BuildContext context, LoginState value, Widget child) {
      if (_loginStatus!=null && value.status==Status.Uninitialized) {
        SharedPreferences.getInstance().then((prefs) async {
          _loginStatus = prefs.getBool('loggedIn');
          if (_loginStatus == true) {
            String st = (await SharedPreferences.getInstance()).getString('student');
            Map studentMap = json.decode(st);
            Student student = Student.fromMap(studentMap);
            studentState.setStudent(student);
            List<Student> studentList = List<Student>();
            studentList.add(student);
            studentState.setAllStudents(studentList);
            value.setStatus(Status.Authenticated);
          }else{
            value.setStatus(Status.Unauthenticated);
          }
        });
      }
      print(value.status);
      switch (value.status) {
        case Status.Uninitialized:
          return LoadingScreen();
          break;
        case Status.Unauthenticated:
          return LoginScreen();
          break;
        case Status.Authenticating:
          return LoadingScreen();
          break;
        case Status.Authenticated:
          Navigator.of(context).maybePop();
          return DigiHome();
          break;
      }
      return Container();
    });
  }
}
