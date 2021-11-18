import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';

import 'clock.dart';

class Remind extends StatefulWidget {
  const Remind({Key? key}) : super(key: key);

  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<Remind> {
  @override
  Widget build(BuildContext context) {
    Widget page =
        const CircularProgressIndicator(color: Colors.white, strokeWidth: 4);
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
          color: Color(0xFF3D4263),
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
              Sideicons(data: 'data', function: () {}, iconadd: 'iconadd'),
              SizedBox(height: size.height / 10),
              Sideicons(data: 'data', function: () {}, iconadd: '')
            ]),
            const VerticalDivider(color: Colors.white, width: 3),
            page,
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

class Sideicons extends StatelessWidget {
  String data;
  String iconadd;
  Function function;
  Sideicons({
    required this.data,
    required this.function,
    required this.iconadd,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      color: data == "Reminder" ? Colors.grey[50] : Colors.transparent,
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: function(),
        child: Column(
          children: [
            ImageIcon(
              AssetImage(iconadd),
              size: 70,
              color: Colors.black,
            ),
            const SizedBox(height: 15),
            Text(
              data,
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
