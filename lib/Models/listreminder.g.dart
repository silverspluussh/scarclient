// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listreminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListreminderModel _$ListreminderModelFromJson(Map<String, dynamic> json) =>
    ListreminderModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReminderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListreminderModelToJson(ListreminderModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
