// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remindermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      json['description'] as String,
      json['isSet'] as bool,
      DateTime.parse(json['reminderTime'] as String),
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'reminderTime': instance.reminderTime.toIso8601String(),
      'description': instance.description,
      'isSet': instance.isSet,
    };
