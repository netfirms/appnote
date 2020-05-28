class NoteModel {
  String id;
  String title;
  String message;
  int timestamp;
  int lastUpdate;
  bool isDone;

  NoteModel(
      {this.id,
      this.title,
      this.message,
      this.timestamp,
      this.lastUpdate,
      this.isDone = false});

  NoteModel.fromJson(Map<dynamic, dynamic> json) {
    id = json["\$id"];
    title = json['title'];
    message = json['message'];
    timestamp = json['timestamp'];
    lastUpdate = json['lastUpdate'];
    isDone = json['isDone'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data["\$id"] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['lastUpdate'] = this.lastUpdate;
    data['isDone'] = this.isDone;
    return data;
  }
}
