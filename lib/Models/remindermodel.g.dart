// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remindermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      json['description'] as String,
      json['isSet'] as bool,
      DateTime.parse(json['dueDate'] as String),
      json['drug'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'dueDate': instance.dueDate.toIso8601String(),
      'description': instance.description,
      'isSet': instance.isSet,
      'name': instance.name,
      'drug': instance.drug,
    };
