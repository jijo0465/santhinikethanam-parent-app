import 'package:flutter/material.dart';

class KnowledgeDatabase extends StatefulWidget {
  KnowledgeDatabase({Key key}) : super(key: key);

  @override
  _KnowledgeDatabaseState createState() => _KnowledgeDatabaseState();
}

class _KnowledgeDatabaseState extends State<KnowledgeDatabase> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text('this is knowledge db')),
    );
  }
}