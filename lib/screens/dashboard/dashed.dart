import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/dashboard/profilepic.dart';
import 'package:scarclient/screens/dashboard/welcomeprofile.dart';
import 'package:scarclient/services/authen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Dashed extends StatefulWidget {
  const Dashed({Key? key}) : super(key: key);

  @override
  _DashedState createState() => _DashedState();
}

class _DashedState extends State<Dashed> {
  String user = '';
  String bodytemp = '';
  String pulser = '';
  String weight = '';
  String breatherate = '';
  String height = '';
  String pressure = '';
  bool confirmed = false;
  NetworkHanler networkhand = NetworkHanler();

  @override
  void initState() {
    getdata();
    if (mounted) {
      getdata();
      getuser();
      setState(() {});
    } else {
      dispose();
      return;
    }
    super.initState();
  }

  Future getdata() async {
    var resp = await networkhand.get('/vitals/vitalsinfo');

    if (resp != null) {
      setState(() {
        pulser = resp['pulserate'];
        bodytemp = resp['bodytemperature'];
        pressure = resp['bloodpressure'];
        breatherate = resp['breathingrate'];
      });
    }
  }

  void verifyvitals() async {
    var response = await networkhand.get('/vitals/checkvitals');

    if (response['status'] == false) {
      setState(() {
        confirmed = false;
      });
    }
  }

  Future getuser() async {
    final SharedPreferences sharedPereferences =
        await SharedPreferences.getInstance();

    var _user = sharedPereferences.getString('name');
    //  var response = await networkhand.get('/user/name');
    setState(() {
      if (_user != null) {
        user = _user;
      } else {
        user = 'user001';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
            child: ProfilePicture(width: size.width)),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          WelcomeProfilePic(user: user),
          const SizedBox(height: 10),
          Text(
            'My Health Overview:',
            style: GoogleFonts.nunito(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Container(
            height: size.height / 3.37,
            width: size.width / 2,
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
            child: confirmed
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        vitalsL(pulser, 'Pulse', Colors.green.withOpacity(0.3)),
                        vitalsL(
                            breatherate, 'B-rate', Colors.red.withOpacity(0.4)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            vitlasS(weight, 'Weight',
                                Colors.blue.withOpacity(0.3), Colors.blueGrey),
                            vitlasS(
                                bodytemp,
                                'Temp.',
                                Colors.purple.withOpacity(0.1),
                                Colors.pink[50]),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            circularcard(height, 'height',
                                Colors.blue.withOpacity(0.1), Colors.grey[400]),
                            circularcard(
                                height,
                                'height',
                                Colors.blue.withOpacity(0.1),
                                Colors.orange[100]),
                          ],
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      'Vitals not set',
                      style: GoogleFonts.lato(fontSize: 20),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Text(
            'My Drugs:',
            style: GoogleFonts.nunito(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Container(
            height: size.height / 4.6,
            width: size.width / 2,
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
            child: Center(
                child: InkWell(
              onTap: () => Get.toNamed('/drugstore'),
              child: Text(
                'Add Drugs',
                style: GoogleFonts.lato(fontSize: 20),
              ),
            )),
          ),
          const SizedBox(height: 20),
          Text(
            'My Pharmacies:',
            style: GoogleFonts.nunito(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Container(
            height: size.height / 3.6,
            width: size.width / 2,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
            child: Center(
              child: InkWell(
                onTap: () => Get.toNamed('/pharmacy'),
                child: Text(
                  'Add pharmacy',
                  style: GoogleFonts.lato(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card pharmacy(var pharmacy, location) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 5,
      child: ListTile(
          hoverColor: Colors.grey[50],
          leading: Text(
            pharmacy,
            style: GoogleFonts.nunito(fontSize: 17, color: Colors.black),
          ),
          trailing: Text(
            location,
            style: GoogleFonts.nunito(fontSize: 17, color: Colors.black),
          )),
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
}
