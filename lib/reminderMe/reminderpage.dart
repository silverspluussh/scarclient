import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/Models/reminderclass.dart';
import 'package:scarclient/reminderMe/matbutton.dart';
import 'package:scarclient/services/authen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<ReminderPage> {
  NetworkHanler networkhandler = NetworkHanler();
  late Future<Remindme> fetchreminders;
  DateTime select = DateTime.now();

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
    if (mounted) {
      setState(() {});
      fetchreminders = fetchAlbum();
      DateTime.now();
    } else {
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            _addreminderbar(),
            _datepickerbar(),
            _futurereminderlist(),
            _addreminders()
          ],
        ),
      ),
    );
  }

  InkWell _addreminders() {
    return InkWell(
      onTap: () => Get.toNamed("/addreminders"),
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
    );
  }

  Container _datepickerbar() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        selectionColor: Colors.red.withOpacity(0.5),
        initialSelectedDate: DateTime.now(),
        onDateChange: (datechanges) {
          select = datechanges;
        },
      ),
    );
  }

  FutureBuilder<Remindme> _futurereminderlist() {
    return FutureBuilder<Remindme>(
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
              height: 140,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Row _addreminderbar() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(
                DateTime.now(),
              ),
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text('Today', style: GoogleFonts.lato(fontSize: 20))
          ],
        ),
        const Spacer(),
        const Button(label: 'Add task')
      ],
    );
  }
}
