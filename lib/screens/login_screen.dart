import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
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
    StudentState studentState = Provider.of<StudentState>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        elevation: 1,
                        color: Colors.white,
                        child: Image.asset('assets/images/school_logo.jpeg')),
                  ),
                  Container(
                    child: Text('Santhinikethanam Central School',style: TextStyle(color: Colors.black87,fontSize: 11),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      'Student Sign In',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    // onChanged: (value) => _id = value,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.75,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value) => _id = value,
                      decoration: InputDecoration(
                        labelText: "Student Id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue)),
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.75,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value) => _password = value,
                      decoration: InputDecoration(
                        labelText: "PIN",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.75,
                    alignment: Alignment.centerRight,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/forgot_password');
//                        },
                          child: Text(
                            'Forgot pin? Contact Admin',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, color: Colors.blue,fontSize: 10),
                          ))),
                  Expanded(
                    child: Container(),
                  ),
                  Consumer<LoginState>(
                    builder: (context, value, child) {
                      return Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width*0.9,
                          child: RaisedButton(
                            onPressed: () async {
                              await value.signIn(_id, _password,studentState);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            color: Theme.of(context).primaryColor,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0)),
                          ));
                    },
                  ),

                  SizedBox(height: 12,)

                ],
              ),
            ),
          ),
        )
      // Center(
      //   child: Column(
      //     children: <Widget>[
      //       Container(
      //         child: Text('Login Screen'),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(12),
      //         child: TextFormField(
      //           textInputAction: TextInputAction.next,
      //           keyboardType: TextInputType.number,
      //           decoration: InputDecoration(
      //             labelText: 'Paren Id',
      //           ),
      //           onChanged: (value) => _id = value,
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(12),
      //         child: TextFormField(
      //           textInputAction: TextInputAction.next,
      //           decoration: InputDecoration(
      //             labelText: 'Password',
      //           ),
      //           onChanged: (value) {
      //             _password = value;
      //           },
      //         ),
      //       ),

      //     ],
      //   ),
      // ),
    );
  }
}