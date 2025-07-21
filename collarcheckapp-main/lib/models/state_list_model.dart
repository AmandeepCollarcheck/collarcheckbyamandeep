

class StateListModel {
  bool? status;
  String? messages;
  List<StateDatum>? data;

  StateListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory StateListModel.fromJson(Map<String, dynamic> json) => StateListModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<StateDatum>.from(json["data"]!.map((x) => StateDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StateDatum {
  String? id;
  String? name;

  StateDatum({
    this.id,
    this.name,
  });

  factory StateDatum.fromJson(Map<String, dynamic> json) => StateDatum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
