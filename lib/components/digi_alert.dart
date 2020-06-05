import 'package:flutter/material.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/screens/icons.dart';
import 'dart:ui';

class DigiAlert extends StatefulWidget{


  _DigiAlertState createState() => _DigiAlertState();
}

class _DigiAlertState extends State<DigiAlert> {
  bool isOpen = false;

  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Container(
            color: Colors.black.withOpacity(0.3),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child:IntrinsicHeight(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: 8,
                child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Icon(DigiIcons.student360_alt,size: 40,color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 14,),

                      SizedBox(height: 16),
                      Container(
//                        padding: EdgeInsets.only(left: 16),
                        child: Text('AI-based insights are in sight! Just subscribe.',style: TextStyle(color: Theme.of(context).primaryColor),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ),
        DigiCampusAppbar(
          icon: Icons.close,
          onDrawerTapped: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );

  }
}



