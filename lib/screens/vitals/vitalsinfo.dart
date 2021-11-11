import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:scarclient/services/authen.dart';

// ignore: must_be_immutable
class CustomRoundedBars extends StatelessWidget {
  List<charts.Series<OrdinalSales, String>>? seriesList;
  bool? animate;
  List<charts.Series<OrdinalSales, String>>? createSampleData;

  // ignore: use_key_in_widget_constructors
  CustomRoundedBars({
    this.createSampleData,
    this.seriesList,
    this.animate,
  });

  factory CustomRoundedBars.withSampleData() {
    return CustomRoundedBars(
      createSampleData: _createSampleData(),
      animate: false,
      seriesList: const [],
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    var pulse = '';
    var bodytemp = '';
    var pressure = '';
    var breathrate = '';

    // ignore: unused_element
    getvitals() async {
      NetworkHanler networkhandle = NetworkHanler();
      var response = await networkhandle.get('/vitals/vitals');
      pulse = response['pulse_rate'];
      bodytemp = response['body_temperature'];
      pressure = response['blood_pressure'];
      breathrate = response['breathing_rate'];
    }

    final data = [
      OrdinalSales('Blood pressure', int.parse(pressure)),
      OrdinalSales('Breathing rate', int.parse(breathrate)),
      OrdinalSales('Temperature', int.parse(bodytemp)),
      OrdinalSales('Pulse rate', int.parse(pulse)),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales vitals, _) => vitals.vital,
        measureFn: (OrdinalSales vitals, _) => vitals.reading,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList!,
      animate: animate,
      defaultRenderer: charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(30),
      ),
    );
  }
}

class OrdinalSales {
  final String vital;
  final int reading;

  OrdinalSales(this.vital, this.reading);
}
