import 'package:json_annotation/json_annotation.dart';

part 'profilemodel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name;
  String firstname;
  String surname;
  String nationality;
  String contact;
  String dob;

  ProfileModel(
    this.name,
    this.contact,
    this.dob,
    this.firstname,
    this.nationality,
    this.surname,
  );

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
