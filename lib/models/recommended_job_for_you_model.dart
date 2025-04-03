

class RecommendedJobForYouModel {
  bool? status;
  String? messages;
  Data? data;

  RecommendedJobForYouModel({
    this.status,
    this.messages,
    this.data,
  });

  factory RecommendedJobForYouModel.fromJson(Map<String, dynamic> json) => RecommendedJobForYouModel(
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
  List<AlljobList>? alljobList;
  int? filterApply;
  List<FilterName>? filterName;

  Data({
    this.alljobList,
    this.filterApply,
    this.filterName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    alljobList: json["alljobList"] == null ? [] : List<AlljobList>.from(json["alljobList"]!.map((x) => AlljobList.fromJson(x))),
    filterApply: json["filterApply"],
    filterName: _parseFilterName(json["filterName"]),
  );

  Map<String, dynamic> toJson() => {
    "alljobList": alljobList == null ? [] : List<dynamic>.from(alljobList!.map((x) => x.toJson())),
    "filterApply": filterApply,
    "filterName": filterName == null ? [] : List<dynamic>.from(filterName!.map((x) => x.toJson())),
  };

  // Handling dynamic filterName type
  static List<FilterName> _parseFilterName(dynamic json) {
    if (json == null) {
      return [];
    } else if (json is List) {
      return List<FilterName>.from(json.map((x) => FilterName.fromJson(x)));
    } else if (json is Map<String, dynamic>) {
      return [FilterName.fromJson(json)];
    } else {
      return [];
    }
  }
}

class AlljobList {
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

  AlljobList({
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

  factory AlljobList.fromJson(Map<String, dynamic> json) => AlljobList(
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
    createDate: json["create_date"],
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


class Company {
  String? id;
  String? name;

  Company({
    this.id,
    this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class FilterName {
  Company? company;

  FilterName({
    this.company,
  });

  factory FilterName.fromJson(Map<String, dynamic> json) => FilterName(
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "company": company?.toJson(),
  };
}

