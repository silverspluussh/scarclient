import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Sideicons extends StatelessWidget {
  String data;
  String iconadd;
  Color color;
  Sideicons(
      {Key? key,
      required this.data,
      required this.iconadd,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      color: color,
      // ignore: deprecated_member_use
      child: Column(
        children: [
          Image.asset(
            iconadd,

            // color: Colors.transparent,
          ),
          const SizedBox(height: 10),
          Text(
            data,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
