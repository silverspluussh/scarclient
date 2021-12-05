import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/dashboard/profilepic.dart';
import 'dart:async';
import 'package:scarclient/screens/dashboard/welcomeprofile.dart';
import 'package:scarclient/screens/settings/pfpage.dart';
import 'package:scarclient/services/authen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Dashboard> {
  final PageController _slideShowPageController = PageController();

  int _index = 0;
  var user = '';
  NetworkHanler networkhand = NetworkHanler();

  @override
  void initState() {
    if (mounted) {
      setState(() {});
    } else {
      dispose();
      return;
    }
    super.initState();

    //_changeSlideStack();
    getuser();
    _changeSlidePage();
    _index = 0;
  }

  // ignore: unused_element
  void _changeSlideStack() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          if (_index >= 3) {
            _index = 0;
          } else {
            _index += 1;
          }
        });
        debugPrint("Timer " + timer.tick.toString());
      } else {
        timer.cancel();
      }
    });
  }

  void _changeSlidePage() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          if (_index >= 3) {
            _index = 0;
          } else {
            _index += 1;
          }
        });

        if (_slideShowPageController.hasClients) {
          _slideShowPageController.animateToPage(
            _index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
          );
        }

        debugPrint("Timer " + timer.tick.toString());
      } else {
        timer.cancel();
      }
    });
  }

  Future getuser() async {
    var response = await networkhand.get('/user/name');
    setState(() {
      user = response['name'];
    });
  }

  // ignore: annotate_overrides
  void dispose() {
    _slideShowPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF0EB),
        title: InkWell(
            onTap: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const Profilepage(),
                ),
              );
            },
            child: ProfilePicture(width: _width)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              WelcomeProfilePic(user: user),
              SlideImagesCard(
                width: _width,
                index: _index,
                height: _height,
                slideShowPageController: _slideShowPageController,
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}

class VitalsCard extends StatelessWidget {
  const VitalsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      shadowColor: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: const EdgeInsets.all(1),
        child: Center(
            child: Text("Vitals",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold))),
        height: MediaQuery.of(context).size.height / 7,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class RemindersCard extends StatelessWidget {
  const RemindersCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      shadowColor: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: const EdgeInsets.all(1),
        child: Center(
          child: Text(
            "Reminders",
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        height: MediaQuery.of(context).size.height / 7,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class SlideImagesCard extends StatelessWidget {
  const SlideImagesCard(
      {Key? key,
      required double width,
      required int index,
      required double height,
      required PageController slideShowPageController})
      : _width = width,
        _index = index,
        _height = height,
        _slideShowPageController = slideShowPageController,
        super(key: key);

  final double _width;
  final int _index;
  final double _height;
  final PageController _slideShowPageController;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      elevation: 1,
      shadowColor: Colors.green,
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Container(
        width: _width,
        child: Stack(
          children: [
            PageView(
              controller: _slideShowPageController,
              onPageChanged: (index) {
                _slideShowPageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInCubic,
                );
              },
              children: [
                SlideImage(height: _height, imagePath: "assets/vd.jpg"),
                SlideImage(height: _height, imagePath: "assets/cd.png"),
                SlideImage(height: _height, imagePath: "assets/kk.jpg"),
                SlideImage(height: _height, imagePath: "assets/drug.jpg"),
              ],
            ),
            Positioned(
              bottom: 25,
              left: _width / 3.0,
              child: SlideIndicators(width: _width, index: _index),
            )
          ],
        ),
        height: _height / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
      ),
    );
  }
}

class SlideImagesStack extends StatelessWidget {
  const SlideImagesStack({
    Key? key,
    required int index,
    required double height,
  })  : _index = index,
        _height = height,
        super(key: key);

  final int _index;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: [
        SlideImage(height: _height, imagePath: "assets/vd.jpg"),
        SlideImage(height: _height, imagePath: "assets/cd.png"),
        SlideImage(height: _height, imagePath: "assets/kk.jpg"),
        SlideImage(height: _height, imagePath: "assets/drug.jpg"),
      ],
    );
  }
}

class SlideImage extends StatelessWidget {
  const SlideImage({Key? key, required double height, required imagePath})
      : _height = height,
        _imagePath = imagePath,
        super(key: key);

  final double _height;
  final String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          image: DecorationImage(
            image: AssetImage(_imagePath),
            fit: BoxFit.fill,
          ),
          color: Colors.white),
    );
  }
}

class SlideIndicators extends StatelessWidget {
  const SlideIndicators({
    Key? key,
    required double width,
    required int index,
  })  : _width = width,
        _index = index,
        super(key: key);

  final double _width;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: _width / 3.6,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _index == 0 ? const Color(0xFF260975) : Colors.white),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _index == 1 ? const Color(0xFF46269E) : Colors.white),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _index == 2 ? const Color(0xFF341C75) : Colors.white),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _index == 3 ? const Color(0xFF310E8F) : Colors.white),
          )
        ],
      ),
    );
  }
}
