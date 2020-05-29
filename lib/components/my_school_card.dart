import 'package:flutter/material.dart';

class MySchoolCard extends StatelessWidget {
  // final Widget icon;
  // final Color color;
  final String menuPath;
  final VoidCallback onPressed;
  const MySchoolCard(
      {Key key, this.menuPath, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
                ),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(menuPath),
        ),
      ),
    );
  }
}
