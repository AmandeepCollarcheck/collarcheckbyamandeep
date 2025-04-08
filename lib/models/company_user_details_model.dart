
class CompanyUserDetailsModel {
  bool? status;
  String? message;
  Data? data;

  CompanyUserDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompanyUserDetailsModel.fromJson(Map<String, dynamic> json) => CompanyUserDetailsModel(
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
  String? loginauth;
  String? individualId;
  String? companyName;
  String? contactPerson;
  String? email;
  String? emailAlternate;
  String? phone;
  String? profile;
  String? socialImage;
  String? website;
  String? description;
  String? secondPhone;
  String? location;
  String? phoneVerified;
  String? emailVerified;
  bool? isVerified;
  String? userType;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  String? profileDescription;
  String? presentAddress;
  String? permanentAddress;
  bool? sameAddress;
  String? country;
  String? city;
  String? state;
  String? slug;
  String? countryName;
  String? cityName;
  dynamic stateName;
  dynamic linkdin;
  dynamic youtube;
  dynamic instagram;
  dynamic facebook;
  dynamic tumblr;
  dynamic discord;
  dynamic twitter;
  dynamic zoom;
  dynamic snapchat;
  dynamic incorporateDate;
  dynamic turnover;
  dynamic turnoverName;
  String? companySize;
  dynamic companySizeName;
  dynamic industry;
  dynamic industryName;
  int? totalConnection;
  int? profilePercentage;
  List<String>? uncomplete;
  List<dynamic>? complete;
  bool? socialLogin;

  Data({
    this.id,
    this.loginauth,
    this.individualId,
    this.companyName,
    this.contactPerson,
    this.email,
    this.emailAlternate,
    this.phone,
    this.profile,
    this.socialImage,
    this.website,
    this.description,
    this.secondPhone,
    this.location,
    this.phoneVerified,
    this.emailVerified,
    this.isVerified,
    this.userType,
    this.secondPhoneVerify,
    this.emailAlternateVerify,
    this.profileDescription,
    this.presentAddress,
    this.permanentAddress,
    this.sameAddress,
    this.country,
    this.city,
    this.state,
    this.slug,
    this.countryName,
    this.cityName,
    this.stateName,
    this.linkdin,
    this.youtube,
    this.instagram,
    this.facebook,
    this.tumblr,
    this.discord,
    this.twitter,
    this.zoom,
    this.snapchat,
    this.incorporateDate,
    this.turnover,
    this.turnoverName,
    this.companySize,
    this.companySizeName,
    this.industry,
    this.industryName,
    this.totalConnection,
    this.profilePercentage,
    this.uncomplete,
    this.complete,
    this.socialLogin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    loginauth: json["loginauth"],
    individualId: json["individual_id"],
    companyName: json["company_name"],
    contactPerson: json["contact_person"],
    email: json["email"],
    emailAlternate: json["email_alternate"],
    phone: json["phone"],
    profile: json["profile"],
    socialImage: json["social_image"],
    website: json["website"],
    description: json["description"],
    secondPhone: json["second_phone"],
    location: json["location"],
    phoneVerified: json["phone_verified"],
    emailVerified: json["email_verified"],
    isVerified: json["is_verified"],
    userType: json["user_type"],
    secondPhoneVerify: json["second_phone_verify"],
    emailAlternateVerify: json["email_alternate_verify"],
    profileDescription: json["profile_description"],
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    sameAddress: json["same_address"],
    country: json["country"],
    city: json["city"],
    state: json["state"],
    slug: json["slug"],
    countryName: json["country_name"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    linkdin: json["linkdin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    tumblr: json["tumblr"],
    discord: json["discord"],
    twitter: json["twitter"],
    zoom: json["zoom"],
    snapchat: json["snapchat"],
    incorporateDate: json["incorporate_date"],
    turnover: json["turnover"],
    turnoverName: json["turnover_name"],
    companySize: json["company_size"],
    companySizeName: json["company_size_name"],
    industry: json["industry"],
    industryName: json["industry_name"],
    totalConnection: json["totalConnection"],
    profilePercentage: json["profile_percentage"],
    uncomplete: json["uncomplete"] == null ? [] : List<String>.from(json["uncomplete"]!.map((x) => x)),
    complete: json["complete"] == null ? [] : List<dynamic>.from(json["complete"]!.map((x) => x)),
    socialLogin: json["socialLogin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loginauth": loginauth,
    "individual_id": individualId,
    "company_name": companyName,
    "contact_person": contactPerson,
    "email": email,
    "email_alternate": emailAlternate,
    "phone": phone,
    "profile": profile,
    "social_image": socialImage,
    "website": website,
    "description": description,
    "second_phone": secondPhone,
    "location": location,
    "phone_verified": phoneVerified,
    "email_verified": emailVerified,
    "is_verified": isVerified,
    "user_type": userType,
    "second_phone_verify": secondPhoneVerify,
    "email_alternate_verify": emailAlternateVerify,
    "profile_description": profileDescription,
    "present_address": presentAddress,
    "permanent_address": permanentAddress,
    "same_address": sameAddress,
    "country": country,
    "city": city,
    "state": state,
    "slug": slug,
    "country_name": countryName,
    "city_name": cityName,
    "state_name": stateName,
    "linkdin": linkdin,
    "youtube": youtube,
    "instagram": instagram,
    "facebook": facebook,
    "tumblr": tumblr,
    "discord": discord,
    "twitter": twitter,
    "zoom": zoom,
    "snapchat": snapchat,
    "incorporate_date": incorporateDate,
    "turnover": turnover,
    "turnover_name": turnoverName,
    "company_size": companySize,
    "company_size_name": companySizeName,
    "industry": industry,
    "industry_name": industryName,
    "totalConnection": totalConnection,
    "profile_percentage": profilePercentage,
    "uncomplete": uncomplete == null ? [] : List<dynamic>.from(uncomplete!.map((x) => x)),
    "complete": complete == null ? [] : List<dynamic>.from(complete!.map((x) => x)),
    "socialLogin": socialLogin,
  };
}
