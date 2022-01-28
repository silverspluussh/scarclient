// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/Models/profilemodel.dart';
import 'package:scarclient/services/authen.dart';
import 'package:get/get.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  NetworkHanler networkhandler = NetworkHanler();
  bool progress = true;
  var resp;
  var req;

  Widget page = Center(
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile has not been set!',
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: () => Get.toNamed('/completeprofile'),
            icon: const ImageIcon(
              AssetImage('assets/profile-19-512.png'),
            ),
            tooltip: 'Complete Profile',
          )
        ],
      ),
    ),
  );

  @override
  void initState() {
    if (mounted) {
      setState(() {});
      getdata();
    } else {
      return;
    }
    super.initState();
  }

  Future getdata() async {
    resp = await networkhandler.get('/profile/profileinfo');
    req = await networkhandler.get('/profile/checkprofile');
  }

  Widget verifypage() {
    if (resp != null && req == true) {
      setState(() {
        page = Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage(
                'assets/logo.png',
              ),
              radius: MediaQuery.of(context).size.width / 4.5,
              //   networkhandler.getimage(snapshot.data!.name),
            ),
            const SizedBox(height: 20),
            Infoslide(
              title: 'Firstname:',
              txt: resp['firstname'],
            ),
            Infoslide(
              title: 'Surname:',
              txt: resp['surname'],
            ),
            Infoslide(
              title: 'Nationality:',
              txt: resp['nationality'],
            ),
            Infoslide(
              title: 'Date of Birth:',
              txt: resp['dob'],
            ),
            Infoslide(
              title: 'Contact:',
              txt: resp['contact'],
            ),
          ],
        );
      });
    }
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.toNamed("/navpage"),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Get.toNamed("/completeprofile"),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 20),
            page,
          ],
        ),
      ),
    );
  }
}

class Infoslide extends StatelessWidget {
  final String txt;
  final String title;
  const Infoslide({
    required this.title,
    required this.txt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Wrap(children: [
                Text(
                  txt.toUpperCase(),
                  style: const TextStyle(fontSize: 18),
                ),
              ]),
            ],
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }
}
