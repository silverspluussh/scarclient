import 'dart:math';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {});
    } else {
      dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return Container(
            width: size.width - 20,
            height: size.height - 20,
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const SweepGradient(
                            colors: [Colors.blue, Colors.transparent],
                            startAngle: 0.0,
                            endAngle: pi * 2,
                            stops: [0.1, 0.1],
                            center: Alignment.center)
                        .createShader(rect);
                  },
                  child: Container(
                    width: size.width - 20,
                    height: size.height - 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: Image.asset('assets/pngwing.png').image,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width - 40,
                    height: size.height - 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
