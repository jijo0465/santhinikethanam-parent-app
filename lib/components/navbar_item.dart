import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final VoidCallback onChanged;
  final IconData icon;
  final bool isSelected;
  final String text;
  const NavBarItem({Key key, this.icon, this.isSelected, this.onChanged, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onChanged,
        child: Container(
          alignment: Alignment.topCenter,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                icon,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                size: 23,
              ),
              Text(
                text,
                style: TextStyle(
                    color: isSelected? Theme.of(context).primaryColor : Colors.grey,
                    fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
