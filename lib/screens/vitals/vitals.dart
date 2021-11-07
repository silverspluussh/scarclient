import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/navigation_index.dart';
import 'package:scarclient/screens/settings/profile.dart';
import 'package:scarclient/screens/vitals/vitalsmodel.dart';

class Reminder extends StatefulWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder>
    with SingleTickerProviderStateMixin {
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

  List vitals = [
    {"user": "Micheal", "dueDate": "10-11-2021", "progress": 0.33},
    {"user": "Wilhelmina", "dueDate": "20-11-2021", "progress": 0.5},
    {"user": "Bismark", "dueDate": "20-11-2021", "progress": 0.9},
    {"user": "Kofi Manu Sefa Yeboah", "dueDate": "20-12-2021", "progress": 0.1}
  ];

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
                MaterialPageRoute(builder: (_) => const Home()),
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
          children: [buildMyReminders(), const SetReminder()],
        ));
  }

  Container buildMyReminders() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: RefreshIndicator(
        onRefresh: onPageRefresh,
        child: ListView.separated(
            itemBuilder: (context, index) {
              VitalsModel vital = VitalsModel.fromMap(vitals[index]);

              return VitalsCard(vitals: vital);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0.1,
              );
            },
            itemCount: vitals.length),
      ),
    );
  }

  Future onPageRefresh() async {}
}

class SetReminder extends StatelessWidget {
  const SetReminder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          const CustomTextField(
              hintText: "Name of Drug", labelText: "Name of Drug"),
          const CustomTextField(hintText: "Pharmacy", labelText: "Pharmacy"),
          const CustomTextField(hintText: "Set data", labelText: "Set Data"),
          const CustomTextField(
              hintText: "Description", labelText: "Description"),
          Container(
              height: 55,
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromWidth(200),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.indigo[300],
                  ),
                  onPressed: () {},
                  label: Text("Save",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
}

class VitalsCard extends StatelessWidget {
  const VitalsCard({
    Key? key,
    required this.vitals,
  }) : super(key: key);

  final VitalsModel vitals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.green,
                        value: vitals.progress,
                      ),
                    ),
                  ),
                  Text(
                    "${vitals.progress * 100} %",
                    style: GoogleFonts.nunito(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Due on ${vitals.dueDate}",
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                  Text(
                    vitals.user,
                    style: GoogleFonts.nunito(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage('assets/delete-94-512.png'),
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage('assets/edit-94-512.png'),
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
