import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/Models/remindermodel.dart';
import 'package:scarclient/reminderMe/sideicons.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<ReminderPage> {
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
                child: IconButton(
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
              ),
              SizedBox(height: size.height / 15),
              Sideicons(
                  color: Colors.transparent,
                  data: 'Clock',
                  iconadd: 'assets/clock-120-512.png'),
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
  List<ReminderModel> alarms = [
    ReminderModel(
      'afdfdddffsdf',
      true,
      DateTime.now(),
    ),
    ReminderModel(
      'description',
      false,
      DateTime.now(),
    )
  ];
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
            height: MediaQuery.of(context).size.height / 16,
          ),
          Expanded(
            child: ListView(
              children: alarms.map((e) {
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
                          "10:30am",
                          style: GoogleFonts.lato(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).followedBy([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: const [
                          Icon(
                            Icons.add_box,
                            size: 1.5,
                            color: Colors.black,
                          ),
                          Text('Add Eeminder')
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }
}
