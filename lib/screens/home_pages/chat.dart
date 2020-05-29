import 'package:flutter/material.dart';
import 'package:parent_app/components/page_header.dart';
class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           PageHeader(
             
           ),
           Center(child: Text("This is chat page")),
         ],
       ),
    );
  }
}