

class EducationListDataModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  EducationListDataModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EducationListDataModel.fromJson(Map<String, dynamic> json) => EducationListDataModel(
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
  String? courseType;
  String? course;
  String? state;
  String? city;
  String? startingDate;
  dynamic endingDate;
  String? country;
  bool? ishighest;
  bool? ongoing;
  List<dynamic>? document;

  Datum({
    this.id,
    this.university,
    this.courseType,
    this.course,
    this.state,
    this.city,
    this.startingDate,
    this.endingDate,
    this.country,
    this.ishighest,
    this.ongoing,
    this.document,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    university: json["university"],
    courseType: json["course_type"],
    course: json["course"],
    state: json["state"],
    city: json["city"],
    startingDate: json["starting_date"],
    endingDate: json["ending_date"],
    country: json["country"],
    ishighest: json["ishighest"],
    ongoing: json["ongoing"],
    document: json["document"] == null ? [] : List<dynamic>.from(json["document"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "university": university,
    "course_type": courseType,
    "course": course,
    "state": state,
    "city": city,
    "starting_date": startingDate,
    "ending_date": endingDate,
    "country": country,
    "ishighest": ishighest,
    "ongoing": ongoing,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
  };
}
