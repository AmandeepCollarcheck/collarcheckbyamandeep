

class DashboardStaticsDetailsModel {
  bool? status;
  Data? data;

  DashboardStaticsDetailsModel({
    this.status,
    this.data,
  });

  factory DashboardStaticsDetailsModel.fromJson(Map<String, dynamic> json) => DashboardStaticsDetailsModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? postedJobs;
  int? applications;
  int? currentEmployies;
  int? followRequests;
  int? messages;
  List<dynamic>? followList;

  Data({
    this.postedJobs,
    this.applications,
    this.currentEmployies,
    this.followRequests,
    this.messages,
    this.followList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    postedJobs: json["postedJobs"],
    applications: json["applications"],
    currentEmployies: json["currentEmployies"],
    followRequests: json["followRequests"],
    messages: json["messages"],
    followList: json["followList"] == null ? [] : List<dynamic>.from(json["followList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "postedJobs": postedJobs,
    "applications": applications,
    "currentEmployies": currentEmployies,
    "followRequests": followRequests,
    "messages": messages,
    "followList": followList == null ? [] : List<dynamic>.from(followList!.map((x) => x)),
  };
}
