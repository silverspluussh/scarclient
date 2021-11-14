import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scarclient/screens/intro_screens/intro_screen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splash: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Image.asset(
          'assets/logo.png',
        ),
      ),
      nextScreen: const SplashScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      splashIconSize: 100,
      animationDuration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      centered: true,
      duration: 4500,
    );
  }
}
