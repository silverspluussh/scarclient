import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeProfilePic extends StatelessWidget {
  const WelcomeProfilePic({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Align(alignment: Alignment.topLeft, child: WelcomeUser()),
    );
  }
}

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          "How's your health today,\nUser?",
          style: GoogleFonts.firaSansExtraCondensed(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
