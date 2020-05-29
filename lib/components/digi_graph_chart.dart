import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatelessWidget {
  final int index;
  Charts({Key key, this.index}) : super(key: key);
  List<charts.Series<MarksAnalysis, String>> seriesList;
  _createSampleData() {
    var data = [
      [
        new MarksAnalysis(1, 65, 'Mid-\nTerm'),
        new MarksAnalysis(1, 80, 'Half\nYearly'),
        new MarksAnalysis(1, 75, 'Mid\nterm II'),
        new MarksAnalysis(1, 70, 'Quarterly'),
        new MarksAnalysis(1, 88, 'Model'),
        new MarksAnalysis(1, 85, 'Final'),
        new MarksAnalysis(1, 85, 'Final2'),
        new MarksAnalysis(1, 85, 'Final3'),
        new MarksAnalysis(1, 85, 'Final4')
      ],
      [
        new MarksAnalysis(2, 80, 'Mid\nTerm'),
        new MarksAnalysis(2, 86, 'Half\nYearly'),
        new MarksAnalysis(2, 70, 'Mid\nterm II'),
        new MarksAnalysis(2, 75, 'Quarterly'),
        new MarksAnalysis(2, 80, 'Model'),
        new MarksAnalysis(2, 78, 'Final'),
        new MarksAnalysis(2, 85, 'Final2'),
        new MarksAnalysis(2, 85, 'Final3'),
        new MarksAnalysis(2, 85, 'Final4')
      ],
      [
        new MarksAnalysis(3, 90, 'Mid\nTerm'),
        new MarksAnalysis(3, 80, 'Half\nYearly'),
        new MarksAnalysis(3, 65, 'Mid\nterm II'),
        new MarksAnalysis(3, 80, 'Quarterly'),
        new MarksAnalysis(3, 85, 'Model'),
        new MarksAnalysis(3, 96, 'Final'),
        new MarksAnalysis(3, 85, 'Final2'),
        new MarksAnalysis(3, 85, 'Final3'),
        new MarksAnalysis(3, 85, 'Final4')
      ],
      [
        new MarksAnalysis(4, 70, 'Mid\nTerm'),
        new MarksAnalysis(4, 80, 'Half\nYearly'),
        new MarksAnalysis(4, 94, 'Mid\nterm II'),
        new MarksAnalysis(4, 78, 'Quarterly'),
        new MarksAnalysis(4, 88, 'Model'),
        new MarksAnalysis(4, 75, 'Final'),
        new MarksAnalysis(4, 85, 'Final2'),
        new MarksAnalysis(4, 85, 'Final3'),
        new MarksAnalysis(4, 85, 'Final4')
      ],
      [
        new MarksAnalysis(5, 85, 'Mid\nTerm'),
        new MarksAnalysis(5, 45, 'Half\nYearly'),
        new MarksAnalysis(5, 75, 'Mid\nterm II'),
        new MarksAnalysis(5, 60, 'Quarterly'),
        new MarksAnalysis(5, 80, 'Model'),
        new MarksAnalysis(5, 70, 'Final'),
        new MarksAnalysis(5, 85, 'Final2'),
        new MarksAnalysis(5, 85, 'Final3'),
        new MarksAnalysis(5, 85, 'Final4'),
      ],
      [
        new MarksAnalysis(6, 70, 'Mid\nTerm'),
        new MarksAnalysis(6, 73, 'Half\nYearly'),
        new MarksAnalysis(6, 75, 'Mid\nterm II'),
        new MarksAnalysis(6, 75, 'Quarterly'),
        new MarksAnalysis(6, 80, 'Model'),
        new MarksAnalysis(6, 78, 'Final'),
        new MarksAnalysis(6, 85, 'Final2'),
        new MarksAnalysis(6, 85, 'Final3'),
        new MarksAnalysis(6, 85, 'Final4')
      ],
      [
        new MarksAnalysis(7, 85, 'Mid\nTerm'),
        new MarksAnalysis(7, 80, 'Half\nYearly'),
        new MarksAnalysis(7, 60, 'Mid\nterm II'),
        new MarksAnalysis(7, 85, 'Quarterly'),
        new MarksAnalysis(7, 90, 'Model'),
        new MarksAnalysis(7, 88, 'Final'),
        new MarksAnalysis(7, 85, 'Final2'),
        new MarksAnalysis(7, 85, 'Final3'),
        new MarksAnalysis(7, 85, 'Final4')
      ]
    ];
    seriesList.add(charts.Series<MarksAnalysis, String>(
      id: 'Marks %',
      colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      fillColorFn: ((_, __) =>
            charts.MaterialPalette.deepOrange.shadeDefault.lighter
      ),
      domainFn: (MarksAnalysis totalPercent, _) => totalPercent.name,
      measureFn: (MarksAnalysis totalPercent, _) => totalPercent.totalPercent,
      labelAccessorFn: (MarksAnalysis totalPercent, _) =>
          '${totalPercent.totalPercent.toString()}%',
      data: data.elementAt(index),
    ));
  }

  void findAverage() {}

  @override
  Widget build(BuildContext context) {
    seriesList = List<charts.Series<MarksAnalysis, String>>();
    _createSampleData();
    // TODO: implement build
    return Container(
        child: charts.BarChart(
      seriesList,
      defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: charts.ConstCornerStrategy(5),
          barRendererDecorator: charts.BarLabelDecorator<String>(
            labelPosition: charts.BarLabelPosition.outside,
          )),
      primaryMeasureAxis:
          charts.NumericAxisSpec(viewport: charts.NumericExtents(0.0,100.0),tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
      domainAxis:
          charts.OrdinalAxisSpec(viewport: charts.OrdinalViewport('AePS', 5)),
      animate: true,
      animationDuration: Duration(milliseconds: 400),
      behaviors: [
        charts.SeriesLegend(),
        charts.SlidingViewport(),
        charts.PanAndZoomBehavior()
      ],
    ));
  }
}

/// Sample ordinal data type.
class MarksAnalysis {
  final int exam;
  final int totalPercent;
  final String name;
  MarksAnalysis(this.exam, this.totalPercent, this.name);
}
