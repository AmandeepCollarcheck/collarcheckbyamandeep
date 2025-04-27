

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
  String? email;
  String? phone;
  String? individualId;
  String? fname;
  String? lname;
  String? profile;
  dynamic stateName;
  bool? showReview;
  bool? showSalary;
  List<dynamic>? employementHistory;
  List<EmployementHistoryNew>? employementHistoryNew;
  List<dynamic>? allDocument;
  List<AllCertificate>? allCertificate;
  List<AllPortfolio>? allPortfolio;
  List<AllEducation>? allEducation;
  String? socialImage;
  dynamic profileType;
  TotalRating? totalRating;
  dynamic secondPhoneVerify;
  dynamic emailAlternateVerify;
  dynamic location;
  String? workStatus;
  String? workStatusName;
  String? currentPosition;
  String? currentCompany;
  String? profileDescription;
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
  dynamic country;
  dynamic city;
  dynamic state;
  dynamic industry;
  dynamic countryName;
  String? resume;
  String? resumeName;
  dynamic noticePeriod;
  dynamic noticePeriodName;
  dynamic noticeDate;
  String? onImmediate;
  String? onNotice;
  dynamic expectedSalary;
  dynamic expectedInhand;
  dynamic expectedMode;
  dynamic noticeType;
  dynamic industryName;
  String? slug;
  List<AllSkill>? allSkill;
  List<AllLanguage>? allLanguages;
  FollowData? followData;
  List<TopCompany>? topCompany;
  List<TopUser>? topUser;
  Following? following;
  AllowReview? allowReview;
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
    this.following,
    this.allowReview,
    this.haveSalary,
    this.haveReview,
    this.haveDocument,
    this.phone,
    this.email
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    individualId: json["individual_id"],
    fname: json["fname"],
    lname: json["lname"],
    email: json['email'],
    phone: json['phone'],
    profile: json["profile"],
    stateName: json["state_name"],
    showReview: json["showReview"],
    showSalary: json["showSalary"],
    employementHistory: json["employement_history"] == null ? [] : List<dynamic>.from(json["employement_history"]!.map((x) => x)),
    employementHistoryNew: json["employement_history_new"] == null ? [] : List<EmployementHistoryNew>.from(json["employement_history_new"]!.map((x) => EmployementHistoryNew.fromJson(x))),
    allDocument: json["all_document"] == null ? [] : List<dynamic>.from(json["all_document"]!.map((x) => x)),
    allCertificate: json["all_certificate"] == null ? [] : List<AllCertificate>.from(json["all_certificate"]!.map((x) => AllCertificate.fromJson(x))),
    allPortfolio: json["all_portfolio"] == null ? [] : List<AllPortfolio>.from(json["all_portfolio"]!.map((x) => AllPortfolio.fromJson(x))),
    allEducation: json["all_education"] == null ? [] : List<AllEducation>.from(json["all_education"]!.map((x) => AllEducation.fromJson(x))),
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
    allSkill: json["all_Skill"] == null ? [] : List<AllSkill>.from(json["all_Skill"]!.map((x) => AllSkill.fromJson(x))),
    allLanguages: json["all_languages"] == null ? [] : List<AllLanguage>.from(json["all_languages"]!.map((x) => AllLanguage.fromJson(x))),
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
    topCompany: json["topCompany"] == null ? [] : List<TopCompany>.from(json["topCompany"]!.map((x) => TopCompany.fromJson(x))),
    topUser: json["topUser"] == null ? [] : List<TopUser>.from(json["topUser"]!.map((x) => TopUser.fromJson(x))),
    following: json["following"] == null ? null : Following.fromJson(json["following"]),
    allowReview: json["allowReview"] == null ? null : AllowReview.fromJson(json["allowReview"]),
    haveSalary: json["haveSalary"],
    haveReview: json["haveReview"],
    haveDocument: json["haveDocument"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "fname": fname,
    "lname": lname,
    "email":email,
    "phone":phone,
    "profile": profile,
    "state_name": stateName,
    "showReview": showReview,
    "showSalary": showSalary,
    "employement_history": employementHistory == null ? [] : List<dynamic>.from(employementHistory!.map((x) => x)),
    "employement_history_new": employementHistoryNew == null ? [] : List<dynamic>.from(employementHistoryNew!.map((x) => x.toJson())),
    "all_document": allDocument == null ? [] : List<dynamic>.from(allDocument!.map((x) => x)),
    "all_certificate": allCertificate == null ? [] : List<dynamic>.from(allCertificate!.map((x) => x.toJson())),
    "all_portfolio": allPortfolio == null ? [] : List<dynamic>.from(allPortfolio!.map((x) => x.toJson())),
    "all_education": allEducation == null ? [] : List<dynamic>.from(allEducation!.map((x) => x.toJson())),
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
    "all_Skill": allSkill == null ? [] : List<dynamic>.from(allSkill!.map((x) => x.toJson())),
    "all_languages": allLanguages == null ? [] : List<dynamic>.from(allLanguages!.map((x) => x.toJson())),
    "followData": followData?.toJson(),
    "topCompany": topCompany == null ? [] : List<dynamic>.from(topCompany!.map((x) => x.toJson())),
    "topUser": topUser == null ? [] : List<dynamic>.from(topUser!.map((x) => x.toJson())),
    "following": following?.toJson(),
    "allowReview": allowReview?.toJson(),
    "haveSalary": haveSalary,
    "haveReview": haveReview,
    "haveDocument": haveDocument,
  };
}

class AllCertificate {
  String? id;
  String? university;
  String? course;
  dynamic startDate;
  dynamic endDate;
  bool? ongoing;
  List<String>? document;

  AllCertificate({
    this.id,
    this.university,
    this.course,
    this.startDate,
    this.endDate,
    this.ongoing,
    this.document,
  });

  factory AllCertificate.fromJson(Map<String, dynamic> json) => AllCertificate(
    id: json["id"],
    university: json["university"],
    course: json["course"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    ongoing: json["ongoing"],
    document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "university": university,
    "course": course,
    "start_date": startDate,
    "end_date": endDate,
    "ongoing": ongoing,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
  };
}

class AllEducation {
  String? id;
  String? university;
  String? courseType;
  String? course;
  String? state;
  String? city;
  DateTime? startingDate;
  DateTime? endingDate;
  String? country;
  bool? ishighest;
  bool? ongoing;
  List<dynamic>? document;

  AllEducation({
    this.id,
    this.university,
    this.courseType,
    this.course,
    this.state,
    this.city,
    this.startingDate,
    this.endingDate,
    this.country,
    this.ishighest,
    this.ongoing,
    this.document,
  });

  factory AllEducation.fromJson(Map<String, dynamic> json) => AllEducation(
    id: json["id"],
    university: json["university"],
    courseType: json["course_type"],
    course: json["course"],
    state: json["state"],
    city: json["city"],
    startingDate: json["starting_date"] == null ? null : DateTime.parse(json["starting_date"]),
    endingDate: json["ending_date"] == null ? null : DateTime.parse(json["ending_date"]),
    country: json["country"],
    ishighest: json["ishighest"],
    ongoing: json["ongoing"],
    document: json["document"] == null ? [] : List<dynamic>.from(json["document"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "university": university,
    "course_type": courseType,
    "course": course,
    "state": state,
    "city": city,
    "starting_date": "${startingDate!.year.toString().padLeft(4, '0')}-${startingDate!.month.toString().padLeft(2, '0')}-${startingDate!.day.toString().padLeft(2, '0')}",
    "ending_date": "${endingDate!.year.toString().padLeft(4, '0')}-${endingDate!.month.toString().padLeft(2, '0')}-${endingDate!.day.toString().padLeft(2, '0')}",
    "country": country,
    "ishighest": ishighest,
    "ongoing": ongoing,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
  };
}

class AllLanguage {
  String? id;
  String? name;
  String? verbal;
  String? written;

  AllLanguage({
    this.id,
    this.name,
    this.verbal,
    this.written,
  });

  factory AllLanguage.fromJson(Map<String, dynamic> json) => AllLanguage(
    id: json["id"],
    name: json["name"],
    verbal: json["verbal"],
    written: json["written"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "verbal": verbal,
    "written": written,
  };
}

class AllPortfolio {
  String? id;
  String? type;
  String? title;
  String? image;
  String? description;

  AllPortfolio({
    this.id,
    this.type,
    this.title,
    this.image,
    this.description,
  });

  factory AllPortfolio.fromJson(Map<String, dynamic> json) => AllPortfolio(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "image": image,
    "description": description,
  };
}

class AllSkill {
  String? id;
  String? skill;
  String? rating;

  AllSkill({
    this.id,
    this.skill,
    this.rating,
  });

  factory AllSkill.fromJson(Map<String, dynamic> json) => AllSkill(
    id: json["id"],
    skill: json["skill"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "skill": skill,
    "rating": rating,
  };
}

class AllowReview {
  bool? requestSend;
  bool? requestApproved;
  bool? requestExpire;
  bool? review;
  String? experineceId;

  AllowReview({
    this.requestSend,
    this.requestApproved,
    this.requestExpire,
    this.review,
    this.experineceId,
  });

  factory AllowReview.fromJson(Map<String, dynamic> json) => AllowReview(
    requestSend: json["requestSend"],
    requestApproved: json["requestApproved"],
    requestExpire: json["requestExpire"],
    review: json["review"],
    experineceId: json["experinece_id"],
  );

  Map<String, dynamic> toJson() => {
    "requestSend": requestSend,
    "requestApproved": requestApproved,
    "requestExpire": requestExpire,
    "review": review,
    "experinece_id": experineceId,
  };
}

class EmployementHistoryNew {
  String? id;
  dynamic companyLogo;
  String? company;
  String? companyId;
  DateTime? joiningDate;
  String? workedTillDate;
  int? claimStatus;
  bool? addedBy;
  String? approved;
  String? companySlug;
  String? userSlug;
  int? showSalaryStatus;
  int? totalExperienceMonths;
  List<ListElement>? lists;
  int? stillWorking;

  EmployementHistoryNew({
    this.id,
    this.companyLogo,
    this.company,
    this.companyId,
    this.joiningDate,
    this.workedTillDate,
    this.claimStatus,
    this.addedBy,
    this.approved,
    this.companySlug,
    this.userSlug,
    this.showSalaryStatus,
    this.totalExperienceMonths,
    this.lists,
    this.stillWorking,
  });

  factory EmployementHistoryNew.fromJson(Map<String, dynamic> json) => EmployementHistoryNew(
    id: json["id"],
    companyLogo: json["company_logo"],
    company: json["company"],
    companyId: json["company_id"],
    joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
    workedTillDate: json["worked_till_date"],
    claimStatus: json["claim_status"],
    addedBy: json["added_by"],
    approved: json["approved"],
    companySlug: json["company_slug"],
    userSlug: json["user_slug"],
    showSalaryStatus: json["showSalaryStatus"],
    totalExperienceMonths: json["totalExperienceMonths"],
    lists: json["lists"] == null ? [] : List<ListElement>.from(json["lists"]!.map((x) => ListElement.fromJson(x))),
    stillWorking: json["still_working"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_logo": companyLogo,
    "company": company,
    "company_id": companyId,
    "joining_date": "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
    "worked_till_date": workedTillDate,
    "claim_status": claimStatus,
    "added_by": addedBy,
    "approved": approved,
    "company_slug": companySlug,
    "user_slug": userSlug,
    "showSalaryStatus": showSalaryStatus,
    "totalExperienceMonths": totalExperienceMonths,
    "lists": lists == null ? [] : List<dynamic>.from(lists!.map((x) => x.toJson())),
    "still_working": stillWorking,
  };
}

class ListElement {
  String? id;
  bool? haveSalary;
  bool? haveDocument;
  bool? haveReview;
  String? employmentType;
  String? designation;
  DateTime? joiningDate;
  DateTime? workedTillDate;
  String? stillWorking;
  String? approved;
  String? description;
  String? salaryInhand;
  String? salaryMode;
  String? department;
  int? claimStatus;
  String? companySlug;
  List<Skill>? skill;
  bool? addedBy;
  String? employmentStatus;
  List<dynamic>? basicUpdateList;
  List<dynamic>? rating;
  TotalRating? totalRating;
  String? status;

  ListElement({
    this.id,
    this.haveSalary,
    this.haveDocument,
    this.haveReview,
    this.employmentType,
    this.designation,
    this.joiningDate,
    this.workedTillDate,
    this.stillWorking,
    this.approved,
    this.description,
    this.salaryInhand,
    this.salaryMode,
    this.department,
    this.claimStatus,
    this.companySlug,
    this.skill,
    this.addedBy,
    this.employmentStatus,
    this.basicUpdateList,
    this.rating,
    this.totalRating,
    this.status,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    haveSalary: json["haveSalary"],
    haveDocument: json["haveDocument"],
    haveReview: json["haveReview"],
    employmentType: json["employment_type"],
    designation: json["designation"],
    joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
    workedTillDate: json["worked_till_date"] == null ? null : DateTime.parse(json["worked_till_date"]),
    stillWorking: json["still_working"],
    approved: json["approved"],
    description: json["description"],
    salaryInhand: json["salary_inhand"],
    salaryMode: json["salary_mode"],
    department: json["department"],
    claimStatus: json["claim_status"],
    companySlug: json["company_slug"],
    skill: json["skill"] == null ? [] : List<Skill>.from(json["skill"]!.map((x) => Skill.fromJson(x))),
    addedBy: json["added_by"],
    employmentStatus: json["employment_status"],
    basicUpdateList: json["basic_update_list"] == null ? [] : List<dynamic>.from(json["basic_update_list"]!.map((x) => x)),
    rating: json["rating"] == null ? [] : List<dynamic>.from(json["rating"]!.map((x) => x)),
    totalRating: json["totalRating"] == null ? null : TotalRating.fromJson(json["totalRating"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "haveSalary": haveSalary,
    "haveDocument": haveDocument,
    "haveReview": haveReview,
    "employment_type": employmentType,
    "designation": designation,
    "joining_date": "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
    "worked_till_date": "${workedTillDate!.year.toString().padLeft(4, '0')}-${workedTillDate!.month.toString().padLeft(2, '0')}-${workedTillDate!.day.toString().padLeft(2, '0')}",
    "still_working": stillWorking,
    "approved": approved,
    "description": description,
    "salary_inhand": salaryInhand,
    "salary_mode": salaryMode,
    "department": department,
    "claim_status": claimStatus,
    "company_slug": companySlug,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x.toJson())),
    "added_by": addedBy,
    "employment_status": employmentStatus,
    "basic_update_list": basicUpdateList == null ? [] : List<dynamic>.from(basicUpdateList!.map((x) => x)),
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
    "totalRating": totalRating?.toJson(),
    "status": status,
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

class TopCompany {
  String? id;
  String? profile;
  String? name;
  String? designationName;
  String? individualId;
  String? slug;
  String? cityName;
  String? stateName;
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
    designationName: json["designationName"],
    slug: json["slug"],
    cityName: json["city_name"],
    stateName: json["state_name"],
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
    "designationName": designationName,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "followData": followData?.toJson(),
    "following": following?.toJson(),
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
