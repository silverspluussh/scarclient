// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scarclient/reminderMe/matbutton.dart';
import 'package:scarclient/services/authen.dart';

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

  var _endtime = "10:30 AM";
  String _starttime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  DateTime? birthDate = DateTime.now();
  List<int> timeintervals = [5, 10, 15, 20, 30];
  final _formKey = GlobalKey<FormState>();
  int selectedinterval = 5;
  NetworkHanler handler = NetworkHanler();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _interval = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _startime = TextEditingController();
  final TextEditingController _endtme = TextEditingController();

  bool validate = false;
  bool progress = false;
  Widget page = const CircularProgressIndicator();

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
                  controller: _firstname,
                  labelText: "Title",
                  hintText: "Title",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                    labelText: "Add side note",
                    controller: _surname,
                    hintText: "Add side note",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next),
                CustomTextField(
                  labelText: "Date of Birth",
                  controller: _dob,
                  hintText: DateFormat.yMd().format(birthDate!),
                  textInputAction: TextInputAction.next,
                  suffixicon: IconButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime.now())
                          .then((date) {
                        _dob.text =
                            DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY)
                                .format(date!);
                        setState(() {
                          birthDate = date;
                        });
                      });
                    },
                    icon: const Icon(Icons.calendar_today),
                    color: Colors.black26,
                  ),
                ),
                CustomTextField(
                  labelText: "Start time",
                  controller: _startime,
                  hintText: _starttime,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  suffixicon: IconButton(
                    onPressed: () {
                      getusertime(isStarting: true);
                    },
                    icon: const Icon(Icons.timelapse_outlined),
                  ),
                ),
                CustomTextField(
                  labelText: "End time",
                  controller: _endtme,
                  hintText: _endtime,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  suffixicon: IconButton(
                    onPressed: () {
                      getusertime(isStarting: false);
                    },
                    icon: const Icon(Icons.timelapse_outlined),
                  ),
                ),
                CustomTextField(
                  hintText: '$selectedinterval',
                  suffixicon: DropdownButton(
                      elevation: 3,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Colors.green),
                      iconSize: 30,
                      underline: Container(height: 0),
                      onChanged: (String? interval) {
                        setState(() {
                          selectedinterval = int.parse(interval!);
                          _interval.text = selectedinterval.toString();
                        });
                      },
                      items:
                          timeintervals.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()));
                      }).toList()),
                  labelText: 'Remind me',
                ),
                const SizedBox(height: 40),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        onTap: () {}, child: const Button(label: 'save'))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getusertime({required bool isStarting}) async {
    var picked = await showtimepicked();
    String formattime = picked.format(context);
    if (picked == null) {
      return 'time didn\'t select';
    } else if (isStarting == true) {
      setState(() {
        _starttime = formattime;
        _startime.text = _starttime;
      });
    } else if (isStarting == false) {
      setState(() {
        _endtime = formattime;
        _endtme.text = _endtime;
      });
    }
  }

  showtimepicked() {
    var _selected = showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return _selected;
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
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixicon;

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
