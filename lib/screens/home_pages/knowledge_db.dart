import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_alert.dart';

class KnowledgeDatabase extends StatefulWidget {
  KnowledgeDatabase({Key key}) : super(key: key);

  @override
  _KnowledgeDatabaseState createState() => _KnowledgeDatabaseState();
}

class _KnowledgeDatabaseState extends State<KnowledgeDatabase> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
           child: Center(child: Text('this is knowledge db')),
        ),
        DigiAlert(title: 'Santhinikethanam',icon: Icons.info_outline,)
      ],
    );
  }
}