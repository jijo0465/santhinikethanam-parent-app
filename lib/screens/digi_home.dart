import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/components/home_card.dart';
import 'package:parent_app/components/home_header.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'home_pages/dashboard.dart';


class DigiHome extends DrawerContent {
  DigiHome({Key key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

HiddenDrawerController drawerController;

class _HomeScreenState extends State<DigiHome> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    drawerController = HiddenDrawerController(
      initialPage: HomePage(
        title: 'main',
        onPressed: (){drawerController.open();},
      ),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.black)),
          icon: Icon(Icons.home, color: Colors.black),
        ),
        DrawerItem(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.black),
          ),
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () async {
            await Navigator.of(context).pushNamed('/settings');
            drawerController.close();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState value, Widget child) {
        if (value.status == Status.Unauthenticated) {
          return LoginScreen();
        } else {
          return Scaffold(
            // bottomNavigationBar: SizedBox(
            //   // height: 60,
            //   child: BottomNavigationBar(
            //       type: BottomNavigationBarType.fixed,
            //       selectedItemColor: Theme.of(context).primaryColor,
            //       unselectedItemColor: Colors.grey,
            //       onTap: (index) {
            //         if (index == 1) Navigator.of(context).pushNamed('/chat');
            //         if (index == 2) Navigator.of(context).pushNamed('/notes');
            //       },
            //       items: [
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.home, size: 30,),
            //           title: Text(
            //             'Home',
            //             style: TextStyle(fontSize: 10),
            //           ),
            //         ),
            //         BottomNavigationBarItem(
            //             icon: Icon(Icons.message), title: Text('Chat')),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.art_track),
            //           title: Text('Notes'),
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.info),
            //           title: Text('About'),
            //         ),
            //       ]),
            // ),
            body: HiddenDrawer(
              controller: drawerController,
              header: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 66,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/images/sir.jpg',
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Rachel green',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            RaisedButton(
                                child: Text('Signout'),
                                onPressed: () {
                                  value.signOut();
                                })
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 34, child: Container())
                  ],
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.7),
                      Theme.of(context).primaryColor.withOpacity(0.8),
                      Theme.of(context).primaryColor
                    ]
                    // tileMode: TileMode.repeated,
                    ),
              ),
            ),
          );
        }
      },
    );
  }
}


