import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scarclient/reminderMe/matbutton.dart';
import 'package:scarclient/services/authen.dart';

class SetVitals extends StatefulWidget {
  const SetVitals({
    Key? key,
  }) : super(key: key);

  @override
  State<SetVitals> createState() => _SetVitalsState();
}

class _SetVitalsState extends State<SetVitals> {
  @override
  void initState() {
    if (mounted) {
      setState(() {});
    } else {
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    NetworkHanler hanler = NetworkHanler();
    TextEditingController pulserate = TextEditingController();
    TextEditingController temperature = TextEditingController();
    TextEditingController bloodpressure = TextEditingController();
    TextEditingController breathingrate = TextEditingController();

    List<String> items = [
      " A fever is indicated when body temperature rises about one degree or more over the normal temperature of 98.6 degrees Fahrenheit, according to the American Academy of Family Physicians. ",
      "The normal pulse for healthy adults ranges from 60 to 100 beats per minute. The pulse rate may fluctuate and increase with exercise, illness, injury, and emotions. Females ages 12 and older,\n in general, tend to have faster heart rates than do males. ",
      "If your doctor has ordered you to check your own pulse and you are having difficulty finding it, consult your doctor or nurse for additional instruction.",
      "Normal respiration rates for an adult person at rest range from 12 to 16 breaths per minute.",
      "High blood pressure, or hypertension, directly increases the risk of heart attack, heart failure, and stroke. With high blood pressure, the arteries may have an increased resistance against the flow of blood, causing the heart to pump harder to circulate the blood."
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        child: ListView(
          children: [
            const SizedBox(height: 5),
            const Align(
                alignment: Alignment.topLeft, child: Button(label: 'Hint:')),
            const SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 6,
                scrollDirection: Axis.horizontal,
              ),
              items: items.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      elevation: 5,
                      shadowColor: Colors.green,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            i,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 8),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: TextField(
                onChanged: (val) {
                  pulserate.text = val;
                },
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  labelText: 'Pulse rate',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: 'hintText',
                ),
                cursorColor: Colors.green[300],
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: TextField(
                onChanged: (val) {
                  temperature.text = val;
                },
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  labelText: 'Body temperature',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: 'hintText',
                ),
                cursorColor: Colors.green[300],
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: TextField(
                onChanged: (val) {
                  bloodpressure.text = val;
                },
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  labelText: 'Blood pressure',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: 'hintText',
                ),
                cursorColor: Colors.green[300],
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: TextField(
                onChanged: (val) {
                  breathingrate.text = val;
                },
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  labelText: 'Breathing rate',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: 'hintText',
                ),
                cursorColor: Colors.green[300],
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> data = {
                        "pulserate": pulserate.text,
                        "bloodpressure": bloodpressure.text,
                        "bodytemperature": temperature.text,
                        "breathingrate": breathingrate.text,
                      };
                      var output = await hanler.post('/vitals/addvitals', data);

                      Map<String, dynamic> response = json.decode(output.body);
                      await Fluttertoast.showToast(
                        msg: response["msg"],
                        backgroundColor: Colors.green,
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: 23,
                      ).then((value) {
                        pulserate.text = '';
                        bloodpressure.text = '';
                        temperature.text = '';
                        breathingrate.text = '';
                      });
                    }
                  },
                  child: const Button(
                    label: 'Save',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
