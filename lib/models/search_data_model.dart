

class SearchDataListModel {
  bool? status;
  String? messages;
  Data? data;

  SearchDataListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory SearchDataListModel.fromJson(Map<String, dynamic> json) => SearchDataListModel(
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
  List<UserList>? userList;
  List<CompanyList>? companyList;
  int? companyListCount;
  int? userListCount;
  List<JobList>? jobList;
  int? jobListCount;
  List<dynamic>? filterName;

  Data({
    this.userList,
    this.companyList,
    this.companyListCount,
    this.userListCount,
    this.jobList,
    this.jobListCount,
    this.filterName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userList: json["userList"] == null ? [] : List<UserList>.from(json["userList"]!.map((x) => UserList.fromJson(x))),
    companyList: json["companyList"] == null ? [] : List<CompanyList>.from(json["companyList"]!.map((x) => CompanyList.fromJson(x))),
    companyListCount: json["companyListCount"],
    userListCount: json["userListCount"],
    jobList: json["jobList"] == null ? [] : List<JobList>.from(json["jobList"]!.map((x) => JobList.fromJson(x))),
    jobListCount: json["jobListCount"],
    filterName: json["filterName"] == null ? [] : List<dynamic>.from(json["filterName"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userList": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x.toJson())),
    "companyList": companyList == null ? [] : List<dynamic>.from(companyList!.map((x) => x.toJson())),
    "companyListCount": companyListCount,
    "userListCount": userListCount,
    "jobList": jobList == null ? [] : List<dynamic>.from(jobList!.map((x) => x.toJson())),
    "jobListCount": jobListCount,
    "filterName": filterName == null ? [] : List<dynamic>.from(filterName!.map((x) => x)),
  };
}

class JobList {
  String? jobTitle;
  String? individualId;
  String? profile;
  String? slug;
  bool? isApply;
  String? cityName;
  String? stateName;
  String? countryName;
  String? industryName;
  String? designationName;
  String? companyName;
  String? departmentName;
  String? experienceName;
  String? roleTypeName;
  String? jobModeName;
  String? createDate;
  String? salaryName;
  String? vacancy;
  String? urgent;
  List<Skill>? skill;



  JobList({
    this.jobTitle,
    this.individualId,
    this.profile,
    this.slug,
    this.isApply,
    this.cityName,
    this.stateName,
    this.countryName,
    this.industryName,
    this.designationName,
    this.companyName,
    this.departmentName,
    this.experienceName,
    this.roleTypeName,
    this.jobModeName,
    this.createDate,
    this.vacancy,
    this.urgent,
    this.skill,
    this.salaryName
  });

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
    jobTitle: json["job_title"],
    individualId: json["individual_id"],
    profile: json["profile"],
    slug: json["slug"],
    isApply: json["apply"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    salaryName: json.containsKey("salary_name") && json["salary_name"] != null
        ? json["salary_name"]
        : "",
    countryName: json["country_name"],
    industryName: json["industry_name"],
    designationName: json["designation_name"],
    companyName: json["company_name"],
    departmentName: json["department_name"],
    experienceName: json["experience_name"],
    roleTypeName: json["role_type_name"],
    jobModeName: json["job_mode_name"],
    createDate: json["create_date"] ,
    vacancy: json["vacancy"],
    urgent: json["urgent"],
    skill: json["skill"] == null ? [] : List<Skill>.from(json["skill"]!.map((x) => Skill.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "job_title": jobTitle,
    "individual_id": individualId,
    "profile": profile,
    "slug": slug,
    "apply":isApply,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "industry_name": industryName,
    "salary_name": salaryName?.isNotEmpty == true ? salaryName : null,
    "designation_name": designationName,
    "company_name": companyName,
    "department_name": departmentName,
    "experience_name": experienceName,
    "role_type_name": roleTypeName,
    "job_mode_name": jobModeName,
    "create_date": createDate,
    "vacancy": vacancy,
    "urgent": urgent,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x.toJson())),
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
class UserList {
  String? id;
  String? individualId;
  String? fname;
  dynamic profile;
  String? slug;
  dynamic cityName;
  dynamic stateName;
  dynamic countryName;
  dynamic workStatus;
  dynamic designationName;
  dynamic companyName;
  dynamic departmentName;
  dynamic accomodationName;
  dynamic employmentTypeName;
  dynamic universityName;
  dynamic courseName;
  dynamic courseTypeName;
  String? email;
  String? phone;
  String? userRating;
  String? ratingCount;

  UserList({
    this.id,
    this.individualId,
    this.fname,
    this.profile,
    this.slug,
    this.cityName,
    this.stateName,
    this.countryName,
    this.workStatus,
    this.designationName,
    this.companyName,
    this.departmentName,
    this.accomodationName,
    this.employmentTypeName,
    this.universityName,
    this.courseName,
    this.courseTypeName,
    this.email,
    this.phone,
    this.userRating,
    this.ratingCount,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    id: json["id"],
    individualId: json["individual_id"],
    fname: json["fname"],
    profile: json["profile"],
    slug: json["slug"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    workStatus: json["work_status"],
    designationName: json["designation_name"],
    companyName: json["company_name"],
    departmentName: json["department_name"],
    accomodationName: json["accomodation_name"],
    employmentTypeName: json["employment_type_name"],
    universityName: json["university_name"],
    courseName: json["course_name"],
    courseTypeName: json["course_type_name"],
    email: json["email"],
    phone: json["phone"],
    userRating: json["userRating"],
    ratingCount: json["ratingCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "fname": fname,
    "profile": profile,
    "slug": slug,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "work_status": workStatus,
    "designation_name": designationName,
    "company_name": companyName,
    "department_name": departmentName,
    "accomodation_name": accomodationName,
    "employment_type_name": employmentTypeName,
    "university_name": universityName,
    "course_name": courseName,
    "course_type_name": courseTypeName,
    "email": email,
    "phone": phone,
    "userRating": userRating,
    "ratingCount": ratingCount,
  };
}


class CompanyList {
  String? id;
  String? individualId;
  String? fname;
  String? profile;
  String? slug;
  dynamic cityName;
  dynamic stateName;
  dynamic countryName;
  String? industryName;
  String? turnover;
  String? website;
  String? incorporateDate;
  String? contactPerson;

  CompanyList({
    this.id,
    this.individualId,
    this.fname,
    this.profile,
    this.slug,
    this.cityName,
    this.stateName,
    this.countryName,
    this.industryName,
    this.turnover,
    this.website,
    this.incorporateDate,
    this.contactPerson,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["id"],
    individualId: json["individual_id"],
    fname: json["fname"],
    profile: json["profile"],
    slug: json["slug"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    industryName: json["industry_name"],
    turnover: json["turnover"],
    website: json["website"],
    incorporateDate: json["incorporate_date"],
    contactPerson: json["contact_person"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "fname": fname,
    "profile": profile,
    "slug": slug,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "industry_name": industryName,
    "turnover": turnover,
    "website": website,
    "incorporate_date": incorporateDate,
    "contact_person": contactPerson,
  };
}