// ignore_for_file: non_constant_identifier_names

class Pharmacies {
  String? name;
  String? Pharmacy_Name;
  String? Pharm_Telephone;
  String? Pharm_Email;
  String? Pharm_Location;
  String? PharmGpsAddress;
  String? OwnerName;
  String? OwnerTelephone;
  String? OwnerEmail;
  String? StringDate;
  String? CodeNumber;
  Pharmacies(
      {required this.PharmGpsAddress,
      required this.CodeNumber,
      required this.OwnerEmail,
      required this.name,
      required this.OwnerName,
      required this.OwnerTelephone,
      required this.Pharm_Email,
      required this.Pharm_Location,
      required this.Pharm_Telephone,
      required this.Pharmacy_Name,
      required this.StringDate});

  factory Pharmacies.fromJson(Map<String, dynamic> json) {
    return Pharmacies(
      name: json['name'],
      CodeNumber: json['CodeNumber'],
      OwnerEmail: json['OwnerEmail'],
      OwnerName: json['OwnerName'],
      OwnerTelephone: json['OwnerTelephone'],
      PharmGpsAddress: json['PharmGpsAddress'],
      Pharm_Email: json['Pharm_Email'],
      Pharm_Location: json['Pharm_Location'],
      Pharm_Telephone: json['Pharm_Telephone'],
      Pharmacy_Name: json['Pharmacy_Name'],
      StringDate: json['StringDate'],
    );
  }
}
