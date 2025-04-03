

class ConnectionDataListModel {
  bool? status;
  String? messages;
  Data? data;

  ConnectionDataListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory ConnectionDataListModel.fromJson(Map<String, dynamic> json) => ConnectionDataListModel(
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
  List<FollowList>? followerList;
  List<FollowList>? followingList;

  Data({
    this.followerList,
    this.followingList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    followerList: json["followerList"] == null ? [] : List<FollowList>.from(json["followerList"]!.map((x) => FollowList.fromJson(x))),
    followingList: json["followingList"] == null ? [] : List<FollowList>.from(json["followingList"]!.map((x) => FollowList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "followerList": followerList == null ? [] : List<dynamic>.from(followerList!.map((x) => x.toJson())),
    "followingList": followingList == null ? [] : List<dynamic>.from(followingList!.map((x) => x.toJson())),
  };
}

class FollowList {
  String? id;
  String? individualId;
  String? name;
  dynamic profile;
  String? slug;
  String? designationName;
  String? countryName;
  String? stateName;
  String? userType;
  String? userId;
  bool? followBack;
  DateTime? createDate;

  FollowList({
    this.id,
    this.individualId,
    this.name,
    this.profile,
    this.slug,
    this.userType,
    this.designationName,
    this.userId,
    this.createDate,
    this.followBack,
    this.countryName,
    this.stateName
  });

  factory FollowList.fromJson(Map<String, dynamic> json) => FollowList(
    id: json["id"],
    individualId: json["individual_id"],
    name: json["name"],
    profile: json["profile"],
    slug: json["slug"],
    designationName: json["designation_name"],
    followBack: json["followBack"],
    userType: json["user_type"],
    userId: json["user_id"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "name": name,
    "profile": profile,
    "slug": slug,
    "followBack":followBack,
    "user_type": userType,
    "designation_name":designationName,
    "country_name":countryName,
    "state_name":stateName,
    "user_id": userId,
    "create_date": createDate?.toIso8601String(),
  };
}
