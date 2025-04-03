

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
  List<Past>? current;
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
    current: json["current"] == null ? [] : List<Past>.from(json["current"]!.map((x) => Past.fromJson(x))),
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

class Past {
  String? user;
  dynamic profile;
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
    this.slug,
    this.contactPerson,
    this.profileDescription,
    this.dob,
    this.presentAddress,
    this.joiningDate,
    this.workedTillDate,
    this.lastModifyDate,
    this.accountCreateDate,
    this.inWishlist,
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
    contactPerson: json["contact_person"],
    profileDescription: json["profile_description"],
    dob: json["dob"],
    presentAddress: json["present_address"],
    joiningDate: json["joining_date"] ,
    workedTillDate: json["worked_till_date"] ,
    lastModifyDate: json["last_modify_date"],
    accountCreateDate: json["account_create_date"] ,
    inWishlist: json["in_wishlist"],
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
  };
}
