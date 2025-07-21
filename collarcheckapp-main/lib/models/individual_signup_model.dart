

class IndividualSignupModel {
  bool? status;
  String? messages;
  IndividualSignUpData? data;

  IndividualSignupModel({
    this.status,
    this.messages,
    this.data,
  });

  factory IndividualSignupModel.fromJson(Map<String, dynamic> json) => IndividualSignupModel(
    status: json["status"],
    messages: json["messages"]??"The Email field must contain a valid email address",
    data: json["data"] == null ? null : IndividualSignUpData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data?.toJson(),
  };
}

class IndividualSignUpData {
  String? loginauth;
  int? id;
  String? individualId;
  dynamic profile;
  String? socialImage;
  String? profileType;
  int? profilePercentage;
  List<String>? uncomplete;
  String? fname;
  String? lname;
  String? email;
  dynamic emailAlternate;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  String? phone;
  dynamic secondPhone;
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
  String? slug;
  String? resume;
  String? resumeName;
  bool? socialLogin;

  IndividualSignUpData({
    this.loginauth,
    this.id,
    this.individualId,
    this.profile,
    this.socialImage,
    this.profileType,
    this.profilePercentage,
    this.uncomplete,
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
    this.slug,
    this.resume,
    this.resumeName,
    this.socialLogin,
  });

  factory IndividualSignUpData.fromJson(Map<String, dynamic> json) => IndividualSignUpData(
    loginauth: json["loginauth"],
    id: json["id"],
    individualId: json["individual_id"],
    profile: json["profile"],
    socialImage: json["social_image"],
    profileType: json["profile_type"],
    profilePercentage: json["profile_percentage"],
    uncomplete: json["uncomplete"] == null ? [] : List<String>.from(json["uncomplete"]!.map((x) => x)),
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
    "social_image": socialImage,
    "profile_type": profileType,
    "profile_percentage": profilePercentage,
    "uncomplete": uncomplete == null ? [] : List<dynamic>.from(uncomplete!.map((x) => x)),
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
    "slug": slug,
    "resume": resume,
    "resumeName": resumeName,
    "socialLogin": socialLogin,
  };
}
