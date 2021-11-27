import 'package:json_annotation/json_annotation.dart';

part 'remindermodel.g.dart';

@JsonSerializable()
class ReminderModel {
  DateTime dueDate;
  String description;
  bool isSet;
  String name;
  String drug;

  ReminderModel(
      this.description, this.isSet, this.dueDate, this.drug, this.name);

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);
}
