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
      width: MediaQuery.of(context).size.width / 1.6,
      padding: const EdgeInsets.all(9),
      color: const Color(0xFFC9CCDF),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: size.height / 24),
          Padding(
            padding: const EdgeInsets.only(right: 130),
            child: Text(
              'Clock:',
              style: GoogleFonts.lato(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: size.height / 15),
          Padding(
            padding: const EdgeInsets.only(right: 130),
            child: Text(
              timeformat,
              style: GoogleFonts.nunito(
                fontSize: 35,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: Text(
              dateformat,
              style: GoogleFonts.nunito(
                fontSize: 26,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: RemindView(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: Text(
              'Timezone:',
              style: GoogleFonts.nunito(
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.location_history),
              Text(
                '  WAT' + offsetsign,
                style: GoogleFonts.nunito(
                  fontSize: 26,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
