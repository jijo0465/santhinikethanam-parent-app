import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HADiscussionScreen extends StatefulWidget {
  const HADiscussionScreen({this.title, Key key, this.subDate, this.date, this.url}) : super(key: key);
  final String title;
  final String subDate;
  final String date;
  final String url;

  @override
  _HADiscussionScreen createState() => _HADiscussionScreen();
}

class _HADiscussionScreen extends State<HADiscussionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _openResult = 'Unknown';

  _launchURL() async {
    String url = widget.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('open result: $_openResult\n'),
            FlatButton(
              child: Text('Tap to open file'),
              onPressed: _launchURL,
            ),
          ],
        ),
      ),
    );
  }
}