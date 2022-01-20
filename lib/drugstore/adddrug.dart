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

class Drugs extends StatefulWidget {
  const Drugs({Key? key}) : super(key: key);

  @override
  _Drugstate createState() => _Drugstate();
}

class _Drugstate extends State<Drugs> {
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
  final _formKey1 = GlobalKey<FormState>();

  NetworkHanler handler = NetworkHanler();
  final TextEditingController drugname = TextEditingController();
  final TextEditingController drugType = TextEditingController();
  final TextEditingController vendorname = TextEditingController();
  final TextEditingController drugRef = TextEditingController();
  final TextEditingController codeNumber = TextEditingController();
  final TextEditingController currentDate = TextEditingController();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController quantity = TextEditingController();

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
            key: _formKey1,
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
                    const Button(label: 'Drugstore')
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: drugname,
                  labelText: "Name of drug",
                  hintText: "Drug name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Drug Type",
                  controller: drugType,
                  hintText: "Type of drug",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Name of vendor",
                  controller: vendorname,
                  hintText: 'name of seller',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  labelText: "Drug reference",
                  controller: drugRef,
                  hintText: 'Drug reference',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  hintText: 'code number',
                  labelText: 'Code number',
                  controller: codeNumber,
                ),
                CustomTextField(
                  hintText: "current date",
                  labelText: "current date",
                  controller: currentDate,
                ),
                CustomTextField(
                  hintText: 'Date of expiry',
                  labelText: 'Expiry date',
                  controller: expiryDate,
                ),
                CustomTextField(
                  hintText: 'Quantity',
                  labelText: 'Quantity',
                  controller: quantity,
                ),
                const SizedBox(height: 40),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        onTap: () async {
                          if (_formKey1.currentState!.validate()) {
                            Map<String, String> data = {
                              "Pharmacy_Name": drugname.text,
                              "Pharm_Telephone": drugRef.text,
                              "Pharm_Email": drugType.text,
                              "Pharm_Location": vendorname.text,
                              "PharmGpsAddress": currentDate.text,
                              "OwnerName": expiryDate.text,
                              "OwnerTelephone": quantity.text,
                              "OwnerEmail": codeNumber.text,
                            };
                            var output =
                                await hanler.post('/drugs/adddrugs', data);

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
