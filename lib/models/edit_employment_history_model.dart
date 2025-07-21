

class EditEmploymentHistoryModel {
  bool? status;
  String? messages;
  Data? data;

  EditEmploymentHistoryModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EditEmploymentHistoryModel.fromJson(Map<String, dynamic> json) => EditEmploymentHistoryModel(
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
  String? id;
  dynamic companyLogo;
  String? company;
  String? companyId;
  String? userId;
  dynamic salary;
  String? employmentType;
  String? employmentName;
  String? designation;
  String? designationId;
  String? departmentId;
  String? joiningDate;
  String? workedTillDate;
  String? stillWorking;
  String? approved;
  String? description;
  String? salaryInhand;
  String? salaryMode;
  String? department;
  List<Skill>? skill;
  List<String>? document;
  List<dynamic>? rating;
  String? employmentStatus;
  int? claimStatus;
  bool? addedBy;

  Data({
    this.id,
    this.companyLogo,
    this.company,
    this.companyId,
    this.userId,
    this.salary,
    this.employmentType,
    this.employmentName,
    this.designation,
    this.designationId,
    this.departmentId,
    this.joiningDate,
    this.workedTillDate,
    this.stillWorking,
    this.approved,
    this.description,
    this.salaryInhand,
    this.salaryMode,
    this.department,
    this.skill,
    this.document,
    this.rating,
    this.employmentStatus,
    this.claimStatus,
    this.addedBy,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    companyLogo: json["company_logo"],
    company: json["company"],
    companyId: json["company_id"],
    userId: json["user_id"],
    salary: json["salary"],
    employmentType: json["employment_type"],
    employmentName: json["employment_name"],
    designation: json["designation"],
    designationId: json["designationId"],
    departmentId: json["departmentId"],
    joiningDate: json["joining_date"] ,
    workedTillDate: json["worked_till_date"] ,
    stillWorking: json["still_working"],
    approved: json["approved"],
    description: json["description"],
    salaryInhand: json["salary_inhand"],
    salaryMode: json["salary_mode"],
    department: json["department"],
    skill: json["skill"] == null ? [] : List<Skill>.from(json["skill"]!.map((x) => Skill.fromJson(x))),
    document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
    rating: json["rating"] == null ? [] : List<dynamic>.from(json["rating"]!.map((x) => x)),
    employmentStatus: json["employment_status"],
    claimStatus: json["claim_status"],
    addedBy: json["added_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_logo": companyLogo,
    "company": company,
    "company_id": companyId,
    "user_id": userId,
    "salary": salary,
    "employment_type": employmentType,
    "employment_name": employmentName,
    "designation": designation,
    "designationId": designationId,
    "departmentId": departmentId,
    "joining_date": joiningDate,
    "worked_till_date": workedTillDate,
    "still_working": stillWorking,
    "approved": approved,
    "description": description,
    "salary_inhand": salaryInhand,
    "salary_mode": salaryMode,
    "department": department,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x.toJson())),
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
    "employment_status": employmentStatus,
    "claim_status": claimStatus,
    "added_by": addedBy,
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
