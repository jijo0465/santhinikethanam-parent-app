import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:parent_app/models/parent.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/services/digi_auth.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }


class LoginState with ChangeNotifier {
  static Status _status = Status.Uninitialized;
  SharedPreferences _prfs;

  LoginState.instance();

  Status get status => _status;

  Future<bool> signIn(String parentId, String password, StudentState studentState) async {
    _status = Status.Authenticating;
    notifyListeners();
    DigiAuth digiAuth = DigiAuth();
    Student student = await digiAuth.signIn(parentId, password);
    if(student!=null){
      print('student is not null');
      studentState.setStudent(student);
      List<Student> studentList = List<Student>();
      studentList.add(student);
      studentState.setAllStudents(studentList);
      _status = Status.Authenticated;
      _prfs = await SharedPreferences.getInstance();
      await _prfs.setBool('loggedIn',true);
      await _prfs.setString('student', json.encode(student));
      notifyListeners();
    }else{
      print('student is null');
      _status = Status.Unauthenticated;
      _prfs = await SharedPreferences.getInstance();
      await _prfs.setBool('loggedIn',false);
      notifyListeners();
    }

    return true;
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    _prfs = await SharedPreferences.getInstance();
    _prfs.setBool('loggedIn',false);  
  }
  Future<bool> setStatus(Status _statusUpdate) async {
    _status = _statusUpdate;
    notifyListeners();
    return true;
  }

}
