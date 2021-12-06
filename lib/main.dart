import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scarclient/screens/intro_screens/splashdart.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';
import 'package:scarclient/screens/startscreen/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  final SharedPreferences sharedPereferences =
      await SharedPreferences.getInstance();
  int? opened = sharedPereferences.getInt('opened');
  String? login = sharedPereferences.getString('success');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.purple),
    ),
    home: opened == null
        ? const Splash()
        : opened != null && login == 'True'
            ? const Home()
            : const SignIn(),
  ));
}
