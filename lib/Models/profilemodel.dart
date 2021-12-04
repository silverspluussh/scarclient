class ProfileModel {
  String name;
  String firstname;
  String surname;
  String nationality;
  int contact;
  String dob;

  ProfileModel({
    required this.name,
    required this.contact,
    required this.dob,
    required this.firstname,
    required this.nationality,
    required this.surname,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        name: json['name'],
        firstname: json['firstname'],
        surname: json['surname'],
        nationality: json['nationality'],
        contact: json['contact'],
        dob: json['dob']);
  }
}
