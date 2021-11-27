import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scarclient/Models/profilemodel.dart';
import 'package:scarclient/screens/dashboard/dashboard.dart';
import 'package:scarclient/services/authen.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  static String? contact;

  static String? dob;

  static String? firstname;

  static String? nationality;

  static String? surname;
  static String? name;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  ProfileModel profile =
      ProfileModel(contact!, dob!, firstname!, nationality!, surname!, name!);
  final networkhandler = NetworkHanler();
  bool progress = true;

  void getdata() async {
    var resp = await networkhandler.get('/profile/profileinfo');
    setState(() {
      profile = ProfileModel.fromJson(resp["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Dashboard(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: networkhandler.getimage(profile.name),
          ),
          const SizedBox(height: 20),
          Form(
            child: Column(
              children: [
                Infoslide(
                  title: 'Firstname',
                  txt: profile.firstname,
                ),
                Infoslide(
                  title: 'Surname',
                  txt: profile.surname,
                ),
                Infoslide(
                  title: 'Nationality',
                  txt: profile.nationality,
                ),
                Infoslide(
                  title: 'Date of Birth',
                  txt: profile.dob,
                ),
                Infoslide(
                  title: 'Contact',
                  txt: profile.contact,
                ),
              ],
            ),
          )
        ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Wrap(children: [
          Text(
            txt,
            style: const TextStyle(fontSize: 18),
          ),
        ]),
      ],
    );
  }
}
