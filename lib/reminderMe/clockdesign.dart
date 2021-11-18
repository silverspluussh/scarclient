import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RemindView extends StatefulWidget {
  const RemindView({Key? key}) : super(key: key);

  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<RemindView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.1,
      height: MediaQuery.of(context).size.height / 3.1,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ReminderPainter(),
        ),
      ),
    );
  }
}

class ReminderPainter extends CustomPainter {
  var datetime = DateTime.now();
  @override
  void paint(Canvas canvas, Size size) {
    var midx = 125.0;
    var midy = 125.0;
    var center = Offset(midy, midy);
    var rad = min(midx, midy);

    var filebrush = Paint()..color = const Color(0xff444974);

    var filebrush1 = Paint()
      ..color = const Color(0xFFBABEDB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    var filebrush2 = Paint()..color = const Color(0xFFBABEDB);

    var filebrush3 = Paint()..color = const Color(0xFFCA5734);

    var secondhand = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.red, Colors.white],
      ).createShader(
        Rect.fromCircle(center: center, radius: rad),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var hourhand = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.green, Colors.black],
      ).createShader(
        Rect.fromCircle(center: center, radius: rad),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7;

    var minutehand = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.lightBlue, Colors.pink],
      ).createShader(
        Rect.fromCircle(center: center, radius: rad),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    canvas.drawCircle(center, rad - 30, filebrush);
    canvas.drawCircle(center, rad - 30, filebrush1);

    var minHandx = midx + 80 * cos(datetime.minute * 6 * pi / 180);
    var minHandy = midx + 80 * sin(datetime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandx, minHandy), minutehand);

    var sechandx = midx + 80 * cos(datetime.second * 6 * pi / 180);
    var sechandy = midx + 80 * sin(datetime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(sechandx, sechandy), secondhand);

    var hrhandx = midx +
        80 * cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var hrhandy = midx +
        80 * sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hrhandx, hrhandy), hourhand);
    canvas.drawCircle(center, 14, filebrush2);

    var outerCircle = rad - 5;
    var innerCircle = rad - 12;
    for (double i = 0; i < 360; i++) {
      var xi = midx + outerCircle * cos(i * pi / 180);
      var yi = midx + outerCircle * sin(i * pi / 180);

      var xii = midx + innerCircle * cos(i * pi / 180);
      var yii = midx + innerCircle * sin(i * pi / 180);
      canvas.drawLine(Offset(xi, yi), Offset(xii, yii), filebrush3);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
