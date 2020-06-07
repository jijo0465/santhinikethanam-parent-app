import 'dart:convert';

import 'package:parent_app/models/parent.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DigiAuth{
  SharedPreferences _prfs;
  Future<Student> signIn(String parentId, String password) async {
    _prfs = await SharedPreferences.getInstance();
    Parent parent;
    String url = 'http://api.monkmindsolutions.com/validate';
//    String url = 'http://10.0.2.2:8080/digicampus/auth_api/parent_auth';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {"loginId":parentId,"password":password,"userType":"STUDENT"};
    String data = jsonEncode(params);
    print(jsonEncode(params));
    Student student;
    await http.post(url, headers: headers, body: data).then((response) async {

      if (response.body != null) {
        final Map body = json.decode(response.body);
          print(body);
          student = Student.fromMap(body);

      }
    }).catchError((error) => print(error));

    return student;
  }
}