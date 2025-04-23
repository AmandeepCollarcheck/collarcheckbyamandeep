
class CompanyBenefitListModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  CompanyBenefitListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CompanyBenefitListModel.fromJson(Map<String, dynamic> json) => CompanyBenefitListModel(
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
  String? name;
  dynamic benefitDescription;
  String? image;

  Datum({
    this.id,
    this.name,
    this.benefitDescription,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    benefitDescription: json["benefit_description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "benefit_description": benefitDescription,
    "image": image,
  };
}
