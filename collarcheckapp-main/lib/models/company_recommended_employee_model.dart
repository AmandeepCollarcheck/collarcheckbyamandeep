

class CompanyRecommendedEmployeeModel {
  bool? status;
  List<Datum>? data;

  CompanyRecommendedEmployeeModel({
    this.status,
    this.data,
  });

  factory CompanyRecommendedEmployeeModel.fromJson(Map<String, dynamic> json) => CompanyRecommendedEmployeeModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? individualId;
  dynamic totalRating;
  String? profile;
  String? name;
  String? slug;
  bool? isVerified;
  String? cityName;
  String? stateName;
  String? countryName;
  String? workStatus;
  dynamic designationName;
  dynamic companyName;
  FollowData? followData;

  Datum({
    this.id,
    this.individualId,
    this.totalRating,
    this.profile,
    this.name,
    this.slug,
    this.cityName,
    this.stateName,
    this.countryName,
    this.workStatus,
    this.designationName,
    this.companyName,
    this.followData,
    this.isVerified
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    individualId: json["individual_id"],
    totalRating: json["totalRating"],
    profile: json["profile"],
    name: json["name"],
    slug: json["slug"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    workStatus: json["work_status"],
    isVerified:json['isVerified'],
    designationName: json["designation_name"],
    companyName: json["company_name"],
    followData: json["followData"] == null ? null : FollowData.fromJson(json["followData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "totalRating": totalRating,
    "profile": profile,
    "name": name,
    "slug": slug,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "isVerified":isVerified,
    "work_status": workStatus,
    "designation_name": designationName,
    "company_name": companyName,
    "followData": followData?.toJson(),
  };
}

class FollowData {
  int? following;
  int? follower;

  FollowData({
    this.following,
    this.follower,
  });

  factory FollowData.fromJson(Map<String, dynamic> json) => FollowData(
    following: json["following"],
    follower: json["follower"],
  );

  Map<String, dynamic> toJson() => {
    "following": following,
    "follower": follower,
  };
}
