class Remindme {
  String name;
  String title;
  String drug;
  int hour;
  int minute;
  Remindme(
      {required this.drug,
      required this.title,
      required this.name,
      required this.hour,
      required this.minute});

  factory Remindme.fromJson(Map<String, dynamic> json) {
    return Remindme(
      name: json['name']!,
      drug: json['drug']!,
      title: json['title']!,
      hour: json['hour']!,
      minute: json['minute']!,
    );
  }
}
