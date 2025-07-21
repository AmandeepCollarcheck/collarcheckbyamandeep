

class CompanyAllEmploymentModel {
  bool? status;
  String? messages;
  List<Datum>? data;
  List<dynamic>? newUpdateList;

  CompanyAllEmploymentModel({
    this.status,
    this.messages,
    this.data,
    this.newUpdateList,
  });

  factory CompanyAllEmploymentModel.fromJson(Map<String, dynamic> json) => CompanyAllEmploymentModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    newUpdateList: json["newUpdateList"] == null ? [] : List<dynamic>.from(json["newUpdateList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "newUpdateList": newUpdateList == null ? [] : List<dynamic>.from(newUpdateList!.map((x) => x)),
  };
}

class Datum {
  String? id;
  String? profile;
  String? userName;
  String? salary;
  String? employmentType;
  String? designation;
  DateTime? joiningDate;
  DateTime? workedTillDate;
  String? stillWorking;
  String? approved;
  List<String>? skill;
  String? description;
  List<String>? document;
  String? salaryInhand;
  String? salaryMode;
  String? department;
  int? claimStatus;
  List<Rating>? rating;
  String? employmentStatus;
  String? employementId;
  String? slug;
  String? individualId;
  String? status;
  bool? isVerified;
  String? userSlug;
  List<dynamic>? updateHistory;

  Datum({
    this.id,
    this.profile,
    this.userName,
    this.salary,
    this.employmentType,
    this.designation,
    this.joiningDate,
    this.workedTillDate,
    this.stillWorking,
    this.approved,
    this.skill,
    this.description,
    this.document,
    this.salaryInhand,
    this.salaryMode,
    this.department,
    this.claimStatus,
    this.rating,
    this.employmentStatus,
    this.employementId,
    this.slug,
    this.individualId,
    this.status,
    this.isVerified,
    this.userSlug,
    this.updateHistory,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    profile: json["profile"],
    userName: json["userName"],
    salary: json["salary"],
    employmentType: json["employment_type"],
    designation: json["designation"],
    joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
    workedTillDate: json["worked_till_date"] == null ? null : DateTime.parse(json["worked_till_date"]),
    stillWorking: json["still_working"],
    approved: json["approved"],
    skill: json["skill"] == null ? [] : List<String>.from(json["skill"]!.map((x) => x)),
    description: json["description"],
    document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
    salaryInhand: json["salary_inhand"],
    salaryMode: json["salary_mode"],
    department: json["department"],
    claimStatus: json["claim_status"],
    rating: json["rating"] == null ? [] : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
    employmentStatus: json["employment_status"],
    employementId: json["employement_id"],
    slug: json["slug"],
    individualId: json["individual_id"],
    status: json["status"],
    isVerified: json["is_verified"],
    userSlug: json["user_slug"],
    updateHistory: json["updateHistory"] == null ? [] : List<dynamic>.from(json["updateHistory"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "userName": userName,
    "salary": salary,
    "employment_type": employmentType,
    "designation": designation,
    "joining_date": "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
    "worked_till_date": "${workedTillDate!.year.toString().padLeft(4, '0')}-${workedTillDate!.month.toString().padLeft(2, '0')}-${workedTillDate!.day.toString().padLeft(2, '0')}",
    "still_working": stillWorking,
    "approved": approved,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
    "description": description,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
    "salary_inhand": salaryInhand,
    "salary_mode": salaryMode,
    "department": department,
    "claim_status": claimStatus,
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x.toJson())),
    "employment_status": employmentStatus,
    "employement_id": employementId,
    "slug": slug,
    "individual_id": individualId,
    "status": status,
    "is_verified": isVerified,
    "user_slug":userSlug,
    "updateHistory": updateHistory == null ? [] : List<dynamic>.from(updateHistory!.map((x) => x)),
  };
}

enum Status {
  COMPLETE,
  PENDING
}

final statusValues = EnumValues({
  "complete": Status.COMPLETE,
  "pending": Status.PENDING
});

enum EmploymentType {
  FREELANCE,
  FULL_TIME,
  INTERNSHIP,
  PART_TIME,
  SELF_EMPLOYED,
  TRAINEE
}

final employmentTypeValues = EnumValues({
  "Freelance": EmploymentType.FREELANCE,
  "Full-time": EmploymentType.FULL_TIME,
  "Internship": EmploymentType.INTERNSHIP,
  "Part-time": EmploymentType.PART_TIME,
  "Self-employed": EmploymentType.SELF_EMPLOYED,
  "Trainee": EmploymentType.TRAINEE
});

enum IndividualId {
  CCC313134,
  CCE001412,
  CCE224401,
  CCE514981
}

final individualIdValues = EnumValues({
  "CCC313134": IndividualId.CCC313134,
  "CCE001412": IndividualId.CCE001412,
  "CCE224401": IndividualId.CCE224401,
  "CCE514981": IndividualId.CCE514981
});

class Rating {
  String? id;
  String? rating;
  String? review;
  String? approved;
  Status? status;
  List<dynamic>? doc;
  DateTime? date;
  String? link;
  List<History>? history;

  Rating({
    this.id,
    this.rating,
    this.review,
    this.approved,
    this.status,
    this.doc,
    this.date,
    this.link,
    this.history,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    rating: json["rating"],
    review: json["review"],
    approved: json["approved"],
    status: statusValues.map[json["status"]]!,
    doc: json["doc"] == null ? [] : List<dynamic>.from(json["doc"]!.map((x) => x)),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    link: json["link"],
    history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "review": review,
    "approved": approved,
    "status": statusValues.reverse[status],
    "doc": doc == null ? [] : List<dynamic>.from(doc!.map((x) => x)),
    "date": date?.toIso8601String(),
    "link": link,
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
  };
}

class History {
  String? id;
  String? ratingId;
  String? rating;
  String? review;
  String? doc;
  String? link;
  String? isDeleted;
  String? status;
  DateTime? createDate;
  DateTime? modifyDate;

  History({
    this.id,
    this.ratingId,
    this.rating,
    this.review,
    this.doc,
    this.link,
    this.isDeleted,
    this.status,
    this.createDate,
    this.modifyDate,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    ratingId: json["rating_id"],
    rating: json["rating"],
    review: json["review"],
    doc: json["doc"],
    link: json["link"],
    isDeleted: json["is_deleted"],
    status: json["status"],
    createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
    modifyDate: json["modify_date"] == null ? null : DateTime.parse(json["modify_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating_id": ratingId,
    "rating": rating,
    "review": review,
    "doc": doc,
    "link": link,
    "is_deleted": isDeleted,
    "status": status,
    "create_date": createDate?.toIso8601String(),
    "modify_date": modifyDate?.toIso8601String(),
  };
}

enum Slug {
  GOURAV_SINGH_CCE001412,
  GREENVAC_SOLUTION_PVT_LTD,
  PAWAN_KUMAR_CCE224401,
  SUDESH_SAINI_CCE514981,
  TECH_FORZA_INFOTECH_TECH_PVT_LTD_CCC313134
}

final slugValues = EnumValues({
  "gourav-singh-cce001412": Slug.GOURAV_SINGH_CCE001412,
  "greenvac-solution-pvt-ltd": Slug.GREENVAC_SOLUTION_PVT_LTD,
  "pawan-kumar-cce224401": Slug.PAWAN_KUMAR_CCE224401,
  "sudesh-saini-cce514981": Slug.SUDESH_SAINI_CCE514981,
  "tech-forza-infotech-tech-pvt-ltd-ccc313134": Slug.TECH_FORZA_INFOTECH_TECH_PVT_LTD_CCC313134
});

enum UserName {
  GOURAV_SINGH,
  GREENVAC_SOLUTION_PVT_LTD,
  PAWAN_KUMAR,
  SUDESH_SAINI,
  TECH_FORZA_INFOTECH_TECH_PVT_LTD
}

final userNameValues = EnumValues({
  "gourav singh": UserName.GOURAV_SINGH,
  "GREENVAC SOLUTION PVT LTD ": UserName.GREENVAC_SOLUTION_PVT_LTD,
  "PAWAN KUMAR": UserName.PAWAN_KUMAR,
  "Sudesh Saini": UserName.SUDESH_SAINI,
  "Tech forza infotech tech pvt ltd ": UserName.TECH_FORZA_INFOTECH_TECH_PVT_LTD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
