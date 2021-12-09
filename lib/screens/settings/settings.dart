import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  logout() async {
    final SharedPreferences sharedPereferences =
        await SharedPreferences.getInstance();

    await sharedPereferences.clear();

    Get.toNamed('/startpage');
  }

  exitapp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                IconButton(
                  onPressed: () => Get.snackbar(
                    "Logout/Exit?",
                    "Select an option:",
                    duration: const Duration(seconds: 4),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    animationDuration: const Duration(milliseconds: 300),
                    borderRadius: 15,
                    margin: const EdgeInsets.all(8.0),
                    snackStyle: SnackStyle.FLOATING,
                    backgroundGradient: const LinearGradient(
                      colors: [
                        Color(0xFF607062),
                        Color(0xFFDBD3D5),
                        Color(0xFF768A86),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    snackPosition: SnackPosition.TOP,
                    colorText: Colors.black,
                    overlayBlur: 4,
                    userInputForm: Form(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: exitapp,
                                  icon: const ImageIcon(
                                    AssetImage('assets/safe-exit-512.png'),
                                  ),
                                  iconSize: 35,
                                ),
                                const Text('Exit App'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: logout,
                                  icon: const ImageIcon(
                                    AssetImage('assets/shutdown-16-512.png'),
                                  ),
                                  iconSize: 35,
                                ),
                                const Text('Logout'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  icon: const ImageIcon(
                    AssetImage('assets/poweroff-3-256.png'),
                  ),
                  iconSize: 50,
                  color: Colors.red,
                ),
                const Text('logout')
              ],
            ),
          ),
          SizedBox(
            height: size.height / 45,
          ),
          Card(
            shadowColor: Colors.green,
            elevation: 6,
            margin: const EdgeInsets.fromLTRB(32, 8, 32, 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                ListTile(
                    leading: const ImageIcon(
                      AssetImage('assets/edit-profile-256.png'),
                    ),
                    title: Text(
                      'Complete Profile',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.green,
                    ),
                    onTap: () => Get.toNamed("/completeprofile")),
                dividerx(),
                ListTile(
                    leading: const ImageIcon(
                      AssetImage('assets/profile-19-512.png'),
                    ),
                    title: Text(
                      'Account Settings',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.green),
                    onTap: () => Get.toNamed("/account")),
                dividerx(),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 25,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: Column(
              children: [
                GestureDetector(
                  child: surplus(
                    'Product Reviews and Referrals',
                  ),
                  onLongPress: null,
                ),
                dividerx(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: surplus(
                    'Terms and Conditions',
                  ),
                ),
                dividerx(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: surplus(
                    'Contact Us',
                  ),
                  onLongPress: null,
                ),
                dividerx(),
                SizedBox(height: size.height / 7),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Scarpharmacy',
                    style: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D0C88),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget dividerx() {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[400],
    );
  }

  Widget surplus(String text) {
    return Text(
      text,
      style: GoogleFonts.nunito(fontSize: 20),
    );
  }
}
