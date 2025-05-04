

class UserProfileModel {
  bool? status;
  String? message;
  Data? data;

  UserProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? individualId;
  String? fname;
  String? lname;
  dynamic profile;
  dynamic stateName;
  bool? showReview;
  bool? showSalary;
  Setting? setting;
  String? email;
  dynamic emailAlternate;
  String? phone;
  dynamic secondPhone;
  dynamic presentAddress;
  dynamic permanentAddress;
  dynamic cityName;
  dynamic dob;
  List<dynamic>? employementHistory;
  List<dynamic>? employementHistoryNew;
  List<dynamic>? allDocument;
  List<dynamic>? allCertificate;
  List<dynamic>? allPortfolio;
  List<dynamic>? allEducation;
  String? socialImage;
  String? profileType;
  TotalRating? totalRating;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  dynamic location;
  String? workStatus;
  String? workStatusName;
  dynamic currentPosition;
  dynamic currentCompany;
  dynamic profileDescription;
  dynamic linkdin;
  dynamic youtube;
  dynamic instagram;
  dynamic facebook;
  dynamic tumblr;
  dynamic discord;
  dynamic twitter;
  dynamic zoom;
  dynamic snapchat;
  dynamic genderName;
  dynamic gender;
  bool? isVerified;
  String? userType;
  String? phoneVerified;
  String? emailVerified;
  String? stillWorkingPosition;
  String? stillWorkingCompany;
  String? stillWorking;
  String? stillWorkingCompanyName;
  String? stillWorkingPositionName;
  dynamic accomodation;
  dynamic accomodationName;
  bool? sameAddress;
  String? country;
  dynamic city;
  dynamic state;
  dynamic industry;
  dynamic countryName;
  String? resume;
  String? resumeName;
  dynamic noticePeriod;
  dynamic noticePeriodName;
  dynamic noticeDate;
  dynamic onImmediate;
  dynamic onNotice;
  dynamic expectedSalary;
  dynamic expectedInhand;
  dynamic expectedMode;
  dynamic noticeType;
  dynamic industryName;
  String? slug;
  List<dynamic>? allSkill;
  List<dynamic>? allLanguages;
  FollowData? followData;
  List<TopCompany>? topCompany;
  List<TopUser>? topUser;
  bool? haveSalary;
  bool? haveReview;
  bool? haveDocument;

  Data({
    this.id,
    this.individualId,
    this.fname,
    this.lname,
    this.profile,
    this.stateName,
    this.showReview,
    this.showSalary,
    this.setting,
    this.email,
    this.emailAlternate,
    this.phone,
    this.secondPhone,
    this.presentAddress,
    this.permanentAddress,
    this.cityName,
    this.dob,
    this.employementHistory,
    this.employementHistoryNew,
    this.allDocument,
    this.allCertificate,
    this.allPortfolio,
    this.allEducation,
    this.socialImage,
    this.profileType,
    this.totalRating,
    this.secondPhoneVerify,
    this.emailAlternateVerify,
    this.location,
    this.workStatus,
    this.workStatusName,
    this.currentPosition,
    this.currentCompany,
    this.profileDescription,
    this.linkdin,
    this.youtube,
    this.instagram,
    this.facebook,
    this.tumblr,
    this.discord,
    this.twitter,
    this.zoom,
    this.snapchat,
    this.genderName,
    this.gender,
    this.isVerified,
    this.userType,
    this.phoneVerified,
    this.emailVerified,
    this.stillWorkingPosition,
    this.stillWorkingCompany,
    this.stillWorking,
    this.stillWorkingCompanyName,
    this.stillWorkingPositionName,
    this.accomodation,
    this.accomodationName,
    this.sameAddress,
    this.country,
    this.city,
    this.state,
    this.industry,
    this.countryName,
    this.resume,
    this.resumeName,
    this.noticePeriod,
    this.noticePeriodName,
    this.noticeDate,
    this.onImmediate,
    this.onNotice,
    this.expectedSalary,
    this.expectedInhand,
    this.expectedMode,
    this.noticeType,
    this.industryName,
    this.slug,
    this.allSkill,
    this.allLanguages,
    this.followData,
    this.topCompany,
    this.topUser,
    this.haveSalary,
    this.haveReview,
    this.haveDocument,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    individualId: json["individual_id"],
    fname: json["fname"],
    lname: json["lname"],
    profile: json["profile"],
    stateName: json["state_name"],
    showReview: json["showReview"],
    showSalary: json["showSalary"],
    setting: json["setting"] == null ? null : Setting.fromJson(json["setting"]),
    email: json["email"],
    emailAlternate: json["email_alternate"],
    phone: json["phone"],
    secondPhone: json["second_phone"],
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    cityName: json["city_name"],
    dob: json["dob"],
    employementHistory: json["employement_history"] == null ? [] : List<dynamic>.from(json["employement_history"]!.map((x) => x)),
    employementHistoryNew: json["employement_history_new"] == null ? [] : List<dynamic>.from(json["employement_history_new"]!.map((x) => x)),
    allDocument: json["all_document"] == null ? [] : List<dynamic>.from(json["all_document"]!.map((x) => x)),
    allCertificate: json["all_certificate"] == null ? [] : List<dynamic>.from(json["all_certificate"]!.map((x) => x)),
    allPortfolio: json["all_portfolio"] == null ? [] : List<dynamic>.from(json["all_portfolio"]!.map((x) => x)),
    allEducation: json["all_education"] == null ? [] : List<dynamic>.from(json["all_education"]!.map((x) => x)),
    socialImage: json["social_image"],
    profileType: json["profile_type"],
    totalRating: json["totalRating"] == null ? null : TotalRating.fromJson(json["totalRating"]),
    secondPhoneVerify: json["second_phone_verify"],
    emailAlternateVerify: json["email_alternate_verify"],
    location: json["location"],
    workStatus: json["work_status"],
    workStatusName: json["work_status_name"],
    currentPosition: json["current_position"],
    currentCompany: json["current_company"],
    profileDescription: json["profile_description"],
    linkdin: json["linkdin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    tumblr: json["tumblr"],
    discord: json["discord"],
    twitter: json["twitter"],
    zoom: json["zoom"],
    snapchat: json["snapchat"],
    genderName: json["gender_name"],
    gender: json["gender"],
    isVerified: json["is_verified"],
    userType: json["user_type"],
    phoneVerified: json["phone_verified"],
    emailVerified: json["email_verified"],
    stillWorkingPosition: json["still_working_position"],
    stillWorkingCompany: json["still_working_company"],
    stillWorking: json["still_working"],
    stillWorkingCompanyName: json["still_working_company_name"],
    stillWorkingPositionName: json["still_working_position_name"],
    accomodation: json["accomodation"],
    accomodationName: json["accomodation_name"],
    sameAddress: json["same_address"],
    country: json["country"],
    city: json["city"],
    state: json["state"],
    industry: json["industry"],
    countryName: json["country_name"],
    resume: json["resume"],
    resumeName: json["resumeName"],
    noticePeriod: json["notice_period"],
    noticePeriodName: json["notice_period_name"],
    noticeDate: json["notice_date"],
    onImmediate: json["on_immediate"],
    onNotice: json["on_notice"],
    expectedSalary: json["expected_salary"],
    expectedInhand: json["expected_inhand"],
    expectedMode: json["expected_mode"],
    noticeType: json["notice_type"],
    industryName: json["industry_name"],
    slug: json["slug"],
    allSkill: json["all_Skill"] == null ? [] : List<dynamic>.from(json["all_Skill"]!.map((x) => x)),
    allLanguages: json["all_languages"] == null ? [] : List<dynamic>.from(json["all_languages"]!.map((x) => x)),
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
    topCompany: json["topCompany"] == null ? [] : List<TopCompany>.from(json["topCompany"]!.map((x) => TopCompany.fromJson(x))),
    topUser: json["topUser"] == null ? [] : List<TopUser>.from(json["topUser"]!.map((x) => TopUser.fromJson(x))),
    haveSalary: json["haveSalary"],
    haveReview: json["haveReview"],
    haveDocument: json["haveDocument"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "fname": fname,
    "lname": lname,
    "profile": profile,
    "state_name": stateName,
    "showReview": showReview,
    "showSalary": showSalary,
    "setting": setting?.toJson(),
    "email": email,
    "email_alternate": emailAlternate,
    "phone": phone,
    "second_phone": secondPhone,
    "present_address": presentAddress,
    "permanent_address": permanentAddress,
    "city_name": cityName,
    "dob": dob,
    "employement_history": employementHistory == null ? [] : List<dynamic>.from(employementHistory!.map((x) => x)),
    "employement_history_new": employementHistoryNew == null ? [] : List<dynamic>.from(employementHistoryNew!.map((x) => x)),
    "all_document": allDocument == null ? [] : List<dynamic>.from(allDocument!.map((x) => x)),
    "all_certificate": allCertificate == null ? [] : List<dynamic>.from(allCertificate!.map((x) => x)),
    "all_portfolio": allPortfolio == null ? [] : List<dynamic>.from(allPortfolio!.map((x) => x)),
    "all_education": allEducation == null ? [] : List<dynamic>.from(allEducation!.map((x) => x)),
    "social_image": socialImage,
    "profile_type": profileType,
    "totalRating": totalRating?.toJson(),
    "second_phone_verify": secondPhoneVerify,
    "email_alternate_verify": emailAlternateVerify,
    "location": location,
    "work_status": workStatus,
    "work_status_name": workStatusName,
    "current_position": currentPosition,
    "current_company": currentCompany,
    "profile_description": profileDescription,
    "linkdin": linkdin,
    "youtube": youtube,
    "instagram": instagram,
    "facebook": facebook,
    "tumblr": tumblr,
    "discord": discord,
    "twitter": twitter,
    "zoom": zoom,
    "snapchat": snapchat,
    "gender_name": genderName,
    "gender": gender,
    "is_verified": isVerified,
    "user_type": userType,
    "phone_verified": phoneVerified,
    "email_verified": emailVerified,
    "still_working_position": stillWorkingPosition,
    "still_working_company": stillWorkingCompany,
    "still_working": stillWorking,
    "still_working_company_name": stillWorkingCompanyName,
    "still_working_position_name": stillWorkingPositionName,
    "accomodation": accomodation,
    "accomodation_name": accomodationName,
    "same_address": sameAddress,
    "country": country,
    "city": city,
    "state": state,
    "industry": industry,
    "country_name": countryName,
    "resume": resume,
    "resumeName": resumeName,
    "notice_period": noticePeriod,
    "notice_period_name": noticePeriodName,
    "notice_date": noticeDate,
    "on_immediate": onImmediate,
    "on_notice": onNotice,
    "expected_salary": expectedSalary,
    "expected_inhand": expectedInhand,
    "expected_mode": expectedMode,
    "notice_type": noticeType,
    "industry_name": industryName,
    "slug": slug,
    "all_Skill": allSkill == null ? [] : List<dynamic>.from(allSkill!.map((x) => x)),
    "all_languages": allLanguages == null ? [] : List<dynamic>.from(allLanguages!.map((x) => x)),
    "followData": followData?.toJson(),
    "topCompany": topCompany == null ? [] : List<dynamic>.from(topCompany!.map((x) => x.toJson())),
    "topUser": topUser == null ? [] : List<dynamic>.from(topUser!.map((x) => x.toJson())),
    "haveSalary": haveSalary,
    "haveReview": haveReview,
    "haveDocument": haveDocument,
  };
}

class FollowData {
  int? following;
  int? follower;

  FollowData({
    this.following,
    this.follower,
  });

  factory FollowData.fromJson(Map<String, dynamic> json) => FollowData(
    following: json["following"],
    follower: json["follower"],
  );

  Map<String, dynamic> toJson() => {
    "following": following,
    "follower": follower,
  };
}

class Setting {
  String? mobile;
  String? email;
  String? address;
  String? dob;
  String? messages;

  Setting({
    this.mobile,
    this.email,
    this.address,
    this.dob,
    this.messages,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    dob: json["dob"],
    messages: json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "email": email,
    "address": address,
    "dob": dob,
    "messages": messages,
  };
}

class TopCompany {
  String? id;
  String? profile;
  String? name;
  String? individualId;
  String? slug;
  String? cityName;
  String? stateName;
  String? designationName;
  String? countryName;
  FollowData? followData;
  Following? following;

  TopCompany({
    this.id,
    this.profile,
    this.name,
    this.individualId,
    this.slug,
    this.cityName,
    this.stateName,
    this.countryName,
    this.followData,
    this.following,
    this.designationName
  });

  factory TopCompany.fromJson(Map<String, dynamic> json) => TopCompany(
    id: json["id"],
    profile: json["profile"],
    name: json["name"],
    individualId: json["individual_id"],
    slug: json["slug"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    designationName: json["designationName"],
    countryName: json["country_name"],
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
    following: json["following"] == null ? null : Following.fromJson(json["following"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "name": name,
    "individual_id": individualId,
    "slug": slug,
    "designationName":designationName,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "followData": followData?.toJson(),
    "following": following?.toJson(),
  };
}

class Following {
  bool? requestSend;
  bool? requestApproved;

  Following({
    this.requestSend,
    this.requestApproved,
  });

  factory Following.fromJson(Map<String, dynamic> json) => Following(
    requestSend: json["requestSend"],
    requestApproved: json["requestApproved"],
  );

  Map<String, dynamic> toJson() => {
    "requestSend": requestSend,
    "requestApproved": requestApproved,
  };
}

class TopUser {
  String? id;
  String? individualId;
  String? totalRating;
  String? profile;
  String? name;
  String? slug;
  String? cityName;
  String? stateName;
  String? countryName;
  String? workStatus;
  String? designationName;
  String? companyName;
  FollowData? followData;
  Following? following;

  TopUser({
    this.id,
    this.individualId,
    this.totalRating,
    this.profile,
    this.name,
    this.slug,
    this.cityName,
    this.stateName,
    this.countryName,
    this.workStatus,
    this.designationName,
    this.companyName,
    this.followData,
    this.following,
  });

  factory TopUser.fromJson(Map<String, dynamic> json) => TopUser(
    id: json["id"],
    individualId: json["individual_id"],
    totalRating: json["totalRating"],
    profile: json["profile"],
    name: json["name"],
    slug: json["slug"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    workStatus: json["work_status"],
    designationName: json["designation_name"],
    companyName: json["company_name"],
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
    following: json["following"] == null ? null : Following.fromJson(json["following"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "totalRating": totalRating,
    "profile": profile,
    "name": name,
    "slug": slug,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "work_status": workStatus,
    "designation_name": designationName,
    "company_name": companyName,
    "followData": followData?.toJson(),
    "following": following?.toJson(),
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
