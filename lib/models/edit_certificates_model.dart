

class EditCertificateModel {
  bool? status;
  String? messages;
  Data? data;

  EditCertificateModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EditCertificateModel.fromJson(Map<String, dynamic> json) => EditCertificateModel(
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
  String? university;
  String? course;
  String? courseId;
  String? universityId;
  dynamic startDate;
  dynamic endDate;
  dynamic certificateId;
  dynamic url;
  bool? ongoing;
  List<String>? document;

  Data({
    this.id,
    this.university,
    this.course,
    this.startDate,
    this.endDate,
    this.certificateId,
    this.url,
    this.ongoing,
    this.document,
    this.courseId,
    this.universityId
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    university: json["university"],
    course: json["course"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    courseId: json["courseId"],
    universityId: json["universityId"],
    certificateId: json["certificate_id"],
    url: json["url"],
    ongoing: json["ongoing"],
    document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "university": university,
    "course": course,
    "start_date": startDate,
    "end_date": endDate,
    "certificate_id": certificateId,
    "url": url,
    "courseId": courseId,
    "universityId": universityId,
    "ongoing": ongoing,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
  };
}
