import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scarclient/drugstore/adddrug.dart';
import 'package:scarclient/pharmacies/addpharmacy.dart';
import 'package:scarclient/reminderMe/addreminder.dart';
import 'package:scarclient/screens/intro_screens/intro_screen.dart';
import 'package:scarclient/screens/settings/pfpage.dart';
import 'package:scarclient/screens/settings/profilesets.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';
import 'package:scarclient/screens/startscreen/sign_in.dart';
import 'package:scarclient/screens/startscreen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scarclient/reminderMe/reminderhelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final SharedPreferences sharedPereferences =
      await SharedPreferences.getInstance();
  int? opened = sharedPereferences.getInt('opened');
  bool? login = sharedPereferences.getBool('success');

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.purple),
      ),
      initialRoute: "/",
      defaultTransition: Transition.rightToLeft,
      getPages: [
        GetPage(
          name: "/",
          page: () => opened == null
              ? const SplashScreen()
              : opened == 1 && login == true
                  ? const Home()
                  : const SignIn(),
        ),
        GetPage(name: "/login", page: () => const SignIn()),
        GetPage(name: "/signup", page: () => const SignUp()),
        GetPage(name: "/navpage", page: () => const Home()),
        GetPage(name: "/profile", page: () => const Profilepage()),
        GetPage(name: "/completeprofile", page: () => const CompleteProfile()),
        GetPage(name: "/addreminders", page: () => const SetReminders()),
        GetPage(name: "/pharmacy", page: () => const Pharmacy()),
        GetPage(name: "/drugstore", page: () => const Drugs())
      ],
    ),
  );
}
