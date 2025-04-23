

class CompanyAllReviewModel {
  bool? status;
  String? messages;
  List<Datum>? data;

  CompanyAllReviewModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CompanyAllReviewModel.fromJson(Map<String, dynamic> json) => CompanyAllReviewModel(
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
  String? userId;
  String? user;
  String? designation;
  String? profile;
  int? rating;
  bool? isVerified;
  int? noofrecord;
  int? pendingReview;

  Datum({
    this.id,
    this.userId,
    this.user,
    this.profile,
    this.rating,
    this.noofrecord,
    this.designation,
    this.pendingReview,
    this.isVerified
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    user: json["user"],
    designation: json['designation'],
    profile: json["profile"],
    isVerified: json['isVerified'],
    rating: json["rating"],
    noofrecord: json["noofrecord"],
    pendingReview: json["pendingReview"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user": user,
    "designation":designation,
    "profile": profile,
    "rating": rating,
    "isVerified":isVerified,
    "noofrecord": noofrecord,
    "pendingReview": pendingReview,
  };
}
