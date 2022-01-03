class VitalsModel {
  String name;
  String bodytemperature;
  String pulserate;
  String breathingrate;
  String bloodpressure;
  String weight;
  String height;

  VitalsModel(
      {required this.name,
      required this.weight,
      required this.height,
      required this.bodytemperature,
      required this.pulserate,
      required this.breathingrate,
      required this.bloodpressure});

  factory VitalsModel.fromJson(Map<String, dynamic> json) {
    return VitalsModel(
        name: json['name'],
        weight: json['weight'],
        height: json['height'],
        bodytemperature: json['bodytemperature'],
        pulserate: json['pulserate'],
        breathingrate: json['breathingrate'],
        bloodpressure: json['bloodpressure']);
  }
}
