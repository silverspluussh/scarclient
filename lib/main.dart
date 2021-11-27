import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scarclient/screens/intro_screens/splashdart.dart';
import 'package:scarclient/screens/settings/account.dart';
import 'package:scarclient/screens/settings/language.dart';
import 'package:scarclient/screens/settings/profilesets.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  var initializationSettinsAndroid =
      const AndroidInitializationSettings('ic_launcher');

  var initializationSettinsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});

  var initializationSettings = InitializationSettings(
      android: initializationSettinsAndroid, iOS: initializationSettinsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload!.isNotEmpty) {
      debugPrint('notification payload:' + payload);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.purple),
      ),
      home: const Splash(),
      routes: {
        '/profile': (context) => const CompleteProfile(),
        '/language': (context) => const Language(),
        '/account': (context) => const Account(),
      },
      // darkTheme: ThemeData.dark(),
    );
  }
}
