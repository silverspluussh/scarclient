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

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<ReminderPage> {
  NetworkHanler networkhandler = NetworkHanler();
  late Future<Remindme> fetchreminders;
  DateTime select = DateTime.now();
  Widget status = const CircularProgressIndicator();

  checkreminders() async {
    var response = await networkhandler.get('/reminders/checkreminders');
    if (response['status'] == false) {
      setState(() {
        status = const Text(
          'No reminders found',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      });
    }
  }

  Future<Remindme> fetchAlbum() async {
    var response = await networkhandler.get('/reminders/remindersinfo');
    if (response != null) {
      return Remindme.fromJson(response);
    } else {
      throw Exception(
        'no reminders found',
      );
    }
  }

  @override
  void initState() {
    if (mounted) {
      setState(() {});
      DateTime.now();
      fetchreminders = fetchAlbum();
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
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              height: 155,
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
                        Text(
                          snapshot.data!.title.toUpperCase(),
                          style: GoogleFonts.lato(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: false,
                          onChanged: (bool value) {
                            value = true;
                          },
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.white,
                        )
                      ],
                    ),
                    Wrap(children: [
                      Text(
                        "Set for ${snapshot.data!.hour} hours, ${snapshot.data!.minute} minutes",
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          snapshot.data!.drug.toUpperCase(),
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          color: Colors.red,
                          onPressed: () {},
                          icon: const ImageIcon(
                            AssetImage('assets/delete-94-512.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Center(
            child: Padding(padding: const EdgeInsets.all(10.0), child: status),
          );
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
