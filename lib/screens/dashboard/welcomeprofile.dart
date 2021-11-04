import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeProfilePic extends StatelessWidget {
  const WelcomeProfilePic({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          children: [
            Text(
              "How's your health today,\n$user?",
              style: GoogleFonts.firaSansExtraCondensed(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
