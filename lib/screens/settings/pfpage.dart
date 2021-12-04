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
  NetworkHanler networkhandler = NetworkHanler();
  bool progress = true;
  late Future<ProfileModel> fetchprofile;

  Future<ProfileModel> getdata() async {
    var resp = await networkhandler.get('/profile/profileinfo');

    if (resp != null) {
      return ProfileModel.fromJson(resp);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchprofile = getdata();
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
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<ProfileModel>(
                future: fetchprofile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/logo.png')
                            // networkhandler.getimage(snapshot.data!.name),
                            ),
                        const SizedBox(height: 20),
                        Infoslide(
                          title: 'Firstname',
                          txt: snapshot.data!.firstname,
                        ),
                        Infoslide(
                          title: 'Surname',
                          txt: snapshot.data!.surname,
                        ),
                        Infoslide(
                          title: 'Nationality',
                          txt: snapshot.data!.nationality,
                        ),
                        Infoslide(
                          title: 'Date of Birth',
                          txt: snapshot.data!.dob,
                        ),
                        Infoslide(
                          title: 'Contact',
                          txt: '${snapshot.data!.contact}',
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                })
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
        const Spacer(),
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
