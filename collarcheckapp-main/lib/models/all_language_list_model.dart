

class AlLanguageListModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  AlLanguageListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory AlLanguageListModel.fromJson(Map<String, dynamic> json) => AlLanguageListModel(
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
  String? user;
  String? language;
  String? verbal;
  String? written;
  String? status;
  String? isDeleted;
  dynamic createDate;
  DateTime? modifyDate;
  String? languageName;

  Datum({
    this.id,
    this.user,
    this.language,
    this.verbal,
    this.written,
    this.status,
    this.isDeleted,
    this.createDate,
    this.modifyDate,
    this.languageName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    user: json["user"],
    language: json["language"],
    verbal: json["verbal"],
    written: json["written"],
    status: json["status"],
    isDeleted: json["is_deleted"],
    createDate: json["create_date"],
    modifyDate: json["modify_date"] == null ? null : DateTime.parse(json["modify_date"]),
    languageName: json["language_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "language": language,
    "verbal": verbal,
    "written": written,
    "status": status,
    "is_deleted": isDeleted,
    "create_date": createDate,
    "modify_date": modifyDate?.toIso8601String(),
    "language_name": languageName,
  };
}
