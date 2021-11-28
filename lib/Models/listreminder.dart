import 'package:json_annotation/json_annotation.dart';
import 'package:scarclient/Models/remindermodel.dart';

part 'listreminder.g.dart';

@JsonSerializable()
class ListreminderModel {
  List<ReminderModel>? data;

  ListreminderModel({this.data});

  factory ListreminderModel.fromJson(Map<String, dynamic> json) =>
      _$ListreminderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListreminderModelToJson(this);
}
