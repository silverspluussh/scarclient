// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/reminderMe/matbutton.dart';
import 'package:scarclient/services/authen.dart';
import 'package:scarclient/reminderMe/reminderhelper.dart';

class SetReminders extends StatefulWidget {
  const SetReminders({Key? key}) : super(key: key);

  @override
  _CompleteProfileStatex createState() => _CompleteProfileStatex();
}

class _CompleteProfileStatex extends State<SetReminders> {
  @override
  void initState() {
    if (mounted) {
      setState(() {});
    } else {
      dispose();
      return;
    }
    super.initState();
  }

  bool valid = false;
  var xtitle, xhour, xminute, xdrug, xday;
  final hanler = NetworkHanler();
  List<int> timeintervals = [1, 2, 3, 4, 5, 6, 7, 0];
  final _formKey = GlobalKey<FormState>();
  var selectedday = 0;
  int keys = 1;

  NetworkHanler handler = NetworkHanler();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _drug = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController minute = TextEditingController();

  bool validate = true;
  Widget progress = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
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
                    const Spacer(),
                    const Button(label: 'Reminders')
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _title,
                  labelText: "Title",
                  hintText: "Title",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Drug",
                  controller: _drug,
                  hintText: "Drug",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "time in hours",
                  controller: hour,
                  hintText: 'input hour of day',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "time in minutes",
                  controller: minute,
                  hintText: 'input minutes of day',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      validate = false;
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> data = {
                          "title": _title.text,
                          "drug": _drug.text,
                          "hour": hour.text,
                          "minute": minute.text,
                        };
                        var output =
                            await hanler.post('/reminders/addreminders', data);

                        setState(() {
                          xhour = int.parse(hour.text);
                          xdrug = _drug.text;
                          xtitle = _title.text;
                          xminute = int.parse(minute.text);
                        });

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

                      await NotificationService()
                          .showNotification(keys, xtitle, xdrug, xhour, xminute)
                          .then((value) {
                        hour.text = '';
                        _drug.text = "";
                        _title.text = "";
                        minute.text = "";
                        validate = true;
                      });

                      keys += 1;

                      Navigator.pop(context);
                    },
                    child: validate ? const Button(label: 'save') : progress,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.suffixicon,
    this.onchange,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixicon;
  final Function? onchange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: Colors.green[300],
        readOnly: suffixicon == null ? false : true,
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          labelStyle: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 18,
          ),
          labelText: labelText,
          suffixIcon: suffixicon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 3.0,
              style: BorderStyle.solid,
            ),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
