

class CompanyPeopleRecentlyJoinedModel {
  bool? status;
  List<Datum>? data;

  CompanyPeopleRecentlyJoinedModel({
    this.status,
    this.data,
  });

  factory CompanyPeopleRecentlyJoinedModel.fromJson(Map<String, dynamic> json) => CompanyPeopleRecentlyJoinedModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? experienceId;
  String? individualId;
  String? name;
  String? profile;
  String? userSlug;
  String? employementName;
  String? designationName;
  String? departmentName;
  String? slug;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
