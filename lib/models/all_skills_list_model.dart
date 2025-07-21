
class AllSkillsListModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  AllSkillsListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory AllSkillsListModel.fromJson(Map<String, dynamic> json) => AllSkillsListModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? skill;
  String? rating;

  Datum({
    this.id,
    this.skill,
    this.rating,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    skill: json["skill"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "skill": skill,
    "rating": rating,
  };
}
