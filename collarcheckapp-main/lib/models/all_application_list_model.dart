

class AllApplicationListModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  AllApplicationListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory AllApplicationListModel.fromJson(Map<String, dynamic> json) => AllApplicationListModel(
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
  String? job;
  String? userId;
  String? individualId;
  String? fname;
  String? email;
  String? phone;
  dynamic cityName;
  dynamic stateName;
  dynamic countryName;
  String? profile;
  String? slug;
  String? companyName;
  String? designationName;
  bool? isVerified;
  dynamic presentAddress;
  String? profileDescription;
  String? date;
  String? resume;
  dynamic resumeName;
  dynamic expectedSalary;
  dynamic noticePeriod;
  String? onNotice;
  String? onImmediate;
  dynamic noticeDate;
  Rating? rating;

  Datum({
    this.id,
    this.job,
    this.userId,
    this.individualId,
    this.fname,
    this.email,
    this.phone,
    this.cityName,
    this.stateName,
    this.countryName,
    this.profile,
    this.slug,
    this.companyName,
    this.designationName,
    this.presentAddress,
    this.profileDescription,
    this.date,
    this.resume,
    this.resumeName,
    this.expectedSalary,
    this.noticePeriod,
    this.onNotice,
    this.onImmediate,
    this.noticeDate,
    this.isVerified,
    this.rating
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    job: json["job"],
    userId: json["user_id"],
    individualId: json["individual_id"],
    fname: json["fname"],
    email: json["email"],
    phone: json["phone"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    profile: json["profile"],
    slug: json["slug"],
    isVerified: json["isVerified"],
    companyName: json["company_name"],
    designationName: json["designation_name"],
    presentAddress: json["present_address"],
    profileDescription: json["profile_description"],
    date: json["date"],
    resume: json["resume"],
    resumeName: json["resumeName"],
    expectedSalary: json["expected_salary"],
    noticePeriod: json["notice_period"],
    onNotice: json["on_notice"],
    onImmediate: json["on_immediate"],
    noticeDate: json["notice_date"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job": job,
    "user_id": userId,
    "individual_id": individualId,
    "fname": fname,
    "email": email,
    "phone": phone,
    "isVerified":isVerified,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "profile": profile,
    "slug": slug,
    "company_name": companyName,
    "designation_name": designationName,
    "present_address": presentAddress,
    "profile_description": profileDescription,
    "date": date,
    "resume": resume,
    "resumeName": resumeName,
    "expected_salary": expectedSalary,
    "notice_period": noticePeriod,
    "on_notice": onNotice,
    "on_immediate": onImmediate,
    "notice_date": noticeDate,
    "rating": rating?.toJson(),
  };
}

class Rating {
  int? rating;
  int? noofrecord;

  Rating({
    this.rating,
    this.noofrecord,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rating: json["rating"],
    noofrecord: json["noofrecord"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "noofrecord": noofrecord,
  };
}