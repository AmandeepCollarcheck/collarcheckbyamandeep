

class SocailLoginModel {
  bool? status;
  String? message;
  bool? socialLogin;
  Data? data;

  SocailLoginModel({
    this.status,
    this.message,
    this.socialLogin,
    this.data,
  });

  factory SocailLoginModel.fromJson(Map<String, dynamic> json) => SocailLoginModel(
    status: json["status"],
    message: json["message"],
    socialLogin: json["socialLogin"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "socialLogin": socialLogin,
    "data": data?.toJson(),
  };
}

class Data {
  String? loginauth;
  String? id;
  String? individualId;
  String? profile;
  String? profileType;
  int? profilePercentage;
  List<String>? uncomplete;
  Complete? complete;
  String? fname;
  String? lname;
  String? email;
  dynamic emailAlternate;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  dynamic phone;
  dynamic secondPhone;
  dynamic location;
  dynamic workStatus;
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
  dynamic presentAddress;
  dynamic permanentAddress;
  bool? sameAddress;
  dynamic country;
  dynamic dob;
  dynamic city;
  dynamic state;
  dynamic industry;
  dynamic countryName;
  dynamic cityName;
  dynamic stateName;
  dynamic industryName;
  dynamic noticePeriod;
  dynamic noticePeriodName;
  dynamic noticeDate;
  dynamic onImmediate;
  dynamic onNotice;
  dynamic expectedSalary;
  dynamic expectedInhand;
  dynamic expectedMode;
  dynamic noticeType;
  String? slug;
  String? resume;
  String? resumeName;
  bool? socialLogin;

  Data({
    this.loginauth,
    this.id,
    this.individualId,
    this.profile,
    this.profileType,
    this.profilePercentage,
    this.uncomplete,
    this.complete,
    this.fname,
    this.lname,
    this.email,
    this.emailAlternate,
    this.secondPhoneVerify,
    this.emailAlternateVerify,
    this.phone,
    this.secondPhone,
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
    this.presentAddress,
    this.permanentAddress,
    this.sameAddress,
    this.country,
    this.dob,
    this.city,
    this.state,
    this.industry,
    this.countryName,
    this.cityName,
    this.stateName,
    this.industryName,
    this.noticePeriod,
    this.noticePeriodName,
    this.noticeDate,
    this.onImmediate,
    this.onNotice,
    this.expectedSalary,
    this.expectedInhand,
    this.expectedMode,
    this.noticeType,
    this.slug,
    this.resume,
    this.resumeName,
    this.socialLogin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    loginauth: json["loginauth"],
    id: json["id"],
    individualId: json["individual_id"],
    profile: json["profile"],
    profileType: json["profile_type"],
    profilePercentage: json["profile_percentage"],
    uncomplete: json["uncomplete"] == null ? [] : List<String>.from(json["uncomplete"]!.map((x) => x)),
    complete: json["complete"] == null ? null : Complete.fromJson(json["complete"]),
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    emailAlternate: json["email_alternate"],
    secondPhoneVerify: json["second_phone_verify"],
    emailAlternateVerify: json["email_alternate_verify"],
    phone: json["phone"],
    secondPhone: json["second_phone"],
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
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    sameAddress: json["same_address"],
    country: json["country"],
    dob: json["dob"],
    city: json["city"],
    state: json["state"],
    industry: json["industry"],
    countryName: json["country_name"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    industryName: json["industry_name"],
    noticePeriod: json["notice_period"],
    noticePeriodName: json["notice_period_name"],
    noticeDate: json["notice_date"],
    onImmediate: json["on_immediate"],
    onNotice: json["on_notice"],
    expectedSalary: json["expected_salary"],
    expectedInhand: json["expected_inhand"],
    expectedMode: json["expected_mode"],
    noticeType: json["notice_type"],
    slug: json["slug"],
    resume: json["resume"],
    resumeName: json["resumeName"],
    socialLogin: json["socialLogin"],
  );

  Map<String, dynamic> toJson() => {
    "loginauth": loginauth,
    "id": id,
    "individual_id": individualId,
    "profile": profile,
    "profile_type": profileType,
    "profile_percentage": profilePercentage,
    "uncomplete": uncomplete == null ? [] : List<dynamic>.from(uncomplete!.map((x) => x)),
    "complete": complete?.toJson(),
    "fname": fname,
    "lname": lname,
    "email": email,
    "email_alternate": emailAlternate,
    "second_phone_verify": secondPhoneVerify,
    "email_alternate_verify": emailAlternateVerify,
    "phone": phone,
    "second_phone": secondPhone,
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
    "present_address": presentAddress,
    "permanent_address": permanentAddress,
    "same_address": sameAddress,
    "country": country,
    "dob": dob,
    "city": city,
    "state": state,
    "industry": industry,
    "country_name": countryName,
    "city_name": cityName,
    "state_name": stateName,
    "industry_name": industryName,
    "notice_period": noticePeriod,
    "notice_period_name": noticePeriodName,
    "notice_date": noticeDate,
    "on_immediate": onImmediate,
    "on_notice": onNotice,
    "expected_salary": expectedSalary,
    "expected_inhand": expectedInhand,
    "expected_mode": expectedMode,
    "notice_type": noticeType,
    "slug": slug,
    "resume": resume,
    "resumeName": resumeName,
    "socialLogin": socialLogin,
  };
}

class Complete {
  int? email;
  int? emailVerified;

  Complete({
    this.email,
    this.emailVerified,
  });

  factory Complete.fromJson(Map<String, dynamic> json) => Complete(
    email: json["email"],
    emailVerified: json["email_verified"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "email_verified": emailVerified,
  };
}
