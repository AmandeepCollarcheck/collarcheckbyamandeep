

class CityListModel {
  bool? status;
  String? messages;
  List<CityDatum>? data;

  CityListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<CityDatum>.from(json["data"]!.map((x) => CityDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CityDatum {
  String? id;
  String? name;

  CityDatum({
    this.id,
    this.name,
  });

  factory CityDatum.fromJson(Map<String, dynamic> json) => CityDatum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
