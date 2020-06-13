import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_alert.dart';
import 'package:parent_app/components/page_header.dart';
import 'package:parent_app/screens/chat_screen.dart';
class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isActivated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Stack(
         children: <Widget>[
           PageHeader(
             
           ),
           Container(
             color: Colors.white,
             margin: EdgeInsets.only(bottom: 60),
             child: DigiAlert(title: 'as',text: 'Not Subscribed!',icon: Icons.chat,),
           ),
//           Center(child: Text("This is chat page")),
         ],
       ),
    );
  }
}