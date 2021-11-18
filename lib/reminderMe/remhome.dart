import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/reminderMe/clock.dart';
import 'package:scarclient/reminderMe/reminderpage.dart';
import 'package:scarclient/reminderMe/sideicons.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var time = DateTime.now();
    var timeformat = DateFormat('HH:mm').format(time);
    var dateformat = DateFormat('EEE, d MMM').format(time);
    var timeZone = time.timeZoneOffset.toString().split('.').first;
    var offsetsign = '';
    if (!timeZone.startsWith('-')) offsetsign = '+';

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
                ),
              ),
              SizedBox(height: size.height / 15),
              Sideicons(
                  color: Colors.grey.withOpacity(0.4),
                  data: 'Clock',
                  iconadd: 'assets/clock-120-512.png'),
              SizedBox(height: size.height / 10),
              InkWell(
                child: Sideicons(
                    color: Colors.transparent,
                    data: 'Reminders',
                    iconadd: 'assets/reminders.png'),
                onTap: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReminderPage(),
                    ),
                  );
                },
              )
            ]),
            const VerticalDivider(color: Colors.white, width: 3),
            Alarm(
                size: size,
                timeformat: timeformat,
                dateformat: dateformat,
                offsetsign: offsetsign),
          ],
        ),
      ),
    );
  }
}
