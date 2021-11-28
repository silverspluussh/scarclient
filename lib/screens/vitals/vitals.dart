import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/Models/vitalsmodel.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';
import 'package:scarclient/screens/vitals/setvitals.dart';
import 'package:scarclient/services/authen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Vitals extends StatefulWidget {
  const Vitals({Key? key}) : super(key: key);

  @override
  _VitalsState createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          onPressed: () async {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const Home(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 35,
          color: Colors.red,
        ),
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
  VitalsModel vitals = VitalsModel(
      name!, bodytemperature!, pulserate!, bloodpressure!, breathingrate!);

  var pulse = '23';

  var bodytemp = '27';

  var pressure = '120';

  var breathrate = '12';

  List<Vitalsinfo>? _datachart;
  late TooltipBehavior tooltipbehave;

  static String? bloodpressure;

  static String? bodytemperature;

  static String? breathingrate;

  static String? name;

  static String? pulserate;

  @override
  void initState() {
    _datachart = getdatachart();
    tooltipbehave = TooltipBehavior(enable: true);
    super.initState();
  }

  void getdata() async {
    var resp = await networkhandle.get('/vitals/vitalsinfo');
    setState(() {
      vitals = VitalsModel.fromJson(resp["data"]);
    });
    while (resp != null) {
      pulse = vitals.pulserate;
      bodytemp = vitals.bodytemperature;
      pressure = vitals.bloodpressure;
      breathrate = vitals.breathingrate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SfCircularChart(
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
              dataSource: _datachart,
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
        ),
      ),
    );
  }

  List<Vitalsinfo> getdatachart() {
    final List<Vitalsinfo> datachart = [
      Vitalsinfo('Pulse rate', double.parse(pulse)),
      Vitalsinfo('Temperature', double.parse(bodytemp)),
      Vitalsinfo('Blood Pressure', double.parse(pressure)),
      Vitalsinfo('Breathing Rate', double.parse(breathrate)),
    ];
    return datachart;
  }
}

class Vitalsinfo {
  String vital;
  double reads;
  Vitalsinfo(this.vital, this.reads);
}
