import 'package:flutter/material.dart';
import 'package:scarclient/reminderMe/clockpage.dart';
import 'package:scarclient/reminderMe/reminderpage.dart';
import 'package:scarclient/screens/dashboard/dashed.dart';
import 'package:scarclient/screens/settings/settings.dart';
import 'package:scarclient/screens/vitals/vitals.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    if (mounted) {
      setState(() {});
    } else {
      dispose();
      return;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  final navigationtabs = const [
    Center(child: Dashed()),
    Center(child: ReminderPage()),
    Center(child: Clock()),
    Center(child: Vitals()),
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
                AssetImage('assets/clock-111-128.png'),
                //color: Colors.redAccent,
              ),
              label: 'Reminders',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/clock-137-128.png'),
                //color: Colors.redAccent,
              ),
              label: 'Clock',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/heart-rate-11-128.png'),
                //color: Colors.redAccent,
              ),
              label: 'Vitals',
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
