

class CountryListModel {
  bool? status;
  String? messages;
  List<CountryDatum>? data;

  CountryListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<CountryDatum>.from(json["data"]!.map((x) => CountryDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CountryDatum {
  String? id;
  String? name;
  String? phonecode;

  CountryDatum({
    this.id,
    this.name,
    this.phonecode,
  });

  factory CountryDatum.fromJson(Map<String, dynamic> json) => CountryDatum(
    id: json["id"],
    name: json["name"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phonecode": phonecode,
  };
}
