

class AllLanguageListDataModel {
  bool? status;
  String? messages;
  List<LanguageDatum>? data;

  AllLanguageListDataModel({
    this.status,
    this.messages,
    this.data,
  });

  factory AllLanguageListDataModel.fromJson(Map<String, dynamic> json) => AllLanguageListDataModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<LanguageDatum>.from(json["data"]!.map((x) => LanguageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LanguageDatum {
  String? id;
  String? name;

  LanguageDatum({
    this.id,
    this.name,
  });

  factory LanguageDatum.fromJson(Map<String, dynamic> json) => LanguageDatum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
