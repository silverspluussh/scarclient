import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/screens/startscreen/navigation_index.dart';
import 'package:scarclient/services/authen.dart';
import 'sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var username = '';
  var email = '';
  var password = '';
  var passConfirm = '';
  var token = '';
  String? errort;
  bool validate = false;
  bool circus = false;

  bool _showPassword = false;

  final _globalkey = GlobalKey<FormState>();
  NetworkHanler networkhandle = NetworkHanler();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.white24,
        ),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Form(
          key: _globalkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Text(
                  "Let's get started ! ",
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  " Please create an account :",
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
                      return "Field cannot be blank";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    username = val;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF260975), width: 0.0),
                    ),
                    hintText: "Username",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: TextFormField(
                  validator: (val) {
                    if (!val!.contains('@')) {
                      return "email is invalid";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    errorText: validate ? null : errort,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF260975), width: 0.0),
                    ),
                    hintText: "Email",
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
                    if (val!.length < 8) {
                      return "password too short(> 8)";
                    }
                  },
                  onChanged: (val) {
                    password = val;
                  },
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
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
                      borderSide:
                          BorderSide(color: Color(0xFF260975), width: 0.0),
                    ),
                    hintText: "Password",
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
                  color: Colors.white,
                ),
                child: TextFormField(
                  validator: (val) {
                    if (val != password) {
                      return "passwords do not match";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    passConfirm = val;
                  },
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    focusColor: const Color(0xFF260975),
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
                      borderSide:
                          BorderSide(color: Color(0xFF260975), width: 0.0),
                    ),
                    hintText: "Confirm Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Wrap(
                  children: [
                    const Text(
                      "By creating this account I have read and accepted the ",
                      style: TextStyle(fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Terms of Service ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const Text(
                      " and  ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Privacy Policy.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.login_sharp),
                  label: circus
                      ? const CircularProgressIndicator(strokeWidth: 2)
                      : Text(
                          "Sign Up",
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: const Color(0xFF684EAF),
                  ),
                  onPressed: () async {
                    setState(() {
                      circus = true;
                    });
                    await verifyEmail();
                    if (_globalkey.currentState!.validate() && validate) {
                      Map<String, String> data = {
                        "name": username,
                        "email": email,
                        "password": password,
                      };
                      await networkhandle.post('/user/register', data);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                          (route) => false);
                    }
                    setState(() {
                      circus = false;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.workSans(
                          color: Colors.black, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignIn(),
                          ),
                        );
                      },
                      child: Text(
                        " Sign In",
                        style: GoogleFonts.workSans(
                          color: Colors.blue,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 140),
              Align(
                alignment: Alignment.bottomCenter,
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
            ],
          ),
        ),
      ),
    );
  }

  verifyEmail() async {
    if (username.isEmpty) {
      setState(() {
        validate = false;
        errort = 'name cannot be empty';
      });
    }
    var response = await networkhandle.get('/user/checkemail/$email');
    if (response['status']) {
      setState(() {
        validate = false;
        errort = 'email is already used';
      });
    } else {
      setState(() {
        validate = true;
      });
    }
  }
}
