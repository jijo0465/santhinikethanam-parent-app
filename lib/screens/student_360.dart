import 'package:flutter/material.dart';
import 'package:nima/nima_actor.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:parent_app/components/digi_gauge.dart';

class Student360Screen extends StatelessWidget {
  const Student360Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SyncfusionLicense.registerLicense(
        'NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmg5Ojk8Y2dlZhM0PjI6P30wPD4=');
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Theme.of(context).primaryColor.withOpacity(0.15)),
          Column(
            children: <Widget>[
              DigiCampusAppbar(
                icon: Icons.close,
                onDrawerTapped: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 8),
              Expanded(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      
                      Positioned(
                        top: MediaQuery.of(context).size.height *0.24,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          child: NimaActor(
                            'assets/animations/superman-podium.nma',
                            fit: BoxFit.fitHeight,
                            animation: 'Untitled',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 15,
                        child: Container(
                          height: 160,
                          width: 160,
                          child: DigiGauge(
                            value: 90,
                            text: 'Academics',
                          ),
                        ),
                        
                      ),
                      Positioned(
                        top: 10,
                        right: 15,
                        child: Container(
                          height: 160,
                          width: 160,
                          child: DigiGauge(
                            value: 70,
                            text: 'Value Education',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 210,
                        left: 0,
                        child: Container(
                          height: 120,
                          width: 120,
                          child: DigiGauge(
                            value: 50,
                            text: 'Consistency',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 210,
                        right: 0,
                        child: Container(
                          height: 120,
                          width: 120,
                          child: DigiGauge(
                            value: 62,
                            text: 'Arts & Sports',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 12,
                        child: Container(
                          height: 170,
                          width: 170,
                          child: DigiGauge(
                            value: 88,
                            text: 'Communication',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        right: 12,
                        child: Container(
                          height: 170,
                          width: 170,
                          child: DigiGauge(
                            value: 90,
                            text: 'Extra Curriculum',
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
