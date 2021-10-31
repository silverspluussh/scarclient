import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/settings/sections.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: size.height / 9,
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
                  onTap: () async => Navigator.pushNamed(context, '/profile'),
                ),
                const DividerX(),
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
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.green),
                  onTap: () => Navigator.pushNamed(context, '/account'),
                ),
                const DividerX(),
                ListTile(
                  leading: const ImageIcon(
                    AssetImage('assets/language-6-256.png'),
                  ),
                  title: Text(
                    'Application Settings',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.green),
                  onTap: () => Navigator.pushNamed(context, '/language'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 8,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: Column(
              children: [
                GestureDetector(
                  child: const Surplus(
                    text: 'Product Reviews and Referrals',
                  ),
                  onLongPress: null,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const Surplus(
                    text: 'Terms and Conditions',
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const Surplus(
                    text: 'Contact Us',
                  ),
                  onLongPress: null,
                ),
                const Divider(),
                SizedBox(height: size.height / 12),
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
}

class Surplus extends StatelessWidget {
  const Surplus({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(fontSize: 20),
    );
  }
}
