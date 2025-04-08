

class CompanyJobListModel {
  bool? status;
  String? messages;
  Data? data;

  CompanyJobListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory CompanyJobListModel.fromJson(Map<String, dynamic> json) => CompanyJobListModel(
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
  List<DraftJob>? draftJobs;
  List<dynamic>? publishJobs;
  List<dynamic>? cancelJobs;

  Data({
    this.draftJobs,
    this.publishJobs,
    this.cancelJobs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    draftJobs: json["draftJobs"] == null ? [] : List<DraftJob>.from(json["draftJobs"]!.map((x) => DraftJob.fromJson(x))),
    publishJobs: json["publishJobs"] == null ? [] : List<dynamic>.from(json["publishJobs"]!.map((x) => x)),
    cancelJobs: json["cancelJobs"] == null ? [] : List<dynamic>.from(json["cancelJobs"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "draftJobs": draftJobs == null ? [] : List<dynamic>.from(draftJobs!.map((x) => x.toJson())),
    "publishJobs": publishJobs == null ? [] : List<dynamic>.from(publishJobs!.map((x) => x)),
    "cancelJobs": cancelJobs == null ? [] : List<dynamic>.from(cancelJobs!.map((x) => x)),
  };
}

class DraftJob {
  String? id;
  String? individualId;
  String? jobTitle;
  String? jobDescription;
  String? rolesResponsibility;
  String? departmentName;
  String? experienceName;
  String? department;
  String? experience;
  List<dynamic>? skill;
  dynamic roleTypeName;
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
  dynamic city;
  String? jobMode;
  String? document;
  dynamic cityName;
  String? salary;
  String? salaryName;
  String? companyName;
  dynamic profile;
  String? createDate;
  String? applicationCount;
  String? status;
  String? slug;
  List<dynamic>? gallery;
  String? companySlug;
  bool? apply;

  DraftJob({
    this.id,
    this.individualId,
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

  factory DraftJob.fromJson(Map<String, dynamic> json) => DraftJob(
    id: json["id"],
    individualId: json["individual_id"],
    jobTitle: json["job_title"],
    jobDescription: json["job_description"],
    rolesResponsibility: json["roles_responsibility"],
    departmentName: json["department_name"],
    experienceName: json["experience_name"],
    department: json["department"],
    experience: json["experience"],
    skill: json["skill"] == null ? [] : List<dynamic>.from(json["skill"]!.map((x) => x)),
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
    createDate: json["create_date"],
    applicationCount: json["applicationCount"],
    status: json["status"],
    slug: json["slug"],
    gallery: json["gallery"] == null ? [] : List<dynamic>.from(json["gallery"]!.map((x) => x)),
    companySlug: json["company_slug"],
    apply: json["apply"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "job_title": jobTitle,
    "job_description": jobDescription,
    "roles_responsibility": rolesResponsibility,
    "department_name": departmentName,
    "experience_name": experienceName,
    "department": department,
    "experience": experience,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
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
