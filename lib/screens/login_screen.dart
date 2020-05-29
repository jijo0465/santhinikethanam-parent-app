import 'package:flutter/material.dart';
import 'package:parent_app/models/parent.dart';
import 'package:parent_app/services/digi_auth.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/parent_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _id;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('Login Screen'),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Paren Id',
                ),
                onChanged: (value) => _id = value,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
            ),
            Consumer<ParentState>(
              builder:
                  (BuildContext context, ParentState parentState, Widget child) {
                return Consumer<LoginState>(
                  builder: (context, value, child) {
                    return RaisedButton(
                        child: Text('Log in'),
                        onPressed: () async {
                          // value.setStatus(Status.Authenticating);

                          Parent parent =
                              await DigiAuth().signIn(_id, _password);
                          if (parent != null) {
                            parentState.setParent(parent);
                            // Student _student=
                            value.setStatus(Status.Authenticated);
                          }
                        });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
