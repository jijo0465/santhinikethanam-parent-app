import 'package:flutter/material.dart';

class DigiMenuCard extends StatelessWidget {
  const DigiMenuCard(
      {Key key,
      this.onPressed,
      this.imagePath,
      this.text,
      this.alignText = false,
      this.textScale = 1,
      // this.begin,
      // this.end
      })
      : super(key: key);
  //final IconData menuIcon;
  //final String title, subtitle, value;
  final VoidCallback onPressed;
  final String imagePath;
  final String text;
  final bool alignText;
  final double textScale;
  // final Alignment begin;
  // final Alignment end;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // gradient: LinearGradient(
                //     colors: [Colors.white, Colors.white],
                //     begin: begin,
                //     end: end)
                color: Colors.white
                ),
            child: alignText
                ? Stack(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              // color: Colors.blue[300],
                              borderRadius: new BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  imagePath,
                                ),
                                fit: BoxFit.cover,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black54,
                                //     offset: Offset(0.0, 1.0), //(x,y)
                                //     blurRadius: 4.0,
                                //   ),
                                // ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 12),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            textScaleFactor: textScale,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              // color: Colors.blue[300],
                              borderRadius: new BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(
                                  imagePath,
                                ),
                                fit: BoxFit.cover,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black54,
                                //     offset: Offset(0.0, 1.0), //(x,y)
                                //     blurRadius: 4.0,
                                //   ),
                                // ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            textScaleFactor: textScale,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
