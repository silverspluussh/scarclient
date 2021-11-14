// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      json['contact'] as String,
      json['dob'] as String,
      json['firstname'] as String,
      json['nationality'] as String,
      json['surname'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'surname': instance.surname,
      'nationality': instance.nationality,
      'contact': instance.contact,
      'dob': instance.dob,
    };
