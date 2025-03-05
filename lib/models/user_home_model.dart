

class UserHomeModel {
  bool? status;
  Data? data;

  UserHomeModel({
    this.status,
    this.data,
  });

  factory UserHomeModel.fromJson(Map<String, dynamic> json) => UserHomeModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  UserDetail? userDetail;
  List<TopIndustry>? topIndustries;
  List<JobForYou>? jobForYou;
  List<RecommendedJob>? recommendJob;

  Data({
    this.userDetail,
    this.topIndustries,
    this.jobForYou,
    this.recommendJob,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userDetail: json["userDetail"] == null ? null : UserDetail.fromJson(json["userDetail"]),
    topIndustries: json["topIndustries"] == null ? [] : List<TopIndustry>.from(json["topIndustries"]!.map((x) => TopIndustry.fromJson(x))),
    jobForYou: json["jobForYou"] == null ? [] : List<JobForYou>.from(json["jobForYou"]!.map((x) => JobForYou.fromJson(x))),
    recommendJob: json["RecommendJob"] == null ? [] : List<RecommendedJob>.from(json["RecommendJob"]!.map((x) => RecommendedJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userDetail": userDetail?.toJson(),
    "topIndustries": topIndustries == null ? [] : List<dynamic>.from(topIndustries!.map((x) => x.toJson())),
    "jobForYou": jobForYou == null ? [] : List<dynamic>.from(jobForYou!.map((x) => x.toJson())),
    "RecommendJob": recommendJob == null ? [] : List<dynamic>.from(recommendJob!.map((x) => x.toJson())),
  };
}

class JobForYou {
  String? id;
  String? jobTitle;
  String? jobDescription;
  String? rolesResponsibility;
  String? departmentName;
  String? experienceName;
  String? department;
  String? experience;
  List<Skill>? skill;
  String? roleTypeName;
  String? jobModeName;
  String? industryName;
  String? roleType;
  String? industry;
  String? vacancy;
  bool? urgent;
  String? designationName;
  String? countryName;
  String? stateName;
  String? designation;
  String? country;
  String? state;
  String? city;
  String? jobMode;
  String? document;
  String? cityName;
  String? salary;
  String? salaryName;
  String? companyName;
  String? profile;
  String? createDate;
  String? applicationCount;
  String? status;
  String? slug;
  List<String>? gallery;
  String? companySlug;
  bool? apply;

  JobForYou({
    this.id,
    this.jobTitle,
    this.jobDescription,
    this.rolesResponsibility,
    this.departmentName,
    this.experienceName,
    this.department,
    this.experience,
    this.skill,
    this.roleTypeName,
    this.jobModeName,
    this.industryName,
    this.roleType,
    this.industry,
    this.vacancy,
    this.urgent,
    this.designationName,
    this.countryName,
    this.stateName,
    this.designation,
    this.country,
    this.state,
    this.city,
    this.jobMode,
    this.document,
    this.cityName,
    this.salary,
    this.salaryName,
    this.companyName,
    this.profile,
    this.createDate,
    this.applicationCount,
    this.status,
    this.slug,
    this.gallery,
    this.companySlug,
    this.apply,
  });

  factory JobForYou.fromJson(Map<String, dynamic> json) => JobForYou(
    id: json["id"],
    jobTitle: json["job_title"],
    jobDescription: json["job_description"],
    rolesResponsibility: json["roles_responsibility"],
    departmentName: json["department_name"],
    experienceName: json["experience_name"],
    department: json["department"],
    experience: json["experience"],
    skill: json["skill"] == null ? [] : List<Skill>.from(json["skill"]!.map((x) => Skill.fromJson(x))),
    roleTypeName: json["role_type_name"],
    jobModeName: json["job_mode_name"],
    industryName: json["industry_name"],
    roleType: json["role_type"],
    industry: json["industry"],
    vacancy: json["vacancy"],
    urgent: json["urgent"],
    designationName: json["designation_name"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    designation: json["designation"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    jobMode: json["job_mode"],
    document: json["document"],
    cityName: json["city_name"],
    salary: json["salary"],
    salaryName: json["salary_name"],
    companyName: json["company_name"],
    profile: json["profile"],
    createDate: json["create_date"] ,
    applicationCount: json["applicationCount"],
    status: json["status"],
    slug: json["slug"],
    gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"]!.map((x) => x)),
    companySlug: json["company_slug"],
    apply: json["apply"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_title": jobTitle,
    "job_description": jobDescription,
    "roles_responsibility": rolesResponsibility,
    "department_name": departmentName,
    "experience_name": experienceName,
    "department": department,
    "experience": experience,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x.toJson())),
    "role_type_name": roleTypeName,
    "job_mode_name": jobModeName,
    "industry_name": industryName,
    "role_type": roleType,
    "industry": industry,
    "vacancy": vacancy,
    "urgent": urgent,
    "designation_name": designationName,
    "country_name": countryName,
    "state_name": stateName,
    "designation": designation,
    "country": country,
    "state": state,
    "city": city,
    "job_mode": jobMode,
    "document": document,
    "city_name": cityName,
    "salary": salary,
    "salary_name": salaryName,
    "company_name": companyName,
    "profile": profile,
    "create_date": createDate,
    "applicationCount": applicationCount,
    "status": status,
    "slug": slug,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "company_slug": companySlug,
    "apply": apply,
  };
}
class RecommendedJob {
  String? id;
  String? jobTitle;
  String? jobDescription;
  String? rolesResponsibility;
  String? departmentName;
  String? experienceName;
  String? department;
  String? experience;
  List<Skill>? skill;
  String? roleTypeName;
  String? jobModeName;
  String? industryName;
  String? roleType;
  String? industry;
  String? vacancy;
  bool? urgent;
  String? designationName;
  String? countryName;
  String? stateName;
  String? designation;
  String? country;
  String? state;
  String? city;
  String? jobMode;
  String? document;
  String? cityName;
  String? salary;
  String? salaryName;
  String? companyName;
  String? profile;
  String? createDate;
  String? applicationCount;
  String? status;
  String? slug;
  List<String>? gallery;
  String? companySlug;
  bool? apply;

  RecommendedJob({
    this.id,
    this.jobTitle,
    this.jobDescription,
    this.rolesResponsibility,
    this.departmentName,
    this.experienceName,
    this.department,
    this.experience,
    this.skill,
    this.roleTypeName,
    this.jobModeName,
    this.industryName,
    this.roleType,
    this.industry,
    this.vacancy,
    this.urgent,
    this.designationName,
    this.countryName,
    this.stateName,
    this.designation,
    this.country,
    this.state,
    this.city,
    this.jobMode,
    this.document,
    this.cityName,
    this.salary,
    this.salaryName,
    this.companyName,
    this.profile,
    this.createDate,
    this.applicationCount,
    this.status,
    this.slug,
    this.gallery,
    this.companySlug,
    this.apply,
  });

  factory RecommendedJob.fromJson(Map<String, dynamic> json) => RecommendedJob(
    id: json["id"],
    jobTitle: json["job_title"],
    jobDescription: json["job_description"],
    rolesResponsibility: json["roles_responsibility"],
    departmentName: json["department_name"],
    experienceName: json["experience_name"],
    department: json["department"],
    experience: json["experience"],
    skill: json["skill"] == null ? [] : List<Skill>.from(json["skill"]!.map((x) => Skill.fromJson(x))),
    roleTypeName: json["role_type_name"],
    jobModeName: json["job_mode_name"],
    industryName: json["industry_name"],
    roleType: json["role_type"],
    industry: json["industry"],
    vacancy: json["vacancy"],
    urgent: json["urgent"],
    designationName: json["designation_name"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    designation: json["designation"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    jobMode: json["job_mode"],
    document: json["document"],
    cityName: json["city_name"],
    salary: json["salary"],
    salaryName: json["salary_name"],
    companyName: json["company_name"],
    profile: json["profile"],
    createDate: json["create_date"] ,
    applicationCount: json["applicationCount"],
    status: json["status"],
    slug: json["slug"],
    gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"]!.map((x) => x)),
    companySlug: json["company_slug"],
    apply: json["apply"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_title": jobTitle,
    "job_description": jobDescription,
    "roles_responsibility": rolesResponsibility,
    "department_name": departmentName,
    "experience_name": experienceName,
    "department": department,
    "experience": experience,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x.toJson())),
    "role_type_name": roleTypeName,
    "job_mode_name": jobModeName,
    "industry_name": industryName,
    "role_type": roleType,
    "industry": industry,
    "vacancy": vacancy,
    "urgent": urgent,
    "designation_name": designationName,
    "country_name": countryName,
    "state_name": stateName,
    "designation": designation,
    "country": country,
    "state": state,
    "city": city,
    "job_mode": jobMode,
    "document": document,
    "city_name": cityName,
    "salary": salary,
    "salary_name": salaryName,
    "company_name": companyName,
    "profile": profile,
    "create_date": createDate,
    "applicationCount": applicationCount,
    "status": status,
    "slug": slug,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "company_slug": companySlug,
    "apply": apply,
  };
}

class Skill {
  String? id;
  String? name;

  Skill({
    this.id,
    this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class TopIndustry {
  String? id;
  String? industryCount;
  String? name;
  List<String?>? images;

  TopIndustry({
    this.id,
    this.industryCount,
    this.name,
    this.images,
  });

  factory TopIndustry.fromJson(Map<String, dynamic> json) => TopIndustry(
    id: json["id"],
    industryCount: json["industry_count"],
    name: json["name"],
    images: json["images"] == null ? [] : List<String?>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "industry_count": industryCount,
    "name": name,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}

class UserDetail {
  String? id;
  String? loginauth;
  String? individualId;
  String? companyName;
  String? contactPerson;
  String? email;
  dynamic emailAlternate;
  String? phone;
  dynamic profile;
  String? socialImage;
  dynamic website;
  dynamic description;
  dynamic secondPhone;
  dynamic location;
  String? phoneVerified;
  String? emailVerified;
  bool? isVerified;
  String? userType;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  dynamic profileDescription;
  dynamic accomodation;
  dynamic accomodationName;
  dynamic presentAddress;
  dynamic permanentAddress;
  bool? sameAddress;
  dynamic country;
  dynamic dob;
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
  dynamic incorporateDate;
  dynamic turnover;
  dynamic industry;
  dynamic industryName;
  num? totalConnection;
  num? profilePercentage;
  List<String>? uncomplete;
  bool? socialLogin;

  UserDetail({
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
    this.accomodation,
    this.accomodationName,
    this.presentAddress,
    this.permanentAddress,
    this.sameAddress,
    this.country,
    this.dob,
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
    this.industry,
    this.industryName,
    this.totalConnection,
    this.profilePercentage,
    this.uncomplete,
    this.socialLogin,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
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
    accomodation: json["accomodation"],
    accomodationName: json["accomodation_name"],
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    sameAddress: json["same_address"],
    country: json["country"],
    dob: json["dob"],
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
    industry: json["industry"],
    industryName: json["industry_name"],
    totalConnection: json["totalConnection"],
    profilePercentage: json["profile_percentage"],
    uncomplete: json["uncomplete"] == null ? [] : List<String>.from(json["uncomplete"]!.map((x) => x)),
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
    "accomodation": accomodation,
    "accomodation_name": accomodationName,
    "present_address": presentAddress,
    "permanent_address": permanentAddress,
    "same_address": sameAddress,
    "country": country,
    "dob": dob,
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
    "industry": industry,
    "industry_name": industryName,
    "totalConnection": totalConnection,
    "profile_percentage": profilePercentage,
    "uncomplete": uncomplete == null ? [] : List<dynamic>.from(uncomplete!.map((x) => x)),
    "socialLogin": socialLogin,
  };
}
