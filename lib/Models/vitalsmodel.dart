class VitalsModel {
  String name;
  String bodytemperature;
  String pulserate;
  String breathingrate;
  String bloodpressure;

  VitalsModel(
      {required this.name,
      required this.bodytemperature,
      required this.pulserate,
      required this.breathingrate,
      required this.bloodpressure});

  factory VitalsModel.fromJson(Map<String, dynamic> json) {
    return VitalsModel(
        name: json['name'],
        bodytemperature: json['bodytemperature'],
        pulserate: json['pulserate'],
        breathingrate: json['breathingrate'],
        bloodpressure: json['bloodpressure']);
  }
}
