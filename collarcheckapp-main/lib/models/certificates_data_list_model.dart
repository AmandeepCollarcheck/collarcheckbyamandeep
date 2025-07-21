
class CertificateListDataModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  CertificateListDataModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CertificateListDataModel.fromJson(Map<String, dynamic> json) => CertificateListDataModel(
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
  String? university;
  String? course;
  dynamic startDate;
  dynamic endDate;
  dynamic certificateId;
  dynamic url;
  bool? ongoing;
  List<dynamic>? document;

  Datum({
    this.id,
    this.university,
    this.course,
    this.startDate,
    this.endDate,
    this.certificateId,
    this.url,
    this.ongoing,
    this.document,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    university: json["university"],
    course: json["course"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    certificateId: json["certificate_id"],
    url: json["url"],
    ongoing: json["ongoing"],
    document: json["document"] == null ? [] : List<dynamic>.from(json["document"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "university": university,
    "course": course,
    "start_date": startDate,
    "end_date": endDate,
    "certificate_id": certificateId,
    "url": url,
    "ongoing": ongoing,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
  };
}
