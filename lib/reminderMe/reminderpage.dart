import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/Models/listreminder.dart';
import 'package:scarclient/Models/remindermodel.dart';
import 'package:scarclient/services/authen.dart';
//import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/main.dart';
import 'package:scarclient/reminderMe/clockpage.dart';
import 'package:scarclient/reminderMe/sideicons.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);
  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<ReminderPage> {
  @override
  void initState() {
    DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFB5B8C9),
        ),
        child: Row(
          children: [
            Column(children: [
              SizedBox(height: size.height / 24),
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Home(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 35,
                        ),
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )),
              SizedBox(height: size.height / 15),
              InkWell(
                  child: Sideicons(
                      color: Colors.transparent,
                      data: 'Clock',
                      iconadd: 'assets/clock-120-512.png'),
                  onTap: () async {
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Clock(),
                      ),
                    );
                  }),
              SizedBox(height: size.height / 10),
              Sideicons(
                  color: Colors.grey.withOpacity(0.4),
                  data: 'Reminders',
                  iconadd: 'assets/reminders.png')
            ]),
            const VerticalDivider(color: Colors.white, width: 3),
            const Reminders(),
          ],
        ),
      ),
    );
  }
}

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  List<ListreminderModel>? alarms;
  NetworkHanler networkhandler = NetworkHanler();
  ListreminderModel listreminders = ListreminderModel();

  void getreminders() async {
    var response = await networkhandler.get('url');

    setState(() {
      listreminders = ListreminderModel.fromJson(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.63,
      decoration: const BoxDecoration(color: Color(0xFFB5B8C9)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 14,
          ),
          const Text(
            'Reminders',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  // itemCount: listreminders.data!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      remcard(listreminders.data![index]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: InkWell(
                      onTap: schedulereminder,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_box_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text('Add Reminder')
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Padding remcard(ReminderModel obj) {
    var alarmtime = DateFormat("hh:mm: aa").format(obj.dueDate);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(5),
        height: 120,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7BA051),
                Color(0xFF635497),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 9,
                spreadRadius: 3,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history_toggle_off_sharp),
                Text(
                  'Home',
                  style: GoogleFonts.lato(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: true,
                  onChanged: (bool value) {},
                  activeColor: Colors.white,
                )
              ],
            ),
            Text(
              "Sun - Fri",
              style: GoogleFonts.lato(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              alarmtime,
              style: GoogleFonts.lato(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void schedulereminder() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm notif ',
      'alarm ',
      icon: 'ic_launcher',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iosPlatform = const IOSNotificationDetails(
      sound: 'a_long_cold_sting',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecs = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosPlatform);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Medication time',
        'you need to take your drugs now',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecs,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
