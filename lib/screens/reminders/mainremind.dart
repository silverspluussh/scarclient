import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/navigation_index.dart';
import 'package:scarclient/screens/reminders/setreminder.dart';
import 'reminderclass.dart';

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
        'MY REMINDERS',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Tab(
      child: Text(
        'SET REMINDERS',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  late TabController _tabController;

  List reminders = [
    {"user": "Micheal", "dueDate": "10-11-2021", "progress": 0.33},
    {"user": "Wilhelmina", "dueDate": "20-11-2021", "progress": 0.5},
    {"user": "Bismark", "dueDate": "20-11-2021", "progress": 0.9},
    {"user": "Kofi Manu Sefa Yeboah", "dueDate": "20-12-2021", "progress": 0.1}
  ];
  Map<String, dynamic> reminder = {"user": "", "dueDate": "", "progress": 0};

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
              ReminderModel reminder = ReminderModel.fromMap(reminders[index]);

              return MyReminderCard(reminder: reminder);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0.1,
              );
            },
            itemCount: reminders.length),
      ),
    );
  }

  Future onPageRefresh() async {}
}

class MyReminderCard extends StatelessWidget {
  const MyReminderCard({
    Key? key,
    required this.reminder,
  }) : super(key: key);

  final ReminderModel reminder;

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
                        value: reminder.progress,
                      ),
                    ),
                  ),
                  Text(
                    "${reminder.progress * 100} %",
                    style: GoogleFonts.nunito(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Due on ${reminder.dueDate}",
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                  Text(
                    reminder.user,
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
