import 'package:flutter/material.dart';
import 'package:scarclient/screens/dashboard/dashboard.dart';
import 'package:scarclient/screens/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final navigationtabs = const [
    Center(child: Dashboard()),
    Center(child: Settings()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          color: Colors.white,
          child: navigationtabs[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          selectedFontSize: 25,
          unselectedFontSize: 15,
          backgroundColor: const Color(0xFFEEF0EB),
          elevation: 5,
          iconSize: 26,
          selectedIconTheme: const IconThemeData(color: Colors.green, size: 40),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/homepage.png'),
                //color: Colors.redAccent,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/settings.png'),
                //color: Colors.redAccent,
              ),
              label: 'Settings',
            ),
          ],
          onTap: (tapIndex) {
            setState(() {
              _currentIndex = tapIndex;
            });
          },
        ));
  }
}
