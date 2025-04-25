
class DashboardStaticsDetailsModel {
  bool? status;
  Data? data;

  DashboardStaticsDetailsModel({
    this.status,
    this.data,
  });

  factory DashboardStaticsDetailsModel.fromJson(Map<String, dynamic> json) => DashboardStaticsDetailsModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? postedJobs;
  int? applications;
  int? currentEmployies;
  List<dynamic>? followRequests;
  int? messages;
  List<dynamic>? followList;
  List<EmployementRequestList>? employementRequestList;
  Percentage? percentage;
  List<AllApplicationList>? allApplicationList;
  List<MostAppliedJob>? mostAppliedJob;
  List<dynamic>? pendingReviewsList;
  List<RecommendedEmployee>? recommendedEmployees;
  List<RecentJoinList>? recentJoinList;

  Data({
    this.postedJobs,
    this.applications,
    this.currentEmployies,
    this.followRequests,
    this.messages,
    this.followList,
    this.employementRequestList,
    this.percentage,
    this.allApplicationList,
    this.mostAppliedJob,
    this.pendingReviewsList,
    this.recommendedEmployees,
    this.recentJoinList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    postedJobs: json["postedJobs"],
    applications: json["applications"],
    currentEmployies: json["currentEmployies"],
    followRequests: json["followRequests"] == null ? [] : List<dynamic>.from(json["followRequests"]!.map((x) => x)),
    messages: json["messages"],
    followList: json["followList"] == null ? [] : List<dynamic>.from(json["followList"]!.map((x) => x)),
    employementRequestList: json["employementRequestList"] == null ? [] : List<EmployementRequestList>.from(json["employementRequestList"]!.map((x) => EmployementRequestList.fromJson(x))),
    percentage: json["percentage"] == null ? null : Percentage.fromJson(json["percentage"]),
    allApplicationList: json["allApplicationList"] == null ? [] : List<AllApplicationList>.from(json["allApplicationList"]!.map((x) => AllApplicationList.fromJson(x))),
    mostAppliedJob: json["mostAppliedJob"] == null ? [] : List<MostAppliedJob>.from(json["mostAppliedJob"]!.map((x) => MostAppliedJob.fromJson(x))),
    pendingReviewsList: json["pendingReviewsList"] == null ? [] : List<dynamic>.from(json["pendingReviewsList"]!.map((x) => x)),
    recommendedEmployees: json["recommendedEmployees"] == null ? [] : List<RecommendedEmployee>.from(json["recommendedEmployees"]!.map((x) => RecommendedEmployee.fromJson(x))),
    recentJoinList: json["recentJoinList"] == null ? [] : List<RecentJoinList>.from(json["recentJoinList"]!.map((x) => RecentJoinList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postedJobs": postedJobs,
    "applications": applications,
    "currentEmployies": currentEmployies,
    "followRequests": followRequests == null ? [] : List<dynamic>.from(followRequests!.map((x) => x)),
    "messages": messages,
    "followList": followList == null ? [] : List<dynamic>.from(followList!.map((x) => x)),
    "employementRequestList": employementRequestList == null ? [] : List<dynamic>.from(employementRequestList!.map((x) => x.toJson())),
    "percentage": percentage?.toJson(),
    "allApplicationList": allApplicationList == null ? [] : List<dynamic>.from(allApplicationList!.map((x) => x.toJson())),
    "mostAppliedJob": mostAppliedJob == null ? [] : List<dynamic>.from(mostAppliedJob!.map((x) => x.toJson())),
    "pendingReviewsList": pendingReviewsList == null ? [] : List<dynamic>.from(pendingReviewsList!.map((x) => x)),
    "recommendedEmployees": recommendedEmployees == null ? [] : List<dynamic>.from(recommendedEmployees!.map((x) => x.toJson())),
    "recentJoinList": recentJoinList == null ? [] : List<dynamic>.from(recentJoinList!.map((x) => x.toJson())),
  };
}
class MostAppliedJob {
  String? applicants;
  String? jobTitle;
  String? id;
  String? modifyDate;

  MostAppliedJob({
    this.applicants,
    this.jobTitle,
    this.id,
    this.modifyDate,
  });

  factory MostAppliedJob.fromJson(Map<String, dynamic> json) => MostAppliedJob(
    applicants: json["applicants"],
    jobTitle: json["job_title"],
    id: json["id"],
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "applicants": applicants,
    "job_title": jobTitle,
    "id": id,
    "modify_date": modifyDate,
  };
}

class AllApplicationList {
  String? id;
  String? job;
  String? userId;
  String? individualId;
  String? name;
  String? email;
  String? phone;
  dynamic cityName;
  dynamic stateName;
  dynamic countryName;
  String? profile;
  String? slug;
  String? companyName;
  String? designationName;
  dynamic presentAddress;
  String? profileDescription;
  String? date;
  String? resume;
  dynamic resumeName;
  dynamic expectedSalary;
  dynamic noticePeriod;
  String? onNotice;
  String? onImmediate;
  dynamic noticeDate;
  Rating? rating;

  AllApplicationList({
    this.id,
    this.job,
    this.userId,
    this.individualId,
    this.name,
    this.email,
    this.phone,
    this.cityName,
    this.stateName,
    this.countryName,
    this.profile,
    this.slug,
    this.companyName,
    this.designationName,
    this.presentAddress,
    this.profileDescription,
    this.date,
    this.resume,
    this.resumeName,
    this.expectedSalary,
    this.noticePeriod,
    this.onNotice,
    this.onImmediate,
    this.noticeDate,
    this.rating,
  });

  factory AllApplicationList.fromJson(Map<String, dynamic> json) => AllApplicationList(
    id: json["id"],
    job: json["job"],
    userId: json["user_id"],
    individualId: json["individual_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    profile: json["profile"],
    slug: json["slug"],
    companyName: json["company_name"],
    designationName: json["designation_name"],
    presentAddress: json["present_address"],
    profileDescription: json["profile_description"],
    date: json["date"],
    resume: json["resume"],
    resumeName: json["resumeName"],
    expectedSalary: json["expected_salary"],
    noticePeriod: json["notice_period"],
    onNotice: json["on_notice"],
    onImmediate: json["on_immediate"],
    noticeDate: json["notice_date"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job": job,
    "user_id": userId,
    "individual_id": individualId,
    "name": name,
    "email": email,
    "phone": phone,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "profile": profile,
    "slug": slug,
    "company_name": companyName,
    "designation_name": designationName,
    "present_address": presentAddress,
    "profile_description": profileDescription,
    "date": date,
    "resume": resume,
    "resumeName": resumeName,
    "expected_salary": expectedSalary,
    "notice_period": noticePeriod,
    "on_notice": onNotice,
    "on_immediate": onImmediate,
    "notice_date": noticeDate,
    "rating": rating?.toJson(),
  };
}
class Rating {
  int? rating;
  int? noofrecord;

  Rating({
    this.rating,
    this.noofrecord,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rating: json["rating"],
    noofrecord: json["noofrecord"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "noofrecord": noofrecord,
  };
}
class EmployementRequestList {
  String? id;
  String? profile;
  String? userName;
  String? salary;
  String? employmentType;
  String? designation;
  String? joiningDate;
  String? workedTillDate;
  String? stillWorking;
  String? approved;
  List<String>? skill;
  String? description;
  List<String>? document;
  String? salaryInhand;
  String? salaryMode;
  String? department;
  int? claimStatus;
  List<dynamic>? rating;
  String? employmentStatus;
  String? employementId;
  String? slug;
  String? individualId;
  String? status;
  bool? isVerified;
  String? userSlug;
  List<dynamic>? updateHistory;

  EmployementRequestList({
    this.id,
    this.profile,
    this.userName,
    this.salary,
    this.employmentType,
    this.designation,
    this.joiningDate,
    this.workedTillDate,
    this.stillWorking,
    this.approved,
    this.skill,
    this.description,
    this.document,
    this.salaryInhand,
    this.salaryMode,
    this.department,
    this.claimStatus,
    this.rating,
    this.employmentStatus,
    this.employementId,
    this.slug,
    this.individualId,
    this.status,
    this.isVerified,
    this.userSlug,
    this.updateHistory,
  });

  factory EmployementRequestList.fromJson(Map<String, dynamic> json) => EmployementRequestList(
    id: json["id"],
    profile: json["profile"],
    userName: json["userName"],
    salary: json["salary"],
    employmentType: json["employment_type"],
    designation: json["designation"],
    joiningDate: json["joining_date"],
    workedTillDate: json["worked_till_date"],
    stillWorking: json["still_working"],
    approved: json["approved"],
    skill: json["skill"] == null ? [] : List<String>.from(json["skill"]!.map((x) => x)),
    description: json["description"],
    document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
    salaryInhand: json["salary_inhand"],
    salaryMode: json["salary_mode"],
    department: json["department"],
    claimStatus: json["claim_status"],
    rating: json["rating"] == null ? [] : List<dynamic>.from(json["rating"]!.map((x) => x)),
    employmentStatus: json["employment_status"],
    employementId: json["employement_id"],
    slug: json["slug"],
    individualId: json["individual_id"],
    status: json["status"],
    isVerified: json["is_verified"],
    userSlug: json["user_slug"],
    updateHistory: json["updateHistory"] == null ? [] : List<dynamic>.from(json["updateHistory"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "userName": userName,
    "salary": salary,
    "employment_type": employmentType,
    "designation": designation,
    "joining_date": joiningDate,//"${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
    "worked_till_date": workedTillDate,//"${workedTillDate!.year.toString().padLeft(4, '0')}-${workedTillDate!.month.toString().padLeft(2, '0')}-${workedTillDate!.day.toString().padLeft(2, '0')}",
    "still_working": stillWorking,
    "approved": approved,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
    "description": description,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
    "salary_inhand": salaryInhand,
    "salary_mode": salaryMode,
    "department": department,
    "claim_status": claimStatus,
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
    "employment_status": employmentStatus,
    "employement_id": employementId,
    "slug": slug,
    "individual_id": individualId,
    "status": status,
    "is_verified": isVerified,
    "user_slug": userSlug,
    "updateHistory": updateHistory == null ? [] : List<dynamic>.from(updateHistory!.map((x) => x)),
  };
}

class Percentage {
  int? total;
  List<String>? uncomplete;
  Complete? complete;

  Percentage({
    this.total,
    this.uncomplete,
    this.complete,
  });

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
    total: json["total"],
    uncomplete: json["uncomplete"] == null ? [] : List<String>.from(json["uncomplete"]!.map((x) => x)),
    complete: json["complete"] == null ? null : Complete.fromJson(json["complete"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "uncomplete": uncomplete == null ? [] : List<dynamic>.from(uncomplete!.map((x) => x)),
    "complete": complete?.toJson(),
  };
}

class Complete {
  String? companyName;
  String? email;
  String? phone;
  String? phoneVerified;
  String? contactPerson;
  String? incorporateDate;
  String? industry;
  String? addEmployee;
  String? review;
  String? gallery;
  String? perk;
  String? employeeCount;

  Complete({
    this.companyName,
    this.email,
    this.phone,
    this.phoneVerified,
    this.contactPerson,
    this.incorporateDate,
    this.industry,
    this.addEmployee,
    this.review,
    this.gallery,
    this.perk,
    this.employeeCount,
  });

  factory Complete.fromJson(Map<String, dynamic> json) => Complete(
    companyName: json["company_name"],
    email: json["email"],
    phone: json["phone"],
    phoneVerified: json["phone_verified"],
    contactPerson: json["contact_person"],
    incorporateDate: json["incorporate_date"],
    industry: json["industry"],
    addEmployee: json["add_employee"],
    review: json["review"],
    gallery: json["gallery"],
    perk: json["perk"],
    employeeCount: json["employee_count"],
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "email": email,
    "phone": phone,
    "phone_verified": phoneVerified,
    "contact_person": contactPerson,
    "incorporate_date": incorporateDate,
    "industry": industry,
    "add_employee": addEmployee,
    "review": review,
    "gallery": gallery,
    "perk": perk,
    "employee_count": employeeCount,
  };
}

class RecentJoinList {
  String? experienceId;
  String? individualId;
  String? name;
  String? profile;
  String? userSlug;
  String? employementName;
  String? designationName;
  String? departmentName;
  String? slug;

  RecentJoinList({
    this.experienceId,
    this.individualId,
    this.name,
    this.profile,
    this.userSlug,
    this.employementName,
    this.designationName,
    this.departmentName,
    this.slug,
  });

  factory RecentJoinList.fromJson(Map<String, dynamic> json) => RecentJoinList(
    experienceId: json["experienceId"],
    individualId: json["individual_id"],
    name: json["name"],
    profile: json["profile"],
    userSlug: json["user_slug"],
    employementName: json["employement_name"],
    designationName: json["designation_name"],
    departmentName: json["department_name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "experienceId": experienceId,
    "individual_id": individualId,
    "name": name,
    "profile": profile,
    "user_slug": userSlug,
    "employement_name": employementName,
    "designation_name": designationName,
    "department_name": departmentName,
    "slug": slug,
  };
}

class RecommendedEmployee {
  String? id;
  String? individualId;
  dynamic totalRating;
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

  RecommendedEmployee({
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
  });

  factory RecommendedEmployee.fromJson(Map<String, dynamic> json) => RecommendedEmployee(
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
