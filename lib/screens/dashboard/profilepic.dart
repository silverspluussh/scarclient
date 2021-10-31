import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CircleAvatar(
        backgroundImage: const AssetImage('assets/logo.png'),
        backgroundColor: Colors.white10,
        maxRadius: _width / 20,
      ),
    );
  }
}
