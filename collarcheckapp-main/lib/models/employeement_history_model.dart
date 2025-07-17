
class EmploymentHistoryModel {
  bool? status;
  String? messages;
  List<EmployeeMentHistoryDatum>? data;

  EmploymentHistoryModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EmploymentHistoryModel.fromJson(Map<String, dynamic> json) => EmploymentHistoryModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<EmployeeMentHistoryDatum>.from(json["data"]!.map((x) => EmployeeMentHistoryDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EmployeeMentHistoryDatum {
  String? id;
  dynamic companyLogo;
  String? company;
  String? companyId;
  String? joiningDate;
  String? workedTillDate;
  int? claimStatus;
  bool? addedBy;
  String? approved;
  String? companySlug;
  int? totalExperienceMonths;
  List<ListElement>? lists;
  int? stillWorking;

  EmployeeMentHistoryDatum({
    this.id,
    this.companyLogo,
    this.company,
    this.companyId,
    this.joiningDate,
    this.workedTillDate,
    this.claimStatus,
    this.addedBy,
    this.approved,
    this.companySlug,
    this.totalExperienceMonths,
    this.lists,
    this.stillWorking,
  });

  factory EmployeeMentHistoryDatum.fromJson(Map<String, dynamic> json) => EmployeeMentHistoryDatum(
    id: json["id"],
    companyLogo: json["company_logo"],
    company: json["company"],
    companyId: json["company_id"],
    joiningDate: json["joining_date"] ,
    workedTillDate: json["worked_till_date"],
    claimStatus: json["claim_status"],
    addedBy: json["added_by"],
    approved: json["approved"],
    companySlug: json["company_slug"],
    totalExperienceMonths: json["totalExperienceMonths"],
    lists: json["lists"] == null ? [] : List<ListElement>.from(json["lists"]!.map((x) => ListElement.fromJson(x))),
    stillWorking: json["still_working"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_logo": companyLogo,
    "company": company,
    "company_id": companyId,
    "joining_date": joiningDate,
    "worked_till_date": workedTillDate,
    "claim_status": claimStatus,
    "added_by": addedBy,
    "approved": approved,
    "company_slug": companySlug,
    "totalExperienceMonths": totalExperienceMonths,
    "lists": lists == null ? [] : List<dynamic>.from(lists!.map((x) => x.toJson())),
    "still_working": stillWorking,
  };
}

class ListElement {
  String? id;
  String? salary;
  String? employmentType;
  String? designation;
  DateTime? joiningDate;
  dynamic workedTillDate;
  String? stillWorking;
  String? approved;
  String? description;
  String? salaryInhand;
  String? salaryMode;
  String? department;
  int? claimStatus;
  String? companySlug;
  List<dynamic>? skill;
  List<dynamic>? document;
  bool? addedBy;
  String? employmentStatus;
  List<dynamic>? basicUpdateList;
  List<dynamic>? rating;
  TotalRating? totalRating;
  String? status;

  ListElement({
    this.id,
    this.salary,
    this.employmentType,
    this.designation,
    this.joiningDate,
    this.workedTillDate,
    this.stillWorking,
    this.approved,
    this.description,
    this.salaryInhand,
    this.salaryMode,
    this.department,
    this.claimStatus,
    this.companySlug,
    this.skill,
    this.document,
    this.addedBy,
    this.employmentStatus,
    this.basicUpdateList,
    this.rating,
    this.totalRating,
    this.status,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    salary: json["salary"],
    employmentType: json["employment_type"],
    designation: json["designation"],
    joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
    workedTillDate: json["worked_till_date"],
    stillWorking: json["still_working"],
    approved: json["approved"],
    description: json["description"],
    salaryInhand: json["salary_inhand"],
    salaryMode: json["salary_mode"],
    department: json["department"],
    claimStatus: json["claim_status"],
    companySlug: json["company_slug"],
    skill: json["skill"] == null ? [] : List<dynamic>.from(json["skill"]!.map((x) => x)),
    document: json["document"] == null ? [] : List<dynamic>.from(json["document"]!.map((x) => x)),
    addedBy: json["added_by"],
    employmentStatus: json["employment_status"],
    basicUpdateList: json["basic_update_list"] == null ? [] : List<dynamic>.from(json["basic_update_list"]!.map((x) => x)),
    rating: json["rating"] == null ? [] : List<dynamic>.from(json["rating"]!.map((x) => x)),
    totalRating: json["totalRating"] == null ? null : TotalRating.fromJson(json["totalRating"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salary": salary,
    "employment_type": employmentType,
    "designation": designation,
    "joining_date": "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
    "worked_till_date": workedTillDate,
    "still_working": stillWorking,
    "approved": approved,
    "description": description,
    "salary_inhand": salaryInhand,
    "salary_mode": salaryMode,
    "department": department,
    "claim_status": claimStatus,
    "company_slug": companySlug,
    "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
    "added_by": addedBy,
    "employment_status": employmentStatus,
    "basic_update_list": basicUpdateList == null ? [] : List<dynamic>.from(basicUpdateList!.map((x) => x)),
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
    "totalRating": totalRating?.toJson(),
    "status": status,
  };
}

class TotalRating {
  int? rating;
  int? noofrecord;

  TotalRating({
    this.rating,
    this.noofrecord,
  });

  factory TotalRating.fromJson(Map<String, dynamic> json) => TotalRating(
    rating: json["rating"],
    noofrecord: json["noofrecord"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "noofrecord": noofrecord,
  };
}
