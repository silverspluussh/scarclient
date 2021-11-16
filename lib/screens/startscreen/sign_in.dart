import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';
import 'package:scarclient/services/authen.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var password = '';
  var username = '';
  var token = '';
  String? errort;
  bool circus = false;

  bool _showPassword = false;
  final storage = const FlutterSecureStorage();
  final _globalkey = GlobalKey<FormState>();
  NetworkHanler networkhand = NetworkHanler();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _globalkey,
            child: ListView(children: [
              Row(
                children: [
                  Text(
                    "Welcome User! ",
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const ImageIcon(
                    AssetImage('assets/fireworks-display-512.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Please sign in :",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Cannot be blank";
                    }
                  },
                  decoration: InputDecoration(
                    errorText: errort,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.0),
                    ),
                    hintText: "Username",
                  ),
                  onChanged: (val) {
                    username = val;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Cannot be blank";
                    }
                    if (val.length < 8) {
                      return "Password too short";
                    }
                  },
                  obscureText: !_showPassword,
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    errorText: errort,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.0),
                    ),
                    hintText: "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: const Color(0xFF260975)),
                  onPressed: () async {
                    setState(() {
                      circus = true;
                    });
                    if (_globalkey.currentState!.validate()) {
                      Map<String, String> data = {
                        'name': username,
                        'password': password,
                      };
                      var response =
                          await networkhand.post('/user/login', data);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        Map<String, dynamic> outside =
                            json.decode(response.body);
                        await storage.write(
                            key: 'token', value: outside["token"]);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (route) => false);
                      } else {
                        var output = json.decode(response.body);
                        setState(() {
                          errort = output['msg'];
                        });
                      }
                    }
                    setState(() {
                      circus = false;
                    });
                  },
                  child: circus
                      ? const CircularProgressIndicator(strokeWidth: 3)
                      : Text(
                          "Sign In",
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not yet a user? ",
                      style: GoogleFonts.workSans(
                          color: Colors.black, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUp()),
                        );
                      },
                      child: Text(
                        " Sign Up",
                        style: GoogleFonts.workSans(
                          color: Colors.blue,
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height / 3),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Scarpharmacy',
                  style: GoogleFonts.lobster(
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF260975),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
