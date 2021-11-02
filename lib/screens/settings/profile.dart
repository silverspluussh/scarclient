// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../navigation_index.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final String _nationality = "Ghana";
  String _bloodType = "O";
  String _countryCode = "233";
  DateTime? birthDate;
  final _formKey = GlobalKey<FormState>();
  final _bloodTypes = ["A", "AB", "B", "O"];

  final TextEditingController _username = TextEditingController();
  final TextEditingController _fisrtnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController =
      TextEditingController(text: "");

  @override
  void initState() {
    _nationalityController.text = _nationality;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
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
                  onPressed: () async {
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Home()),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _username,
                labelText: "Firstname",
                hintText: "Firstname",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                controller: _fisrtnameController,
                labelText: "Firstname",
                hintText: "Firstname",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                labelText: "Lastname",
                controller: _lastnameController,
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
                                  _countryCode = country.phoneCode;
                                });
                              });
                        },
                        child: Chip(
                            elevation: 2,
                            backgroundColor: Colors.black26,
                            label: Text(
                              "+ " + _countryCode,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )),
                      )),
                  Expanded(
                    flex: 6,
                    child: CustomTextField(
                      labelText: "Phone",
                      controller: _phoneController,
                      hintText: "Phone",
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                labelText: "Date of Birth",
                controller: _birthDateController,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime.now())
                      .then((date) {
                    _birthDateController.text =
                        DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY)
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
                controller: _nationalityController,
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (country) {
                        setState(() {
                          _nationalityController.text = country.name;
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
                        value: _bloodType,
                        onChanged: (String? newValue) {
                          setState(() {
                            _bloodType = newValue!;
                          });
                        },
                        items: _bloodTypes.map((item) {
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
                child: Container(
                    height: 55,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.done),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.red[300],
                        ),
                        onPressed: () {},
                        label: Text("Update Profile",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)))),
              ),
            ],
          ),
        ),
      ),
    );
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
        _onTap = onTap,
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
  final _onTap;
  final _readOnly;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
      ),
      child: TextFormField(
        onTap: _onTap,
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
          // prefix: _prefix,
          suffixIcon: _suffixIcon,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                color: Colors.grey, width: 1.0, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                color: Colors.green, width: 2.0, style: BorderStyle.solid),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                color: Colors.black, width: 5.0, style: BorderStyle.solid),
          ),
          hintText: _hintText,
        ),
      ),
    );
  }
}
