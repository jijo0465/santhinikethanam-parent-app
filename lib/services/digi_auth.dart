import 'dart:convert';

import 'package:parent_app/models/parent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DigiAuth{
  SharedPreferences _prfs;
  Future<Parent> signIn(String parentId, String password) async {
    _prfs = await SharedPreferences.getInstance();
    Parent parent;
    String url = 'http://10.0.2.2:8080/digicampus/auth_api/parent_auth';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {"parentId":parentId,"password":password};
    String data = jsonEncode(params);
    print(jsonEncode(params));
    await http.post(url, headers: headers, body: data).then((response) {
      print(response.body);
      if (response.body != null) {
        final body = json.decode(response.body);
        if(body['response']=='ok'){
          _prfs.setBool('loggedIn', true);
          parent = Parent.fromMap(body);
        }
      }
    }).catchError((error) => print(error));

    return parent;
  }
}