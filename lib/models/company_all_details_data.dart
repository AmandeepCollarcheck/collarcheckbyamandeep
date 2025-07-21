
class CompanyAllDetailsData {
  bool? status;
  String? messages;
  Data? data;

  CompanyAllDetailsData({
    this.status,
    this.messages,
    this.data,
  });

  factory CompanyAllDetailsData.fromJson(Map<String, dynamic> json) => CompanyAllDetailsData(
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
  List<CountryListElement>? industryList;
  List<CountryListElement>? roleTypeList;
  List<CountryListElement>? salaryList;
  List<CountryListElement>? departmentList;
  List<CountryListElement>? jobExperienceList;
  List<CountryListElement>? skillList;
  List<CountryListElement>? jobModeList;
  List<CountryListElement>? designationList;
  List<CountryListElement>? countryList;

  Data({
    this.industryList,
    this.roleTypeList,
    this.salaryList,
    this.departmentList,
    this.jobExperienceList,
    this.skillList,
    this.jobModeList,
    this.designationList,
    this.countryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    industryList: json["industryList"] == null ? [] : List<CountryListElement>.from(json["industryList"]!.map((x) => CountryListElement.fromJson(x))),
    roleTypeList: json["roleTypeList"] == null ? [] : List<CountryListElement>.from(json["roleTypeList"]!.map((x) => CountryListElement.fromJson(x))),
    salaryList: json["salaryList"] == null ? [] : List<CountryListElement>.from(json["salaryList"]!.map((x) => CountryListElement.fromJson(x))),
    departmentList: json["departmentList"] == null ? [] : List<CountryListElement>.from(json["departmentList"]!.map((x) => CountryListElement.fromJson(x))),
    jobExperienceList: json["jobExperienceList"] == null ? [] : List<CountryListElement>.from(json["jobExperienceList"]!.map((x) => CountryListElement.fromJson(x))),
    skillList: json["skillList"] == null ? [] : List<CountryListElement>.from(json["skillList"]!.map((x) => CountryListElement.fromJson(x))),
    jobModeList: json["jobModeList"] == null ? [] : List<CountryListElement>.from(json["jobModeList"]!.map((x) => CountryListElement.fromJson(x))),
    designationList: json["designationList"] == null ? [] : List<CountryListElement>.from(json["designationList"]!.map((x) => CountryListElement.fromJson(x))),
    countryList: json["countryList"] == null ? [] : List<CountryListElement>.from(json["countryList"]!.map((x) => CountryListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "industryList": industryList == null ? [] : List<dynamic>.from(industryList!.map((x) => x.toJson())),
    "roleTypeList": roleTypeList == null ? [] : List<dynamic>.from(roleTypeList!.map((x) => x.toJson())),
    "salaryList": salaryList == null ? [] : List<dynamic>.from(salaryList!.map((x) => x.toJson())),
    "departmentList": departmentList == null ? [] : List<dynamic>.from(departmentList!.map((x) => x.toJson())),
    "jobExperienceList": jobExperienceList == null ? [] : List<dynamic>.from(jobExperienceList!.map((x) => x.toJson())),
    "skillList": skillList == null ? [] : List<dynamic>.from(skillList!.map((x) => x.toJson())),
    "jobModeList": jobModeList == null ? [] : List<dynamic>.from(jobModeList!.map((x) => x.toJson())),
    "designationList": designationList == null ? [] : List<dynamic>.from(designationList!.map((x) => x.toJson())),
    "countryList": countryList == null ? [] : List<dynamic>.from(countryList!.map((x) => x.toJson())),
  };
}

class CountryListElement {
  String? id;
  String? name;

  CountryListElement({
    this.id,
    this.name,
  });

  factory CountryListElement.fromJson(Map<String, dynamic> json) => CountryListElement(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
