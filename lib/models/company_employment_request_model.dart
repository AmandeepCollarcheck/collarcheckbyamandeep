
class CompanyEmploymentRequestModel {
  bool? status;
  String? messages;
  Data? data;

  CompanyEmploymentRequestModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CompanyEmploymentRequestModel.fromJson(Map<String, dynamic> json) => CompanyEmploymentRequestModel(
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
  List<ApprovedListElement>? pendingList;
  List<ApprovedListElement>? approvedList;
  List<ApprovedListElement>? rejectList;
  List<ApprovedListElement>? newUpdateList;
  int? pendingCount;
  int? approvedCount;
  int? rejectCount;
  int? updateList;

  Data({
    this.pendingList,
    this.approvedList,
    this.rejectList,
    this.newUpdateList,
    this.pendingCount,
    this.approvedCount,
    this.rejectCount,
    this.updateList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pendingList: json["pendingList"] == null ? [] : List<ApprovedListElement>.from(json["pendingList"]!.map((x) => ApprovedListElement.fromJson(x))),
    approvedList: json["approvedList"] == null ? [] : List<ApprovedListElement>.from(json["approvedList"]!.map((x) => ApprovedListElement.fromJson(x))),
    rejectList: json["rejectList"] == null ? [] : List<ApprovedListElement>.from(json["rejectList"]!.map((x) => ApprovedListElement.fromJson(x))),
    newUpdateList: json["newUpdateList"] == null ? [] : List<ApprovedListElement>.from(json["newUpdateList"]!.map((x) => ApprovedListElement.fromJson(x))),
    pendingCount: json["pendingCount"],
    approvedCount: json["approvedCount"],
    rejectCount: json["rejectCount"],
    updateList: json["updateList"],
  );

  Map<String, dynamic> toJson() => {
    "pendingList": pendingList == null ? [] : List<dynamic>.from(pendingList!.map((x) => x.toJson())),
    "approvedList": approvedList == null ? [] : List<dynamic>.from(approvedList!.map((x) => x.toJson())),
    "rejectList": rejectList == null ? [] : List<dynamic>.from(rejectList!.map((x) => x.toJson())),
    "newUpdateList": newUpdateList == null ? [] : List<dynamic>.from(newUpdateList!.map((x) => x.toJson())),
    "pendingCount": pendingCount,
    "approvedCount": approvedCount,
    "rejectCount": rejectCount,
    "updateList": updateList,
  };
}

class ApprovedListElement {
  String? id;
  String? profile;
  String? userName;
  String? salary;
  String? employmentType;
  String? designation;
  String? joiningDate;
  String? workedTillDate;
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
  int? lastReview;
  List<dynamic>? updateHistory;

  ApprovedListElement({
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
    this.lastReview,
    this.updateHistory,
  });

  factory ApprovedListElement.fromJson(Map<String, dynamic> json) => ApprovedListElement(
    id: json["id"],
    profile: json["profile"],
    userName: json["userName"],
    salary: json["salary"],
    employmentType: json["employment_type"],
    designation: json["designation"],
    joiningDate: json["joining_date"],
    workedTillDate: json["worked_till_date"],
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
    lastReview: json["lastReview"],
    updateHistory: json["updateHistory"] == null ? [] : List<dynamic>.from(json["updateHistory"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "userName": userName,
    "salary": salary,
    "employment_type": employmentType,
    "designation": designation,
    "joining_date": joiningDate,
    "worked_till_date": workedTillDate,
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
    "user_slug": userSlug,
    "lastReview": lastReview,
    "updateHistory": updateHistory == null ? [] : List<dynamic>.from(updateHistory!.map((x) => x)),
  };
}

class Rating {
  String? id;
  String? rating;
  String? review;
  String? approved;
  String? status;
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
    status: json["status"],
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
    "status": status,
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
