import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/Models/reminderclass.dart';
import 'package:scarclient/services/authen.dart';
import 'package:google_fonts/google_fonts.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<ReminderPage> {
  NetworkHanler networkhandler = NetworkHanler();
  late Future<Remindme> fetchreminders;

  Future<Remindme> fetchAlbum() async {
    var response = await networkhandler.get('/reminders/remindersinfo');
    if (response != null) {
      return Remindme.fromJson(response);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchreminders = fetchAlbum();
    DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 24),
          const Text(
            'Reminders',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 18,
          ),
          FutureBuilder<Remindme>(
            future: fetchreminders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var alarmtime =
                    DateFormat("hh:mm: aa").format(snapshot.data!.dueDate);

                return Padding(
                  padding: const EdgeInsets.all(10),
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
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(5),
              height: 120,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFBCC0B6),
                      Color(0xFFBDBCC2),
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
              child: InkWell(
                onTap: () {},
                child: Expanded(
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
            ),
          ),
        ],
      ),
    );
  }
}
