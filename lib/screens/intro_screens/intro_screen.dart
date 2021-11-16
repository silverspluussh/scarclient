import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/startscreen/signup.dart';
import '../startscreen/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: [
          pageScreenOne(_height, _width),
          pageScreenTwo(_height, _width),
          pageScreenThree(_height, _width),
          pageScreenFour(_height, _width)
        ],
      ),
    );
  }

  onGetStarted() async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const SignUp()));
  }

  onLogIN() async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const SignIn()));
  }

  GestureDetector pageScreenOne(double _height, double _width) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < 0) {
          setState(() {
            _page = 1;
          });
        }
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: _width / 3.8,
                  child: ElevatedButton(
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: const Color(0xFFB5ADCC),
                    ),
                    onPressed: onLogIN,
                  ),
                ),
              ),
              SizedBox(height: _height / 2.3),
              Wrap(
                children: [
                  Text(
                      'A systematic approach advocated by the World Health Organization can help minimize poor-quality and erroneous prescribing. This six-step approach to prescribing suggests that the physician should (1) evaluate and clearly define the patient\'s problem',
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        fontSize: 23,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 10, 90, 1),
                child: SizedBox(
                  width: _width / 3,
                  child: ElevatedButton(
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: const Color(0xFFB5ADCC),
                    ),
                    onPressed: onGetStarted,
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(
            // color: Color(0xFFA395CC),
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/saved3.jpg'), fit: BoxFit.fill)),
        height: _height,
        width: _width,
      ),
    );
  }

  GestureDetector pageScreenTwo(double _height, double _width) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          setState(() {
            _page = 0;
          });
        }
        if (details.delta.dx < 0) {
          setState(() {
            _page = 2;
          });
        }
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: _width / 4,
                  child: ElevatedButton(
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: const Color(0xFFB5ADCC),
                    ),
                    onPressed: onLogIN,
                  ),
                ),
              ),
              SizedBox(height: _height / 2.5),
              Wrap(
                children: [
                  Text(
                      "(2) specify the therapeutic objective; (3) select the appropriate drug therapy; (4) initiate therapy with appropriate details and consider nonpharmacologic therapies; (5) give information, instructions, and warnings;",
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        fontSize: 23,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 11,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 10, 90, 1),
                child: SizedBox(
                  width: _width / 3,
                  child: ElevatedButton(
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: const Color(0xFFB5ADCC),
                    ),
                    onPressed: onGetStarted,
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(
          // color: Color(0xFFA395CC),
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage('assets/saved3.jpg'), fit: BoxFit.fill),
        ),
        height: _height,
        width: _width,
      ),
    );
  }

  GestureDetector pageScreenThree(double _height, double _width) {
    return GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              _page = 1;
            });
          }
          if (details.delta.dx < 0) {
            setState(() {
              _page = 3;
            });
          }
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: _width / 3.8,
                    child: ElevatedButton(
                      child: Text(
                        "LOGIN",
                        style: GoogleFonts.acme(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: const Color(0xFFB5ADCC),
                      ),
                      onPressed: onLogIN,
                    ),
                  ),
                ),
                SizedBox(height: _height / 2.3),
                Wrap(
                  children: [
                    Text(
                      "(6) evaluate therapy regularly (e.g., monitor treatment results, consider discontinuation of the drug). The authors add two additional steps: (7) consider drug cost when prescribing; and (8) use computers and other tools to reduce prescribing errors.",
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 10, 90, 1),
                  child: SizedBox(
                    width: _width / 3,
                    child: ElevatedButton(
                        child: Text(
                          "Get Started",
                          style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: const Color(0xFFB5ADCC),
                        ),
                        onPressed: onGetStarted),
                  ),
                ),
              ],
            ),
          ),
          decoration: const BoxDecoration(
              //  color: Color(0xFFA395CC),
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage('assets/saved3.jpg'), fit: BoxFit.fill)),
          height: _height,
          width: _width,
        ));
  }

  GestureDetector pageScreenFour(double _height, double _width) {
    return GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              _page = 2;
            });
          }
          if (details.delta.dx < 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const SignIn()));
          }
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: _width / 3.8,
                    child: ElevatedButton(
                      child: Text(
                        "LOGIN",
                        style: GoogleFonts.acme(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: const Color(0xFFB5ADCC),
                      ),
                      onPressed: onLogIN,
                    ),
                  ),
                ),
                SizedBox(height: _height / 2.3),
                Wrap(
                  children: [
                    Text(
                      " These eight steps, along with ongoing self-directed learning, compose a systematic approach to prescribing that is efficient and practical for the family physician. Using prescribing software and having access to electronic drug references on a desktop or handheld computer can also improve the legibility and accuracy of prescriptions and help physicians avoid errors",
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 11,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 10, 90, 1),
                  child: SizedBox(
                    width: _width / 3,
                    child: ElevatedButton(
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.acme(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: const Color(0xFFB5ADCC),
                      ),
                      onPressed: onGetStarted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: const BoxDecoration(
            // color: Color(0xFFA395CC),
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/saved3.jpg'), fit: BoxFit.fill),
          ),
          height: _height,
          width: _width,
        ));
  }
}
