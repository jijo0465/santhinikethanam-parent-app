import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parent_app/components/digi_marker_generator.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class SchoolBusScreen extends StatefulWidget {
  const SchoolBusScreen({Key key}) : super(key: key);

  @override
  _SchoolBusScreenState createState() => _SchoolBusScreenState();
}

class _SchoolBusScreenState extends State<SchoolBusScreen> {
  bool isLoading = true;
  LatLng busLocation;
  BitmapDescriptor locationPinIcon;
  Marker marker;
  GoogleMapController mapController;
  List<Widget> markerWidgets = [
    Container(
        // color: Colors.black,
        height: 120,
        width: 200,
        // child: Column(
        //   children: <Widget>[
        //     Icon(Icons.my_location,size: 80,),
        //     Icon(Icons.train,size: 60,),

        //   ],
        // )),
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/schoolbus.png',
          ),
        ))
  ];
  List<Uint8List> value;

  final markerKey = GlobalKey();
// return RepaintBoundary(
//   key: markerKey,
//   child: customMarkerWidget,
// );

  @override
  void initState() {
    busLocation = LatLng(15.496777, 73.827827);
    DigiMarkerGenerator(markerWidgets, (value) {
      // value = await callback;
      print(value);
      marker = Marker(
          markerId: MarkerId("bus_loc"),
          position: busLocation,
          // infoWindow: InfoWindow(title: 'Bus Location'),
          icon: BitmapDescriptor.fromBytes(value.first)
          // icon: locationPinIcon,
          );
      setState(() {
        isLoading = false;
      });
    }).generate(context);
    // marker = Marker(
    //     markerId: MarkerId("bus_loc"),
    //     position: busLocation,
    //     infoWindow: InfoWindow(title: 'Bus Location'),
    //     icon: BitmapDescriptor.fromBytes(value.first)
    //     // icon: locationPinIcon,
    //   );
//     BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 0.025),
//             'assets/images/schoolbus.png')
//         .then((onValue) {
//     //   locationPinIcon = onValue;
//       // marker =

// //       Marker(
// //     position: position,
// //     icon: BitmapDescriptor.fromBytes(markerUint8List)
// // )
//       setState(() {
//         isLoading = false;
//       });
//     }); //_markers.clear();
    super.initState();
  }

  void driveCamera(mapController) {
    //   _markers.add(marker);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(busLocation, 15));
    // busLocation = LatLng((busLocation.latitude + 0.002500), 73.827827);
    // //driveCamera();
    //mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(8.5069, 76.9569), 15));
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/schoolbus.png'), context);
    return Scaffold(
        body: isLoading
            ? Container()
            : Stack(
                children: <Widget>[
                  Column(children: <Widget>[
                    DigiCampusAppbar(
                      icon: Icons.close,
                      onDrawerTapped: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: 12),
                    DigiScreenTitle(text: 'School Bus Tracking'),
                    SizedBox(height: 12),
                    Expanded(
                      child: GoogleMap(
                          padding: EdgeInsets.all(6),
                          markers: Set.of((marker != null) ? [marker] : []),
                          initialCameraPosition:
                              CameraPosition(target: busLocation),
                          onMapCreated: (mapController) {
                            driveCamera(mapController);
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ]),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.blue[600],
                                Colors.blue[400],
                                Colors.blue[600]
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 16,
                        child: Text(
                          'Contact Driver',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16,color: Colors.grey[900]),
                        ),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(50),
                        //   topRight: Radius.circular(50),
                        // )),
                      ),
                    ),
                  )
                ],
              ));
  }
}
