

class FilterDataListModel {
  bool? status;
  String? messages;
  FilterData? data;

  FilterDataListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory FilterDataListModel.fromJson(Map<String, dynamic> json) => FilterDataListModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? null : FilterData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data?.toJson(),
  };
}

class FilterData {
  List<DepartmentListElement>? industryList;
  List<DepartmentListElement>? salaryList;
  List<DepartmentListElement>? roleTypeList;
  List<DepartmentListElement>? departmentList;
  List<DepartmentListElement>? jobExperienceList;
  List<DepartmentListElement>? skillList;
  List<DepartmentListElement>? jobModeList;
  List<DepartmentListElement>? designationList;
  List<CountryList>? countryList;
  List<CompanyList>? companyList;

  FilterData({
    this.industryList,
    this.salaryList,
    this.roleTypeList,
    this.departmentList,
    this.jobExperienceList,
    this.skillList,
    this.jobModeList,
    this.designationList,
    this.countryList,
    this.companyList,
  });

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    industryList: json["industryList"] == null ? [] : List<DepartmentListElement>.from(json["industryList"]!.map((x) => DepartmentListElement.fromJson(x))),
    salaryList: json["salaryList"] == null ? [] : List<DepartmentListElement>.from(json["salaryList"]!.map((x) => DepartmentListElement.fromJson(x))),
    roleTypeList: json["roleTypeList"] == null ? [] : List<DepartmentListElement>.from(json["roleTypeList"]!.map((x) => DepartmentListElement.fromJson(x))),
    departmentList: json["departmentList"] == null ? [] : List<DepartmentListElement>.from(json["departmentList"]!.map((x) => DepartmentListElement.fromJson(x))),
    jobExperienceList: json["jobExperienceList"] == null ? [] : List<DepartmentListElement>.from(json["jobExperienceList"]!.map((x) => DepartmentListElement.fromJson(x))),
    skillList: json["skillList"] == null ? [] : List<DepartmentListElement>.from(json["skillList"]!.map((x) => DepartmentListElement.fromJson(x))),
    jobModeList: json["jobModeList"] == null ? [] : List<DepartmentListElement>.from(json["jobModeList"]!.map((x) => DepartmentListElement.fromJson(x))),
    designationList: json["designationList"] == null ? [] : List<DepartmentListElement>.from(json["designationList"]!.map((x) => DepartmentListElement.fromJson(x))),
    countryList: json["countryList"] == null ? [] : List<CountryList>.from(json["countryList"]!.map((x) => CountryList.fromJson(x))),
    companyList: json["companyList"] == null ? [] : List<CompanyList>.from(json["companyList"]!.map((x) => CompanyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "industryList": industryList == null ? [] : List<dynamic>.from(industryList!.map((x) => x.toJson())),
    "salaryList": salaryList == null ? [] : List<dynamic>.from(salaryList!.map((x) => x.toJson())),
    "roleTypeList": roleTypeList == null ? [] : List<dynamic>.from(roleTypeList!.map((x) => x.toJson())),
    "departmentList": departmentList == null ? [] : List<dynamic>.from(departmentList!.map((x) => x.toJson())),
    "jobExperienceList": jobExperienceList == null ? [] : List<dynamic>.from(jobExperienceList!.map((x) => x.toJson())),
    "skillList": skillList == null ? [] : List<dynamic>.from(skillList!.map((x) => x.toJson())),
    "jobModeList": jobModeList == null ? [] : List<dynamic>.from(jobModeList!.map((x) => x.toJson())),
    "designationList": designationList == null ? [] : List<dynamic>.from(designationList!.map((x) => x.toJson())),
    "countryList": countryList == null ? [] : List<dynamic>.from(countryList!.map((x) => x.toJson())),
    "companyList": companyList == null ? [] : List<dynamic>.from(companyList!.map((x) => x.toJson())),
  };
}

class CompanyList {
  String? id;
  String? name;
  String? slug;

  CompanyList({
    this.id,
    this.name,
    this.slug,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class CountryList {
  String? id;
  String? name;
  String? phonecode;

  CountryList({
    this.id,
    this.name,
    this.phonecode,
  });

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
    id: json["id"],
    name: json["name"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phonecode": phonecode,
  };
}

class DepartmentListElement {
  String? id;
  String? name;

  DepartmentListElement({
    this.id,
    this.name,
  });

  factory DepartmentListElement.fromJson(Map<String, dynamic> json) => DepartmentListElement(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
