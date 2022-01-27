// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/dashboard/profilepic.dart';
import 'package:scarclient/screens/dashboard/welcomeprofile.dart';
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
      verifydrugspage();
      verifypharmacypage();
      verifyvitalspage();

      setState(() {});
    }
  }

  final networkhandler = NetworkHanler();

  var vitals_resp, vitals_req;
  var pharm_req, pharm_resp;
  var drugs_req, drugs_resp;

  Widget page = Center(
      child: Container(
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Image.asset('assets/healthh.png'),
  ));

  Widget vitalspage = const CircularProgressIndicator();
  Widget pharmpage = const CircularProgressIndicator();
  Widget drugspage = const CircularProgressIndicator();

  var user = '';

  Widget pagedata(double height, width) {
    if (vitals_req == true && pharm_req == true && drugs_req == true) {
      setState(() {
        page = Column(
          children: [
            Text(
              'My Health Overview:',
              style: GoogleFonts.nunito(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            Container(
              height: height,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF1E7E7),
                    //  Color(0xFF765FA1),
                    Color(0xFF8BAFA6),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: vitalspage,
            ),
            const SizedBox(height: 20),
            Text(
              'My Pharmacies:',
              style: GoogleFonts.nunito(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            Container(
              height: height,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD6A6B1),
                    //  Color(0xFFA09676),
                    Color(0xFFFCECEC),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: pharmpage,
            ),
            const SizedBox(height: 20),
            Text(
              'My Drugstore:',
              style: GoogleFonts.nunito(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            Container(
                height: height,
                width: width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE0E7B6),
                      //  Color(0xFFECC8D1),
                      Color(0xFFD1D6D5),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: drugspage)
          ],
        );
      });
    }

    return page;
  }

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

  verifydrugspage() async {
    if (drugs_req == true && drugs_resp != null) {
      setState(() {
        drugspage = Card(
          color: Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
          child: ListTile(
            hoverColor: Colors.grey[50],
            leading: Text(
              '${drugs_resp['drugname']}',
              style: GoogleFonts.nunito(fontSize: 17, color: Colors.black),
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${drugs_resp['quantity']}',
                  style: GoogleFonts.nunito(fontSize: 17, color: Colors.black),
                ),
                const ImageIcon(
                  AssetImage('assets/i-pharmacy-256.png'),
                ),
              ],
            ),
          ),
        );
      });
    } else {
      setState(() {
        drugspage = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Drugstore not available'.toUpperCase(),
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Add Drugs'.toUpperCase(),
                style:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      });
    }
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
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          WelcomeProfilePic(user: user),
          const SizedBox(height: 10),
          pagedata(
            size.height / 3.4,
            size.width / 2,
          ),
        ],
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
            height: 80,
            width: 90,
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
