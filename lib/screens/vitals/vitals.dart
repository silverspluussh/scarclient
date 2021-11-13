import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/navigation_index.dart';
import 'package:scarclient/screens/vitals/setvitals.dart';
import 'package:scarclient/screens/vitals/vitalsinfo.dart';

class Vitals extends StatefulWidget {
  const Vitals({Key? key}) : super(key: key);

  @override
  _VitalsState createState() => _VitalsState();
}

// ignore: camel_case_types
class vitalsInfo {
  int pulserate;
  String bloodpressure;
  String? breathingrate;
  String? bodytemperature;
  vitalsInfo(
    this.bloodpressure,
    this.bodytemperature,
    this.breathingrate,
    this.pulserate,
  );
}

class _VitalsState extends State<Vitals> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'MY VITALS',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Tab(
      child: Text(
        'ADD VITALS',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
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
        children: [vitalsbuild(), const SetVitals()],
      ),
    );
  }
}

Widget vitalsbuild() {
  return SizedBox(
    child: ListView(
      children: const [
        ChartsInfo(),
      ],
    ),
  );
}
