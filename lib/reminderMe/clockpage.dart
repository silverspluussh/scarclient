import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/reminderMe/clock.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<Clock> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {});
    } else {
      return;
    }
  }

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
        child: Alarm(
            size: size,
            timeformat: timeformat,
            dateformat: dateformat,
            offsetsign: offsetsign),
      ),
    );
  }
}
