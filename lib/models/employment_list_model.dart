
class DesignationListModel {
  bool? status;
  String? messages;
  Data? data;

  DesignationListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory DesignationListModel.fromJson(Map<String, dynamic> json) => DesignationListModel(
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
  List<DepartmentListElement>? designationList;
  List<DepartmentListElement>? departmentList;
  List<DepartmentListElement>? salaryList;
  List<CompanyList>? companyList;
  List<UserList>? userList;
  List<DepartmentListElement>? skillList;
  List<DepartmentListElement>? employementTypeList;

  Data({
    this.designationList,
    this.departmentList,
    this.salaryList,
    this.companyList,
    this.userList,
    this.skillList,
    this.employementTypeList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    designationList: json["designationList"] == null ? [] : List<DepartmentListElement>.from(json["designationList"]!.map((x) => DepartmentListElement.fromJson(x))),
    departmentList: json["departmentList"] == null ? [] : List<DepartmentListElement>.from(json["departmentList"]!.map((x) => DepartmentListElement.fromJson(x))),
    salaryList: json["salaryList"] == null ? [] : List<DepartmentListElement>.from(json["salaryList"]!.map((x) => DepartmentListElement.fromJson(x))),
    companyList: json["companyList"] == null ? [] : List<CompanyList>.from(json["companyList"]!.map((x) => CompanyList.fromJson(x))),
    userList: json["userList"] == null ? [] : List<UserList>.from(json["userList"]!.map((x) => UserList.fromJson(x))),
    skillList: json["skillList"] == null ? [] : List<DepartmentListElement>.from(json["skillList"]!.map((x) => DepartmentListElement.fromJson(x))),
    employementTypeList: json["employementTypeList"] == null ? [] : List<DepartmentListElement>.from(json["employementTypeList"]!.map((x) => DepartmentListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "designationList": designationList == null ? [] : List<dynamic>.from(designationList!.map((x) => x.toJson())),
    "departmentList": departmentList == null ? [] : List<dynamic>.from(departmentList!.map((x) => x.toJson())),
    "salaryList": salaryList == null ? [] : List<dynamic>.from(salaryList!.map((x) => x.toJson())),
    "companyList": companyList == null ? [] : List<dynamic>.from(companyList!.map((x) => x.toJson())),
    "userList": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x.toJson())),
    "skillList": skillList == null ? [] : List<dynamic>.from(skillList!.map((x) => x.toJson())),
    "employementTypeList": employementTypeList == null ? [] : List<dynamic>.from(employementTypeList!.map((x) => x.toJson())),
  };
}

class CompanyList {
  String? id;
  String? individualId;
  String? companyLogo;
  String? company;
  String? contactPerson;

  CompanyList({
    this.id,
    this.individualId,
    this.companyLogo,
    this.company,
    this.contactPerson,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["id"],
    individualId: json["individual_id"],
    companyLogo: json["company_logo"],
    company: json["company"],
    contactPerson: json["contact_person"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "company_logo": companyLogo,
    "company": company,
    "contact_person": contactPerson,
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

class UserList {
  String? id;
  String? individualId;
  String? profile;
  String? name;

  UserList({
    this.id,
    this.individualId,
    this.profile,
    this.name,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    id: json["id"],
    individualId: json["individual_id"],
    profile: json["profile"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "profile": profile,
    "name": name,
  };
}
