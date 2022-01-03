class Remindme {
  String name;
  String title;
  String drug;
  String hour;
  String minute;
  String day;
  Remindme(
      {required this.drug,
      required this.day,
      required this.title,
      required this.name,
      required this.hour,
      required this.minute});

  factory Remindme.fromJson(Map<String, dynamic> json) {
    return Remindme(
      name: json['name'],
      drug: json['drug'],
      day: json['day'],
      title: json['title'],
      hour: json['hour'],
      minute: json['minute'],
    );
  }
}
