import 'package:json_annotation/json_annotation.dart';

part 'vitalsmodel.g.dart';

@JsonSerializable()
class VitalsModel {
  String name;
  String bodytemperature;
  String pulserate;
  String breathingrate;
  String bloodpressure;

  VitalsModel(
    this.name,
    this.bodytemperature,
    this.pulserate,
    this.bloodpressure,
    this.breathingrate,
  );

  factory VitalsModel.fromJson(Map<String, dynamic> json) =>
      _$VitalsModelFromJson(json);
  Map<String, dynamic> toJson() => _$VitalsModelToJson(this);
}
