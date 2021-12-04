class Remindme {
  late DateTime dueDate;
  String name;
  String description;
  String drug;
  Remindme(
      {required this.drug,
      required this.dueDate,
      required this.name,
      required this.description});

  factory Remindme.fromJson(Map<String, dynamic> json) {
    return Remindme(
        name: json['name'],
        drug: json['drug'],
        dueDate: DateTime.parse(json['dueDate'] as String),
        description: json['description']);
  }
}
