// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/services/authen.dart';
import 'package:get/get.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  void initState() {
    if (mounted) {
      _nationalityx.text = nationality;
      verifyProfile();
    } else {
      dispose();
      return;
    }
    super.initState();
  }

  final String nationality = "Ghana";
  String bloodType = "O";
  String countryCode = "233";
  DateTime? birthDate;
  final _formKey = GlobalKey<FormState>();

  final bloodTypes = ["A", "AB", "B", "O"];

  NetworkHanler handler = NetworkHanler();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _nationalityx = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _dob = TextEditingController(text: "");
  bool validate = false;
  bool progress = false;
  Widget page = const CircularProgressIndicator();
  PickedFile? _filepicker;
  final ImagePicker _picker = ImagePicker();

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          'Select Profile Image:',
          style: GoogleFonts.lato(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                takeImage(ImageSource.camera);
              },
              icon: const Icon(
                Icons.camera,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                takeImage(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.image,
                size: 20,
              ),
            )
          ],
        )
      ]),
    );
  }

  void takeImage(ImageSource src) async {
    // ignore: deprecated_member_use
    final pickedd = await _picker.getImage(
      source: src,
    );
    setState(() {
      _filepicker = pickedd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(child: page));
  }

  verifyProfile() async {
    var response = await handler.get('/profile/checkprofile');
    if (response['status'] == true) {
      setState(() {
        validate = true;
        page = Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Get.toNamed("/navpage"),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: _filepicker == null
                            ? const AssetImage('assets/logo.png')
                            : AssetImage('${File(_filepicker!.path)}'),
                        backgroundColor: Colors.white10,
                      ),
                      Positioned(
                        child: InkWell(
                          onTap: bottomsheet,
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.lightBlue,
                            size: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _firstname,
                  labelText: "Firstname",
                  hintText: "Firstname",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Surname",
                  controller: _surname,
                  hintText: "Lastname",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              showPhoneCode: true,
                              context: context,
                              onSelect: (country) {
                                setState(() {
                                  countryCode = country.phoneCode;
                                });
                              });
                        },
                        child: Chip(
                          elevation: 2,
                          backgroundColor: Colors.black26,
                          label: Text(
                            "+ " + countryCode,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: CustomTextField(
                        labelText: "Phone",
                        controller: _contact,
                        hintText: "Phone",
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  labelText: "Date of Birth",
                  controller: _dob,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now())
                        .then((date) {
                      _dob.text = DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY)
                          .format(date!);
                      setState(() {
                        birthDate = date;
                      });
                    });
                  },
                  readOnly: true,
                  hintText: "Date of birth",
                  textInputAction: TextInputAction.next,
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.black26,
                  ),
                ),
                CustomTextField(
                  labelText: "Country of origin",
                  controller: _nationalityx,
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        onSelect: (country) {
                          setState(() {
                            _nationalityx.text = country.name;
                          });
                        });
                  },
                  readOnly: true,
                  hintText: "Country Of Origin",
                  textInputAction: TextInputAction.next,
                  suffixIcon: const Icon(
                    Icons.flag,
                    color: Colors.black26,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Blood Type : ",
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal)),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                          value: bloodType,
                          onChanged: (String? newValue) {
                            setState(() {
                              bloodType = newValue!;
                            });
                          },
                          items: bloodTypes.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }).toList()),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          progress = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          Map<String, String> data = {
                            "firstname": _firstname.text,
                            "surname": _surname.text,
                            "nationality": _nationalityx.text,
                            "contact": _contact.text,
                            "DOB": _dob.text,
                          };
                          var output =
                              await handler.post('/profile/addprofile', data);
                          if (output.statusCode == 200 ||
                              output.statusCode == 201) {
                            if (_filepicker!.path.isNotEmpty) {
                              var imageresp = await handler.imagepatch(
                                  '/profile/addprofile/image',
                                  _filepicker!.path);
                              if (imageresp.statusCode == 200 ||
                                  imageresp.statusCode == 201) {
                                setState(() {
                                  progress = false;
                                });
                              }
                            }
                            Map<String, dynamic> response =
                                json.decode(output.body);
                            await Fluttertoast.showToast(
                              msg: response["msg"],
                              backgroundColor: Colors.green,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 23,
                            );
                          }
                        }
                        setState(() {
                          progress = false;
                        });
                        Get.toNamed("/profile");
                      },
                      icon: const Icon(Icons.save_alt_outlined),
                      label: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    } else {
      setState(() {
        validate = false;
        page = Card(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 2.5),
              const Text('Profile not set'),
              TextButton.icon(
                onPressed: () => Get.toNamed('/completeprofile'),
                icon: const ImageIcon(AssetImage('assets/profile-19-512.png')),
                label: const Text(
                  'Set Profile',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    TextEditingController? controller,
    required String hintText,
    required String labelText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool readOnly = false,
    Widget? suffixIcon,
    Widget? prefix,
    var onTap,
  })  : _controller = controller,
        _labelText = labelText,
        _hintText = hintText,
        _keyboardType = keyboardType,
        _suffixIcon = suffixIcon,
        _prefix = prefix,
        _readOnly = readOnly,
        _textInputAction = textInputAction,
        super(key: key);

  final _controller;
  final String _hintText;
  final String _labelText;
  final _keyboardType;
  final _textInputAction;
  final Widget? _suffixIcon;
  final Widget? _prefix;
  final _readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
      ),
      child: TextFormField(
        textInputAction: _textInputAction,
        keyboardType: _keyboardType,
        controller: _controller,
        cursorColor: Colors.green[300],
        readOnly: _readOnly,
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          prefix: _prefix,
          labelStyle: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 18,
          ),
          labelText: _labelText,
          suffixIcon: _suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 5.0,
              style: BorderStyle.solid,
            ),
          ),
          hintText: _hintText,
        ),
      ),
    );
  }
}
