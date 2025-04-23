
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
  List<dynamic>? employementRequestList;
  Percentage? percentage;
  List<dynamic>? allApplicationList;
  List<dynamic>? mostAppliedJob;
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
    employementRequestList: json["employementRequestList"] == null ? [] : List<dynamic>.from(json["employementRequestList"]!.map((x) => x)),
    percentage: json["percentage"] == null ? null : Percentage.fromJson(json["percentage"]),
    allApplicationList: json["allApplicationList"] == null ? [] : List<dynamic>.from(json["allApplicationList"]!.map((x) => x)),
    mostAppliedJob: json["mostAppliedJob"] == null ? [] : List<dynamic>.from(json["mostAppliedJob"]!.map((x) => x)),
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
    "employementRequestList": employementRequestList == null ? [] : List<dynamic>.from(employementRequestList!.map((x) => x)),
    "percentage": percentage?.toJson(),
    "allApplicationList": allApplicationList == null ? [] : List<dynamic>.from(allApplicationList!.map((x) => x)),
    "mostAppliedJob": mostAppliedJob == null ? [] : List<dynamic>.from(mostAppliedJob!.map((x) => x)),
    "pendingReviewsList": pendingReviewsList == null ? [] : List<dynamic>.from(pendingReviewsList!.map((x) => x)),
    "recommendedEmployees": recommendedEmployees == null ? [] : List<dynamic>.from(recommendedEmployees!.map((x) => x.toJson())),
    "recentJoinList": recentJoinList == null ? [] : List<dynamic>.from(recentJoinList!.map((x) => x.toJson())),
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
