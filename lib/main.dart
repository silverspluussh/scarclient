import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scarclient/screens/intro%20screens/splashdart.dart';
import 'package:scarclient/screens/settings/account.dart';
import 'package:scarclient/screens/settings/language.dart';
import 'package:scarclient/screens/settings/profile.dart';
import 'package:scarclient/screens/vitals/vitals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

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
        '/vitals': (context) => const Vitals(),
        '/language': (context) => const Language(),
        '/account': (context) => const Account(),
      },
    );
  }
}
