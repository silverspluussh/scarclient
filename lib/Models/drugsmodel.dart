// ignore_for_file: non_constant_identifier_names

class Drugs {
  String? name;
  String? drugname;
  String? drugType;
  String? vendorname;
  String? drugRef;
  String? codeNumber;
  String? currentDate;
  String? expiryDate;
  String? quantity;

  Drugs(
      {required this.drugname,
      required this.drugType,
      required this.quantity,
      required this.name,
      required this.codeNumber,
      required this.currentDate,
      required this.expiryDate,
      required this.drugRef,
      required this.vendorname});

  factory Drugs.fromJson(Map<String, dynamic> json) {
    return Drugs(
      name: json['name'],
      drugType: json['drugType'],
      quantity: json['quantity'],
      codeNumber: json['codeNumber'],
      currentDate: json['currentDate'],
      drugname: json['drugname'],
      expiryDate: json['expiryDate'],
      drugRef: json['drugRef'],
      vendorname: json['vendorname'],
    );
  }
}
