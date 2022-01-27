// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/dashboard/profilepic.dart';
import 'package:scarclient/services/authen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashy extends StatefulWidget {
  const Dashy({Key? key}) : super(key: key);

  @override
  _DashyState createState() => _DashyState();
}

class _DashyState extends State<Dashy> {
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      dispose();
    } else {
      vitalsdata();
      pharmacydata();
      drugsdata();
      getuser();
      setState(() {});
    }
  }

  final networkhandler = NetworkHanler();

  var vitals_resp, vitals_req;
  var pharm_req, pharm_resp;
  var drugs_req, drugs_resp;

  late Widget page;
  late Widget vitalspage = const CircularProgressIndicator();
  late Widget pharmpage = const CircularProgressIndicator();
  late Widget drugspage = const CircularProgressIndicator();

  var user = '';

  vitalsdata() async {
    vitals_resp = await networkhandler.get('/vitals/vitalsinfo');
    vitals_req = await networkhandler.get('/vitals/checkvitals');
  }

  pharmacydata() async {
    pharm_resp = await networkhandler.get('/pharmacy/pharmdetails');
    pharm_req = await networkhandler.get('/pharmacy/checkpharmacy');
  }

  drugsdata() async {
    drugs_resp = await networkhandler.get('/drugs/drugsdetails');
    drugs_req = await networkhandler.get('/drugs/checkdrugs');
  }

  getuser() async {
    final SharedPreferences sharedPereferences =
        await SharedPreferences.getInstance();

    var _user = sharedPereferences.getString('name');
    setState(() {
      if (_user != null) {
        user = _user;
      } else {
        user = 'user001';
      }
    });
  }

  verifypharmacypage() async {
    if (pharm_resp != null && pharm_req == true) {
      setState(() {
        pharmpage =
            pharmacy(pharm_resp['Pharmacy_Name'], pharm_resp['Pharm_Location']);
      });
    } else {
      setState(() {
        pharmpage = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pharmacies not available'.toUpperCase(),
                style:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Add pharmacies'.toUpperCase(),
                style:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      });
    }
  }

  verifyvitalspage() async {
    if (vitals_req == true && vitals_resp != null) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            vitalsL(vitals_resp['pulserate'], 'Pulse',
                Colors.green.withOpacity(0.3)),
            vitalsL(vitals_resp['breathingrate'], 'B-rate',
                Colors.red.withOpacity(0.4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                vitlasS(vitals_resp['weight'], 'Weight',
                    Colors.blue.withOpacity(0.3), Colors.blueGrey),
                vitlasS(vitals_resp['bodytemperature'], 'Temp.',
                    Colors.purple.withOpacity(0.1), Colors.pink[50]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                circularcard(vitals_resp['height'], 'height',
                    Colors.blue.withOpacity(0.1), Colors.grey[400]),
                circularcard(vitals_resp['bloodpressure'], 'pressure',
                    Colors.blue.withOpacity(0.1), Colors.orange[100]),
              ],
            )
          ],
        ),
      );
    } else {
      setState(() {
        vitalspage = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vitals not available'.toUpperCase(),
                style:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Swipe left to add vitals'.toUpperCase(),
                style:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        elevation: 0,
        leading: const Text(''),
        backgroundColor: const Color(0xFFEEF0EB),
        title: InkWell(
          onTap: () => Get.toNamed("/profile"),
          child: ProfilePicture(width: size.width),
        ),
      ),
    );
  }

  Widget circularcard(var value, var label, Color scolor, color) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Card(
          color: color,
          elevation: 10,
          shadowColor: scolor,
          shape: const CircleBorder(),
          child: SizedBox(
            height: 65,
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$value%',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$label',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Card vitlasS(var value, var label, Color scolor, color) {
    return Card(
      elevation: 4,
      shadowColor: scolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      child: SizedBox(
        width: 60,
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value%',
              style: GoogleFonts.nunito(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              '$label',
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card vitalsL(var value, var label, Color scolor) {
    return Card(
      elevation: 5,
      shadowColor: scolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 60,
        height: 135,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value%',
              style: GoogleFonts.nunito(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              '$label',
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pharmacy(String? pharmacy, String? location) {
    return ListTile(
        hoverColor: Colors.grey[50],
        leading: Text(
          pharmacy!,
          style: GoogleFonts.nunito(fontSize: 17, color: Colors.black),
        ),
        trailing: Text(
          location!,
          style: GoogleFonts.nunito(fontSize: 17, color: Colors.black),
        ));
  }
}
