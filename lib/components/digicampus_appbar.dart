import 'package:flutter/material.dart';

class DigiCampusAppbar extends StatelessWidget {
  final VoidCallback onDrawerTapped;
  final String title;
  final IconData icon;
  const DigiCampusAppbar({Key key, this.onDrawerTapped, this.icon, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).padding.top,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
                // tileMode: TileMode.repeated,
              )),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 60,
                child: icon==null?Container(
                  height: 20,
                  child: Image.asset('assets/images/digi_campus_logo.png'),
                ):IconButton(
                  padding:EdgeInsets.only(left: 12,right: 12),
                  icon:Icon(icon, color: Colors.white,size: 22,),onPressed:
                onDrawerTapped
                  ,),
              ),
              // Text(
              //   'DigiCampus',
              //   style: TextStyle(
              //       letterSpacing: 1,
              //       color: Colors.white,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w600),
              // ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
//                  child: Image.asset('assets/images/digi_campus_logo.png',
//                      fit: BoxFit.fill)),
                  child: Text('$title',style: TextStyle(color: Colors.white,fontSize: 16),),
//              Padding(
//                padding: const EdgeInsets.only(right: 30),
//                child: Container(
//                    height: 30,
//                    width: 30,
//                    child: IconButton(
//                        icon: Icon(Icons.notification_important,color: Colors.white,),
//                        onPressed: (){})),
//              ),

                  // Icon(
                  //   Icons.notification_important,
                  //   color: Colors.white,
                  // ),
                ),
              ),
              SizedBox(width: 60,)
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
              // tileMode: TileMode.repeated,
            ),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}
