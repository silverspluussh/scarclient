import 'package:flutter/material.dart';
import 'package:scarclient/screens/dashboard/profilepic.dart';
import 'package:scarclient/screens/dashboard/welcomeprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(color: Colors.white),
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            WelcomeProfilePic(user: user),
            ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 15),
              children: [
                const Text(
                  'My Health Overview:',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 5),
                Container(
                  height: size.height / 4,
                  width: size.width / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        vitalsL(Colors.green.withOpacity(0.3)),
                        vitalsL(Colors.red.withOpacity(0.4)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            vitlasS(
                                Colors.blue.withOpacity(0.3), Colors.blueGrey),
                            vitlasS(Colors.purple.withOpacity(0.1),
                                Colors.pink[50]),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            circularcard(
                                Colors.blue.withOpacity(0.1), Colors.grey[400]),
                            circularcard(Colors.blue.withOpacity(0.1),
                                Colors.orange[100]),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'My Drugs:',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 5),
                Container(
                  height: size.height / 5,
                  width: size.width / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          hoverColor: Colors.grey[50],
                          leading: const Text('Name of drug'),
                          trailing: const ImageIcon(
                            AssetImage('assets/i-pharmacy-256.png'),
                            size: 30,
                          ),
                        ),
                        const Divider(color: Colors.black),
                        ListTile(
                          hoverColor: Colors.grey[50],
                          leading: const Text('Name of drug'),
                          trailing: const ImageIcon(
                            AssetImage('assets/i-pharmacy-256.png'),
                            size: 30,
                          ),
                        ),
                        const Divider(color: Colors.black),
                        ListTile(
                          hoverColor: Colors.grey[50],
                          leading: const Text('Name of drug'),
                          trailing: const ImageIcon(
                            AssetImage('assets/i-pharmacy-256.png'),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'My Pharmacies:',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 5),
                Container(
                  height: size.height / 5,
                  width: size.width / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          pharmacy(),
                          pharmacy(),
                          pharmacy(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card pharmacy() {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: ListTile(
          hoverColor: Colors.grey[50],
          leading: const Text('Name of drug'),
          trailing: const Text('Location')),
    );
  }

  Widget circularcard(Color scolor, color) => Padding(
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
              children: [labels('45'), labels('pulse')],
            ),
          ),
        ),
      );

  Card vitlasS(Color scolor, color) {
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
          children: [labels('Temp.'), labels('35%')],
        ),
      ),
    );
  }

  Text labels(var label) => Text(label);

  Card vitalsL(Color scolor) {
    return Card(
      elevation: 5,
      shadowColor: scolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 60,
        height: 135,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [labels('weight'), labels('85kg')],
        ),
      ),
    );
  }
}
