

class AppliedJobDataModel {
  bool? status;
  Data? data;

  AppliedJobDataModel({
    this.status,
    this.data,
  });

  factory AppliedJobDataModel.fromJson(Map<String, dynamic> json) => AppliedJobDataModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  List<JobsApplied>? jobsApplieds;

  Data({
    this.jobsApplieds,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    jobsApplieds: json["jobsApplieds"] == null ? [] : List<JobsApplied>.from(json["jobsApplieds"]!.map((x) => JobsApplied.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "jobsApplieds": jobsApplieds == null ? [] : List<dynamic>.from(jobsApplieds!.map((x) => x.toJson())),
  };
}

class JobsApplied {
  String? id;
  String? job;
  String? user;
  DateTime? createDate;
  String? jobTitle;
  String? slug;
  String? fname;
  dynamic profile;
  dynamic cityName;
  dynamic stateName;
  dynamic countryName;
  dynamic industryName;
  dynamic departmentName;
  String? experienceName;
  String? roleTypeName;
  dynamic designationName;
  dynamic salaryName;
  String? jobModeName;
  String? jobStatus;

  JobsApplied({
    this.id,
    this.job,
    this.user,
    this.createDate,
    this.jobTitle,
    this.slug,
    this.fname,
    this.profile,
    this.cityName,
    this.stateName,
    this.countryName,
    this.industryName,
    this.departmentName,
    this.experienceName,
    this.roleTypeName,
    this.designationName,
    this.salaryName,
    this.jobModeName,
    this.jobStatus,
  });

  factory JobsApplied.fromJson(Map<String, dynamic> json) => JobsApplied(
    id: json["id"],
    job: json["job"],
    user: json["user"],
    createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
    jobTitle: json["job_title"],
    slug: json["slug"],
    fname: json["fname"],
    profile: json["profile"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    industryName: json["industry_name"],
    departmentName: json["department_name"],
    experienceName: json["experience_name"],
    roleTypeName: json["role_type_name"],
    designationName: json["designation_name"],
    salaryName: json["salary_name"],
    jobModeName: json["job_mode_name"],
    jobStatus: json["job_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job": job,
    "user": user,
    "create_date": createDate?.toIso8601String(),
    "job_title": jobTitle,
    "slug": slug,
    "fname": fname,
    "profile": profile,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "industry_name": industryName,
    "department_name": departmentName,
    "experience_name": experienceName,
    "role_type_name": roleTypeName,
    "designation_name": designationName,
    "salary_name": salaryName,
    "job_mode_name": jobModeName,
    "job_status": jobStatus,
  };
}
