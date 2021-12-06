import 'package:flutter/material.dart';
import 'package:scarclient/screens/dashboard/profilepic.dart';
import 'package:scarclient/screens/dashboard/welcomeprofile.dart';
import 'package:scarclient/screens/settings/pfpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashed extends StatefulWidget {
  const Dashed({Key? key}) : super(key: key);

  @override
  _DashedState createState() => _DashedState();
}

class _DashedState extends State<Dashed> {
  String user = '';
  // NetworkHanler networkhand = NetworkHanler();

  @override
  void initState() {
    if (mounted) {
      setState(() {});
    } else {
      dispose();
      return;
    }
    super.initState();
    getuser();
  }

  Future getuser() async {
    final SharedPreferences sharedPereferences =
        await SharedPreferences.getInstance();

    var _user = sharedPereferences.getString('name');
    //  var response = await networkhand.get('/user/name');
    setState(() {
      if (_user!.isNotEmpty) {
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
        backgroundColor: const Color(0xFFEEF0EB),
        title: InkWell(
            onTap: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const Profilepage(),
                ),
              );
            },
            child: ProfilePicture(width: size.width)),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              height: size.height / 10,
              child: WelcomeProfilePic(user: user),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE0E7D8),
                        Color(0xFF765FA1),
                        Color(0xFF8BAFA6),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      vitalsL(Colors.red.withOpacity(0.1)),
                      vitalsL(Colors.red.withOpacity(0.1)),
                      Column(
                        children: [
                          vitlasS(Colors.red.withOpacity(0.1)),
                          vitlasS(Colors.red.withOpacity(0.1)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Card vitlasS(Color scolor) {
    return Card(
      elevation: 3,
      shadowColor: scolor,
      color: scolor,
      child: Column(
        children: [labels('')],
      ),
    );
  }

  Text labels(var label) => Text(label);

  Card vitalsL(Color scolor) {
    return Card(
      elevation: 3,
      shadowColor: scolor,
      color: scolor,
      child: Column(
        children: [labels('')],
      ),
    );
  }
}
