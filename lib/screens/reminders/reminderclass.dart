class ReminderModel {
  double progress = 0.0;
  String dueDate = "";
  String user = "";

  ReminderModel(
      {required this.dueDate, required this.user, required this.progress});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["progress"] = progress;
    data["user"] = user;
    data["dueDate"] = dueDate;

    return data;
  }

  ReminderModel.fromMap(Map<String, dynamic> map) {
    user = map["user"];
    progress = map["progress"];
    dueDate = map["dueDate"];
  }
}
