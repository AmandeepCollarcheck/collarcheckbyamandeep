class GetSpecificReviewModel {
  bool? status;
  String? messages;
  Datum? data;

  GetSpecificReviewModel({
    this.status,
    this.messages,
    this.data,
  });

  factory GetSpecificReviewModel.fromJson(Map<String, dynamic> json) => GetSpecificReviewModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? null : Datum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data?.toJson(),
  };
}

class Datum {
  String? id;
  String? user;
  String? profile;
  String? rating;
  String? review;
  bool? isVerified;
  String? designation;
  String? approved;
  String? status;
  List<dynamic>? doc;
  int? edits;
  DateTime? lastEdit;
  DateTime? hoursLeft;
  String? link;
  List<History>? history;
  String? experienceId;
  String? stillWorking;

  Datum({
    this.id,
    this.user,
    this.profile,
    this.rating,
    this.review,
    this.designation,
    this.approved,
    this.status,
    this.doc,
    this.edits,
    this.lastEdit,
    this.hoursLeft,
    this.link,
    this.history,
    this.experienceId,
    this.stillWorking,
    this.isVerified
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    user: json["user"],
    profile: json["profile"],
    rating: json["rating"],
    review: json["review"],
    isVerified: json['isVerified'],
    designation: json["designation"],
    approved: json["approved"],
    status: json["status"],
    doc: json["doc"] == null ? [] : List<dynamic>.from(json["doc"]!.map((x) => x)),
    edits: json["edits"],
    lastEdit: json["last_edit"] == null ? null : DateTime.parse(json["last_edit"]),
    hoursLeft: json["hours_left"] == null ? null : DateTime.parse(json["hours_left"]),
    link: json["link"],
    history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
    experienceId: json["experience_id"],
    stillWorking: json["still_working"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "profile": profile,
    "rating": rating,
    "review": review,
    "designation": designation,
    "approved": approved,
    'isVerified':isVerified,
    "status": status,
    "doc": doc == null ? [] : List<dynamic>.from(doc!.map((x) => x)),
    "edits": edits,
    "last_edit": lastEdit?.toIso8601String(),
    "hours_left": hoursLeft?.toIso8601String(),
    "link": link,
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
    "experience_id": experienceId,
    "still_working": stillWorking,
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
