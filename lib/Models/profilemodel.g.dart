// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      json['name'] as String,
      json['contact'] as String,
      json['dob'] as String,
      json['firstname'] as String,
      json['nationality'] as String,
      json['surname'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'surname': instance.surname,
      'nationality': instance.nationality,
      'contact': instance.contact,
      'dob': instance.dob,
    };
