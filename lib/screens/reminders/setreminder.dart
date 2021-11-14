import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/settings/profilesets.dart';

class SetReminder extends StatelessWidget {
  const SetReminder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          const CustomTextField(
              hintText: "Name of Drug", labelText: "Name of Drug"),
          const CustomTextField(hintText: "Pharmacy", labelText: "Pharmacy"),
          const CustomTextField(hintText: "Set data", labelText: "Set Data"),
          const CustomTextField(
              hintText: "Description", labelText: "Description"),
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
                  label: Text("Save",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
}
