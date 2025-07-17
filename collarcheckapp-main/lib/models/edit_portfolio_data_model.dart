

class EditPortfolioDataModel {
  bool? status;
  String? messages;
  Data? data;

  EditPortfolioDataModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EditPortfolioDataModel.fromJson(Map<String, dynamic> json) => EditPortfolioDataModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? type;
  String? title;
  String? image;
  String? description;

  Data({
    this.id,
    this.type,
    this.title,
    this.image,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
