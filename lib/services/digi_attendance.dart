import 'dart:convert';

import 'package:parent_app/models/attendance.dart';
import 'package:http/http.dart' as http;

class DigiAuth{
  List<Attendance> attendance = [];
  Future<List<Attendance>> getAllAttendance(int studentId) async {
    List<Attendance> attendance;
    String url = 'http://10.0.2.2:8080/digicampus/attendance_api/attendance';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {"studentId": studentId};
    String data = jsonEncode(params);
    print(jsonEncode(params));
    await http.post(url, headers: headers, body: data).then((response) {
      print(response.body);
      if (response.body != null) {
        final body = json.decode(response.body);
        for(var a in body){
          attendance.add(Attendance.fromMap(a));
        }
      }
    }).catchError((error) => print(error));

    return attendance;
  }
  
  Future<Attendance> getAttendance(int studentId, DateTime date) async {
    Attendance attendance;
    String url = 'http://10.0.2.2:8080/digicampus/attendance_api/attendance';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {"studentId": studentId, "date": date};
    String data = jsonEncode(params);
    print(jsonEncode(params));
    await http.post(url, headers: headers, body: data).then((response) {
      print(response.body);
      if (response.body != null) {
        final body = json.decode(response.body);
        attendance = Attendance.fromMap(body);
        // if(body['response']=='ok'){
        //   _prfs.setBool('loggedIn', true);
        //   parent = Parent.fromMap(body);
        // }
      }
    }).catchError((error) => print(error));

    return attendance;
  }
}