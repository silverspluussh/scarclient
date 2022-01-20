// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scarclient/reminderMe/matbutton.dart';
import 'package:scarclient/services/authen.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
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

  final hanler = NetworkHanler();
  final _formKey = GlobalKey<FormState>();

  NetworkHanler handler = NetworkHanler();
  final TextEditingController Pharmacy_Name = TextEditingController();
  final TextEditingController Pharm_Telephone = TextEditingController();
  final TextEditingController Pharm_Email = TextEditingController();
  final TextEditingController Pharm_Location = TextEditingController();
  final TextEditingController PharmGpsAddress = TextEditingController();
  final TextEditingController OwnerName = TextEditingController();
  final TextEditingController OwnerTelephone = TextEditingController();
  final TextEditingController OwnerEmail = TextEditingController();
  final TextEditingController StringDate = TextEditingController();
  final TextEditingController CodeNumber = TextEditingController();

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
                    const Button(label: 'Pharmacy')
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: Pharmacy_Name,
                  labelText: "Pharmacy name",
                  hintText: "Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Contact",
                  controller: Pharm_Telephone,
                  hintText: "Contact",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Email",
                  controller: Pharm_Email,
                  hintText: 'email',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Location",
                  controller: Pharm_Location,
                  hintText: 'location',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  hintText: '',
                  labelText: 'Work Address',
                  controller: PharmGpsAddress,
                ),
                CustomTextField(
                  hintText: "Owner's name",
                  labelText: "Owner's name",
                  controller: OwnerName,
                ),
                CustomTextField(
                  hintText: 'Telephone',
                  labelText: 'Telephone',
                  controller: OwnerTelephone,
                ),
                CustomTextField(
                  hintText: 'email',
                  labelText: 'email',
                  controller: OwnerEmail,
                ),
                CustomTextField(
                  hintText: '${DateTime.now()}',
                  labelText: 'Date',
                  controller: StringDate,
                ),
                CustomTextField(
                  hintText: 'Codenumber',
                  labelText: 'Codenumber',
                  controller: CodeNumber,
                ),
                const SizedBox(height: 40),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, String> data = {
                              "Pharmacy_Name": Pharmacy_Name.text,
                              "Pharm_Telephone": Pharm_Telephone.text,
                              "Pharm_Email": Pharm_Email.text,
                              "Pharm_Location": Pharm_Location.text,
                              "PharmGpsAddress": PharmGpsAddress.text,
                              "OwnerName": OwnerName.text,
                              "OwnerTelephone": OwnerTelephone.text,
                              "OwnerEmail": OwnerEmail.text,
                              "StringDate": StringDate.text,
                              "CodeNumber": CodeNumber.text,
                            };
                            var output = await hanler.post(
                                '/reminders/addreminders', data);

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

                          Navigator.pop(context);
                        },
                        child: const Button(label: 'save'))),
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
