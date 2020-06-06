import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent_app/states/login_state.dart';
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
      backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Center(
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
                height: 50,
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
                width: 300,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) => _id = value,
                  decoration: InputDecoration(

                    labelText: "Teacher Id",
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
                height: 40,
                width: 300,
                child: TextFormField(
                  onChanged: (value) => _password = value,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 180),
                child: Container(
                    child: FlatButton(
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/forgot_password');
//                        },
                        child: Text(
                          'Forgot pin? Contact Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.blue),
                        ))),
              ),
              Consumer<LoginState>(
                builder: (context, value, child) {
                  return Container(
                      height: 40,
                      width: 300,
                      child: RaisedButton(
                        onPressed: () async {
                          await value.signIn(_id, _password);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        color: Colors.pink[200],
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)),
                      ));
                },
              )

            ],
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