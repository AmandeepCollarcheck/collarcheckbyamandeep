

class EmployeeListModel {
  bool? status;
  String? messages;
  Data? data;

  EmployeeListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
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
  int? currentCount;
  List<Current>? current;
  int? pastCount;
  List<Past>? past;

  Data({
    this.currentCount,
    this.current,
    this.pastCount,
    this.past,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentCount: json["current_count"],
    current: json["current"] == null ? [] : List<Current>.from(json["current"]!.map((x) => Current.fromJson(x))),
    pastCount: json["past_count"],
    past: json["past"] == null ? [] : List<Past>.from(json["past"]!.map((x) => Past.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_count": currentCount,
    "current": current == null ? [] : List<dynamic>.from(current!.map((x) => x.toJson())),
    "past_count": pastCount,
    "past": past == null ? [] : List<dynamic>.from(past!.map((x) => x.toJson())),
  };
}
class Current {
  String? user;
  String? profile;
  String? username;
  String? designation;
  String? employeeStatus;
  String? connectiondate;
  String? approved;
  String? experienceId;
  dynamic linkdin;
  dynamic youtube;
  dynamic instagram;
  dynamic facebook;
  String? individualId;
  bool? isVerified;
  String? slug;
  String? contactPerson;
  dynamic profileDescription;
  dynamic dob;
  dynamic presentAddress;
  String? joiningDate;
  String? lastModifyDate;
  String? accountCreateDate;
  bool? inWishlist;
  TotalRating? totalRating;

  Current({
    this.user,
    this.profile,
    this.username,
    this.designation,
    this.employeeStatus,
    this.connectiondate,
    this.approved,
    this.experienceId,
    this.linkdin,
    this.youtube,
    this.instagram,
    this.facebook,
    this.individualId,
    this.isVerified,
    this.slug,
    this.contactPerson,
    this.profileDescription,
    this.dob,
    this.presentAddress,
    this.joiningDate,
    this.lastModifyDate,
    this.accountCreateDate,
    this.inWishlist,
    this.totalRating,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    user: json["user"],
    profile: json["profile"],
    username: json["username"],
    designation: json["designation"],
    employeeStatus: json["employee_status"],
    connectiondate: json["connectiondate"] ,
    approved: json["approved"],
    experienceId: json["experience_id"],
    linkdin: json["linkdin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    individualId: json["individual_id"],
    isVerified: json["is_verified"],
    slug: json["slug"],
    contactPerson: json["contact_person"],
    profileDescription: json["profile_description"],
    dob: json["dob"],
    presentAddress: json["present_address"],
    joiningDate: json["joining_date"],
    lastModifyDate: json["last_modify_date"] ,
    accountCreateDate: json["account_create_date"] ,
    inWishlist: json["in_wishlist"],
    totalRating: json["totalRating"] == null ? null : TotalRating.fromJson(json["totalRating"]),

  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "profile": profile,
    "username": username,
    "designation": designation,
    "employee_status": employeeStatus,
    "connectiondate": connectiondate,
    "approved": approved,
    "experience_id": experienceId,
    "linkdin": linkdin,
    "youtube": youtube,
    "instagram": instagram,
    "facebook": facebook,
    "individual_id": individualId,
    "is_verified": isVerified,
    "slug": slug,
    "contact_person": contactPerson,
    "profile_description": profileDescription,
    "dob": dob,
    "present_address": presentAddress,
    "joining_date": joiningDate,
    "last_modify_date": lastModifyDate,
    "account_create_date": accountCreateDate,
    "in_wishlist": inWishlist,
    "totalRating": totalRating?.toJson(),
  };
}
class TotalRating {
  int? rating;
  int? noofrecord;

  TotalRating({
    this.rating,
    this.noofrecord,
  });

  factory TotalRating.fromJson(Map<String, dynamic> json) => TotalRating(
    rating: json["rating"],
    noofrecord: json["noofrecord"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "noofrecord": noofrecord,
  };
}
class Past {
  String? user;
  String? profile;
  String? username;
  String? designation;
  String? employeeStatus;
  String? connectiondate;
  String? individualId;
  String? approved;
  String? experienceId;
  bool? isVerified;
  dynamic linkdin;
  dynamic youtube;
  dynamic instagram;
  dynamic facebook;
  String? slug;
  String? contactPerson;
  dynamic profileDescription;
  dynamic dob;
  dynamic presentAddress;
  String? joiningDate;
  String? workedTillDate;
  String? lastModifyDate;
  String? accountCreateDate;
  bool? inWishlist;
  TotalRating? totalRating;
  Past({
    this.user,
    this.profile,
    this.username,
    this.designation,
    this.employeeStatus,
    this.connectiondate,
    this.approved,
    this.experienceId,
    this.linkdin,
    this.youtube,
    this.instagram,
    this.facebook,
    this.individualId,
    this.slug,
    this.contactPerson,
    this.profileDescription,
    this.dob,
    this.presentAddress,
    this.isVerified,
    this.joiningDate,
    this.workedTillDate,
    this.lastModifyDate,
    this.accountCreateDate,
    this.inWishlist,
    this.totalRating
  });

  factory Past.fromJson(Map<String, dynamic> json) => Past(
    user: json["user"],
    profile: json["profile"],
    username: json["username"],
    designation: json["designation"],
    employeeStatus: json["employee_status"],
    connectiondate: json["connectiondate"],
    approved: json["approved"],
    experienceId: json["experience_id"],
    linkdin: json["linkdin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    slug: json["slug"],
    individualId: json["individual_id"],
    contactPerson: json["contact_person"],
    profileDescription: json["profile_description"],
    dob: json["dob"],
    presentAddress: json["present_address"],
    isVerified: json["is_verified"],
    joiningDate: json["joining_date"] ,
    workedTillDate: json["worked_till_date"] ,
    lastModifyDate: json["last_modify_date"],
    accountCreateDate: json["account_create_date"] ,
    inWishlist: json["in_wishlist"],
    totalRating: json["totalRating"] == null ? null : TotalRating.fromJson(json["totalRating"]),

  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "profile": profile,
    "username": username,
    "designation": designation,
    "employee_status": employeeStatus,
    "connectiondate": connectiondate,
    "approved": approved,
    "individual_id": individualId,
    "experience_id": experienceId,
    "linkdin": linkdin,
    "youtube": youtube,
    "instagram": instagram,
    "facebook": facebook,
    "is_verified": isVerified,
    "slug": slug,
    "contact_person": contactPerson,
    "profile_description": profileDescription,
    "dob": dob,
    "present_address": presentAddress,
    "joining_date": joiningDate,
    "worked_till_date": workedTillDate,
    "last_modify_date": lastModifyDate,
    "account_create_date": accountCreateDate,
    "in_wishlist": inWishlist,
    "totalRating": totalRating?.toJson(),
  };
}
