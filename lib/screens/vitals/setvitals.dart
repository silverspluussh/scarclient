import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/settings/profilesets.dart';

class SetVitals extends StatelessWidget {
  const SetVitals({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController pulserate = TextEditingController();
    TextEditingController temperature = TextEditingController();
    TextEditingController bloodpressure = TextEditingController();
    TextEditingController breathingrate = TextEditingController();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          CustomTextField(
            hintText: "Pulse Rate",
            labelText: "Pulse rate",
            controller: pulserate,
          ),
          CustomTextField(
            hintText: "Body Temperature",
            labelText: "Body temperature",
            controller: temperature,
          ),
          CustomTextField(
            hintText: "Blood pressure",
            labelText: "Blood pressure",
            controller: bloodpressure,
          ),
          CustomTextField(
            hintText: "Breathing rate",
            labelText: "Breathing rate",
            controller: breathingrate,
          ),
          Container(
            height: 55,
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromWidth(200),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                primary: Colors.indigo[300],
              ),
              onPressed: () {},
              label: Text(
                "Save",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
