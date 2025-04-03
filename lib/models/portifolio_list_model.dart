

class PortfolioListModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  PortfolioListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory PortfolioListModel.fromJson(Map<String, dynamic> json) => PortfolioListModel(
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
  String? type;
  String? title;
  String? image;
  String? description;

  Datum({
    this.id,
    this.type,
    this.title,
    this.image,
    this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "image": image,
    "description": description,
  };
}
