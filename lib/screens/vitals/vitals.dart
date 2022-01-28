import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/vitals/setvitals.dart';
import 'package:scarclient/services/authen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Vitals extends StatefulWidget {
  const Vitals({Key? key}) : super(key: key);

  @override
  _VitalsState createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    if (mounted) {
      setState(() {});
      _tabController = TabController(length: myTabs.length, vsync: this);
    } else {
      dispose();
      return;
    }
    super.initState();
  }

  static List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'MY VITALS',
        style: GoogleFonts.merriweather(
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Tab(
      child: Text(
        'ADD VITALS',
        style: GoogleFonts.merriweather(
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ];

  late TabController _tabController;

  // ignore: annotate_overrides
  dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: TabBar(
          indicatorColor: Colors.indigo,
          isScrollable: false,
          dragStartBehavior: DragStartBehavior.start,
          labelStyle:
              GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold),
          labelColor: Colors.black,
          indicatorWeight: 3,
          tabs: myTabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const ScrollPhysics(),
        children: const [ChartsInfo(), SetVitals()],
      ),
    );
  }
}

class ChartsInfo extends StatefulWidget {
  const ChartsInfo({Key? key}) : super(key: key);

  @override
  State<ChartsInfo> createState() => _ChartsInfoState();
}

class _ChartsInfoState extends State<ChartsInfo> {
  NetworkHanler networkhandle = NetworkHanler();
  Widget page = const Center(child: CircularProgressIndicator());

  TooltipBehavior? tooltipbehave;

  @override
  void initState() {
    if (mounted) {
      setState(() {});
      getdata();
      tooltipbehave = TooltipBehavior(enable: true);
    } else {
      dispose();
      return;
    }
    super.initState();
  }

  getdata() async {
    String? pulse;
    String? bodytemp;
    String? pressure;

    String? breathrate;
    var resp = await networkhandle.get('/vitals/vitalsinfo');
    var req = await networkhandle.get('/vitals/checkvitals');
    //print(resp['pulserate']);

    if (resp != null && req['status'] == true) {
      setState(() {
        pulse = resp['pulserate'];
        bodytemp = resp['bodytemperature'];
        pressure = resp['bloodpressure'];
        breathrate = resp['breathingrate'];
      });

      List<Vitalsinfo> getdatachart() {
        final List<Vitalsinfo> datachart = [
          Vitalsinfo('Pulse rate', double.parse(pulse!)),
          Vitalsinfo('Temperature', double.parse(bodytemp!)),
          Vitalsinfo('Blood Pressure', double.parse(pressure!)),
          Vitalsinfo('Breathing Rate', double.parse(breathrate!)),
        ];

        return datachart;
      }

      setState(() {
        page = SfCircularChart(
          title: ChartTitle(
            text: "VITALS",
            textStyle: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          tooltipBehavior: tooltipbehave,
          series: <CircularSeries>[
            RadialBarSeries<Vitalsinfo, String>(
              dataSource: getdatachart(),
              xValueMapper: (Vitalsinfo data, _) => data.vital,
              yValueMapper: (Vitalsinfo data, _) => data.reads,
              enableTooltip: true,
              maximumValue: 150,
            ),
          ],
          legend: Legend(
            textStyle:
                const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            iconHeight: 20,
            iconWidth: 20,
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
        );
      });
    } else {
      setState(() {
        page = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vitals not available',
                style: GoogleFonts.lato(fontSize: 20),
              ),
              Text(
                'Swipe left to add vitals',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(padding: const EdgeInsets.all(30), child: page),
    );
  }
}

class Vitalsinfo {
  String vital;
  double reads;
  Vitalsinfo(this.vital, this.reads);
}
