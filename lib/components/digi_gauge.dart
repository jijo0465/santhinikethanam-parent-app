import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DigiGauge extends StatelessWidget {
  final double value;
  final String text;
  const DigiGauge({Key key, this.value, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 2000,
        title: GaugeTitle(
            text: '',
            textStyle:
                const TextStyle(fontSize: 1.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 20,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 20,
                endValue: 40,
                color: Theme.of(context).primaryColor.withOpacity(0.45),
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 40,
                endValue: 70,
                color: Theme.of(context).primaryColor.withOpacity(0.6),
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 70,
                endValue: 100,
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                startWidth: 10,
                endWidth: 10)
          ], pointers: <GaugePointer>[
            NeedlePointer(value: value,)
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Column(
                  children: <Widget>[
                    Container(
                        child: Text('${value.toInt()}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    Container(
                      child: Text(
                        text,
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 11),
                      ),
                    )
                  ],
                ),
                angle:90,
                positionFactor: 0.8)
          ])
        ]);
  }
}
