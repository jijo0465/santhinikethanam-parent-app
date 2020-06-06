import 'dart:ui';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onSelected;
  const InfoPage({Key key, this.onSelected, this.currentLanguage})
      : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String selectedLang;

  @override
  void initState() {
    selectedLang = widget.currentLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/school.jpg'),
                    fit: BoxFit.fill)),
          ),
          Container(
              padding: EdgeInsets.all(12),
              child: Text(
                'This app contains more than 200 questions and answers in multiple languages. All the questions are extracted from the Sarathi exam center(Ministry of Road Transport & Highways) which will help to get the drivers license in the first attempt.',
                textWidthBasis: TextWidthBasis.parent,
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
          GestureDetector(
            onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Feature Coming soon!'),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {},
                ))),
            child: Container(
              margin: EdgeInsets.only(left: 4, right: 4),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                      image: AssetImage("assets/vip_user.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              // SizedBox(
              //   width: 4,
              // ),

              SizedBox(
                width: 2,
              ),

              // SizedBox(
              //   width: 4,
              // ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.bottomCenter,
              child: Text('App powered by siphlo ©',
                  style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

}
