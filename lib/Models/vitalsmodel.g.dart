// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitalsmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalsModel _$VitalsModelFromJson(Map<String, dynamic> json) => VitalsModel(
      json['name'] as String,
      json['bodytemperature'] as String,
      json['pulserate'] as String,
      json['bloodpressure'] as String,
      json['breathingrate'] as String,
    );

Map<String, dynamic> _$VitalsModelToJson(VitalsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bodytemperature': instance.bodytemperature,
      'pulserate': instance.pulserate,
      'breathingrate': instance.breathingrate,
      'bloodpressure': instance.bloodpressure,
    };
