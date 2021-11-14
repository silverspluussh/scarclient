import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/services/authen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsInfo extends StatefulWidget {
  const ChartsInfo({Key? key}) : super(key: key);

  @override
  State<ChartsInfo> createState() => _ChartsInfoState();
}

class _ChartsInfoState extends State<ChartsInfo> {
  NetworkHanler networkhandle = NetworkHanler();

  String pulse = '23.0';

  String bodytemp = '27.0';

  String pressure = '120.0';

  String breathrate = '12.0';

  List<Vitalsinfo>? _datachart;
  late TooltipBehavior tooltipbehave;

  void getvitals() async {
    var response = await networkhandle.get('/vitals/vitalsinfo');
  }

  @override
  void initState() {
    _datachart = getdatachart();
    tooltipbehave = TooltipBehavior(enable: true);
    super.initState();
    getvitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfCircularChart(
          title: ChartTitle(
            text: "Overall Vitals",
            textStyle: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: tooltipbehave,
          series: <CircularSeries>[
            RadialBarSeries<Vitalsinfo, String>(
              dataSource: _datachart,
              xValueMapper: (Vitalsinfo data, _) => data.vital,
              yValueMapper: (Vitalsinfo data, _) => data.reads,
              enableTooltip: true,
              maximumValue: 200,
            )
          ],
        ),
      ),
    );
  }

  List<Vitalsinfo> getdatachart() {
    final List<Vitalsinfo> datachart = [
      Vitalsinfo('Pulse rate', int.parse(pulse)),
      Vitalsinfo('Temperature', int.parse(bodytemp)),
      Vitalsinfo('Blood Pressure', int.parse(pressure)),
      Vitalsinfo('Breathing Rate', int.parse(breathrate)),
    ];
    return datachart;
  }
}

class Vitalsinfo {
  String vital;
  int reads;
  Vitalsinfo(this.vital, this.reads);
}
