import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/navbar_item.dart';

class DigiBottomNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const DigiBottomNavBar({Key key, this.onChanged, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: MediaQuery.of(context).size.width,
      color: Colors.white30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
              padding: EdgeInsets.all(6),
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NavBarItem(
                    icon: Icons.home,
                    isSelected: selected == 0,
                    onChanged: ()=>this.onChanged(0),
                    text: 'Home',
                  ),
                  NavBarItem(
                    icon: Icons.info,
                    isSelected: selected == 1,
                    onChanged: ()=>this.onChanged(1),
                    text: 'Knowledge',
                  ),
                  NavBarItem(
                    icon: Icons.message,
                    isSelected: selected == 2,
                    onChanged: ()=>this.onChanged(2),
                    text: 'Chat',
                  ),
                  
                ],
              )),
        ),
      ),
    );
  }
}
