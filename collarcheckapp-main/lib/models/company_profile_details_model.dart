
class CompanyProfileDetailsModel {
  bool? status;
  String? message;
  Data? data;

  CompanyProfileDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompanyProfileDetailsModel.fromJson(Map<String, dynamic> json) => CompanyProfileDetailsModel(
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
  bool? isVerified;
  String? individualId;
  String? companyName;
  String? contactPerson;
  String? email;
  dynamic emailAlternate;
  String? phone;
  dynamic profile;
  String? website;
  String? description;
  dynamic secondPhone;
  dynamic location;
  String? phoneVerified;
  String? emailVerified;
  String? userType;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  String? profileDescription;
  dynamic presentAddress;
  dynamic country;
  dynamic city;
  dynamic state;
  String? slug;
  dynamic countryName;
  dynamic cityName;
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
  String? incorporateDate;
  String? turnover;
  String? claimStatus;
  dynamic turnoverName;
  String? industry;
  String? industryName;
  String? companySize;
  dynamic companySizeName;
  int? totalEmployee;
  int? allEmploymentCount;
  List<Alljob>? alljob;
  List<TopCompany>? topCompany;
  List<TopUser>? topUser;
  List<AllBenefit>? allGallery;
  List<AllBenefit>? allBenefits;
  FollowData? followData;

  Data({
    this.id,
    this.isVerified,
    this.individualId,
    this.companyName,
    this.contactPerson,
    this.email,
    this.emailAlternate,
    this.phone,
    this.profile,
    this.website,
    this.description,
    this.secondPhone,
    this.location,
    this.phoneVerified,
    this.emailVerified,
    this.userType,
    this.secondPhoneVerify,
    this.emailAlternateVerify,
    this.profileDescription,
    this.presentAddress,
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
    this.claimStatus,
    this.turnoverName,
    this.industry,
    this.industryName,
    this.companySize,
    this.companySizeName,
    this.totalEmployee,
    this.allEmploymentCount,
    this.alljob,
    this.topCompany,
    this.topUser,
    this.allGallery,
    this.allBenefits,
    this.followData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    isVerified: json["is_verified"],
    individualId: json["individual_id"],
    companyName: json["company_name"],
    contactPerson: json["contact_person"],
    email: json["email"],
    emailAlternate: json["email_alternate"],
    phone: json["phone"],
    profile: json["profile"],
    website: json["website"],
    description: json["description"],
    secondPhone: json["second_phone"],
    location: json["location"],
    phoneVerified: json["phone_verified"],
    emailVerified: json["email_verified"],
    userType: json["user_type"],
    secondPhoneVerify: json["second_phone_verify"],
    emailAlternateVerify: json["email_alternate_verify"],
    profileDescription: json["profile_description"],
    presentAddress: json["present_address"],
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
    claimStatus: json["claim_status"],
    turnoverName: json["turnover_name"],
    industry: json["industry"],
    industryName: json["industry_name"],
    companySize: json["company_size"],
    companySizeName: json["company_size_name"],
    totalEmployee: json["total_employee"],
    allEmploymentCount: json["allEmploymentCount"],
    alljob: json["alljob"] == null ? [] : List<Alljob>.from(json["alljob"]!.map((x) => Alljob.fromJson(x))),
    topCompany: json["topCompany"] == null ? [] : List<TopCompany>.from(json["topCompany"]!.map((x) => TopCompany.fromJson(x))),
    topUser: json["topUser"] == null ? [] : List<TopUser>.from(json["topUser"]!.map((x) => TopUser.fromJson(x))),
    allGallery: json["allGallery"] == null ? [] : List<AllBenefit>.from(json["allGallery"]!.map((x) => AllBenefit.fromJson(x))),
    allBenefits: json["allBenefits"] == null ? [] : List<AllBenefit>.from(json["allBenefits"]!.map((x) => AllBenefit.fromJson(x))),
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_verified": isVerified,
    "individual_id": individualId,
    "company_name": companyName,
    "contact_person": contactPerson,
    "email": email,
    "email_alternate": emailAlternate,
    "phone": phone,
    "profile": profile,
    "website": website,
    "description": description,
    "second_phone": secondPhone,
    "location": location,
    "phone_verified": phoneVerified,
    "email_verified": emailVerified,
    "user_type": userType,
    "second_phone_verify": secondPhoneVerify,
    "email_alternate_verify": emailAlternateVerify,
    "profile_description": profileDescription,
    "present_address": presentAddress,
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
    "claim_status": claimStatus,
    "turnover_name": turnoverName,
    "industry": industry,
    "industry_name": industryName,
    "company_size": companySize,
    "company_size_name": companySizeName,
    "total_employee": totalEmployee,
    "allEmploymentCount": allEmploymentCount,
    "alljob": alljob == null ? [] : List<dynamic>.from(alljob!.map((x) => x.toJson())),
    "topCompany": topCompany == null ? [] : List<dynamic>.from(topCompany!.map((x) => x.toJson())),
    "topUser": topUser == null ? [] : List<dynamic>.from(topUser!.map((x) => x.toJson())),
    "allGallery": allGallery == null ? [] : List<dynamic>.from(allGallery!.map((x) => x.toJson())),
    "allBenefits": allBenefits == null ? [] : List<dynamic>.from(allBenefits!.map((x) => x.toJson())),
    "followData": followData?.toJson(),
  };
}
class Alljob {
  String? id;
  String? title;
  String? profile;
  String? experienceName;
  String? departmentName;
  dynamic roleTypeName;
  String? vacancy;
  String? slug;
  String? countryName;
  String? stateName;
  String? cityName;
  String? designationName;
  String? salary;
  String? salaryName;
  String? noOfApplication;
  String? createDate;
  bool? urgent;

  Alljob({
    this.id,
    this.title,
    this.experienceName,
    this.departmentName,
    this.roleTypeName,
    this.vacancy,
    this.slug,
    this.countryName,
    this.stateName,
    this.cityName,
    this.designationName,
    this.salary,
    this.profile,
    this.noOfApplication,
    this.createDate,
    this.urgent,
    this.salaryName
  });

  factory Alljob.fromJson(Map<String, dynamic> json) => Alljob(
    id: json["id"],
    title: json["title"],
    experienceName: json["experience_name"],
    departmentName: json["department_name"],
    roleTypeName: json["role_type_name"],
    vacancy: json["vacancy"],
    slug: json["slug"],
    profile: json["profile"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    cityName: json["city_name"],
    designationName: json["designation_name"],
    salary: json["salary"],
    salaryName: json["salary_name"],
    noOfApplication: json["no_of_application"],
    createDate: json["create_date"],
    urgent: json["urgent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "experience_name": experienceName,
    "department_name": departmentName,
    "role_type_name": roleTypeName,
    "vacancy": vacancy,
    "slug": slug,
    "profile": profile,
    "country_name": countryName,
    "state_name": stateName,
    "city_name": cityName,
    "designation_name": designationName,
    "salary": salary,
    "salary_name": salaryName,
    "no_of_application": noOfApplication,
    "create_date": createDate,
    "urgent": urgent,
  };
}
class TopUser {
  String? id;
  String? individualId;
  String? profile;
  String? name;
  bool? isVerified;
  String? slug;
  String? cityName;
  dynamic rating;
  String? stateName;
  String? countryName;
  String? workStatus;
  String? designationName;
  String? companyName;
  FollowData? followData;

  TopUser({
    this.id,
    this.individualId,
    this.profile,
    this.name,
    this.slug,
    this.cityName,
    this.rating,
    this.stateName,
    this.countryName,
    this.workStatus,
    this.designationName,
    this.companyName,
    this.followData,
    this.isVerified
  });

  factory TopUser.fromJson(Map<String, dynamic> json) => TopUser(
    id: json["id"],
    individualId: json["individual_id"],
    profile: json["profile"],
    name: json["name"],
    slug: json["slug"],
    isVerified: json["isVerified"],
    cityName: json["city_name"],
    rating: json["rating"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    workStatus: json["work_status"],
    designationName: json["designation_name"],
    companyName: json["company_name"],
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "profile": profile,
    "name": name,
    "slug": slug,
    "isVerified":isVerified,
    "city_name": cityName,
    "rating": rating,
    "state_name": stateName,
    "country_name": countryName,
    "work_status": workStatus,
    "designation_name": designationName,
    "company_name": companyName,
    "followData": followData?.toJson(),
  };
}
class AllBenefit {
  String? name;
  String? image;

  AllBenefit({
    this.name,
    this.image,
  });

  factory AllBenefit.fromJson(Map<String, dynamic> json) => AllBenefit(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
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

class TopCompany {
  String? id;
  String? profile;
  String? name;
  bool? isVerified;
  String? individualId;
  String? slug;
  String? cityName;
  String? stateName;
  String? countryName;
  FollowData? followData;

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
    this.isVerified
  });

  factory TopCompany.fromJson(Map<String, dynamic> json) => TopCompany(
    id: json["id"],
    profile: json["profile"],
    name: json["name"],
    individualId: json["individual_id"],
    slug: json["slug"],
    isVerified: json["isVerified"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "name": name,
    "individual_id": individualId,
    "slug": slug,
    "isVerified":isVerified,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "followData": followData?.toJson(),
  };
}
