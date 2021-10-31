import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerX extends StatelessWidget {
  const DividerX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[400],
    );
  }
}
