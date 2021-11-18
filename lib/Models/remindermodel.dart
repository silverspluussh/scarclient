import 'package:json_annotation/json_annotation.dart';

part 'remindermodel.g.dart';

@JsonSerializable()
class ReminderModel {
  DateTime reminderTime;
  String description;
  bool isSet;

  ReminderModel(this.description, this.isSet, this.reminderTime);

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);
}
