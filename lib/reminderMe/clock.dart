import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/reminderMe/clockdesign.dart';

class Alarm extends StatelessWidget {
  const Alarm({
    Key? key,
    required this.size,
    required this.timeformat,
    required this.dateformat,
    required this.offsetsign,
  }) : super(key: key);

  final Size size;
  final String timeformat;
  final String dateformat;
  final String offsetsign;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(9),
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: size.height / 24),
          Text(
            'Clock',
            style: GoogleFonts.lato(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height / 25),
          Text(
            timeformat,
            style: GoogleFonts.nunito(
              fontSize: 30,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            dateformat,
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 60),
          const RemindView(),
          Text(
            'Timezone:',
            style: GoogleFonts.nunito(
              fontSize: 23,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '  WAT' + offsetsign,
            style: GoogleFonts.nunito(
              fontSize: 23,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
