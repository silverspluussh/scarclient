import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/settings/profilesets.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
              alignment: Alignment.topLeft,
              child: Chip(
                  backgroundColor: Colors.blueAccent,
                  label: Text(
                    'Hint:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  avatar: ImageIcon(AssetImage('assets/messagehint.png'))),
            ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_alt_outlined),
                label: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
