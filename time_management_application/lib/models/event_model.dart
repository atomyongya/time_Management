class EventModel {
  String? event;
  String? date;
  String? time;

  EventModel(this.event, this.date, this.time);
  EventModel.fromJson(Map<String, dynamic> json) {
    event = json["event"];
    date = json["date"];
    time = json["time"];
  }
}
