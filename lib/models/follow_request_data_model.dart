

class FollowRequestDataModel {
  bool? status;
  String? messages;
  Data? data;

  FollowRequestDataModel({
    this.status,
    this.messages,
    this.data,
  });

  factory FollowRequestDataModel.fromJson(Map<String, dynamic> json) => FollowRequestDataModel(
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
  List<Follow>? follow;

  Data({
    this.follow,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    follow: json["follow"] == null ? [] : List<Follow>.from(json["follow"]!.map((x) => Follow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "follow": follow == null ? [] : List<dynamic>.from(follow!.map((x) => x.toJson())),
  };
}

class Follow {
  String? id;
  String? individualId;
  String? name;
  dynamic profile;
  String? slug;
  String? userType;
  String? createDate;

  Follow({
    this.id,
    this.individualId,
    this.name,
    this.profile,
    this.slug,
    this.userType,
    this.createDate,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    id: json["id"],
    individualId: json["individual_id"],
    name: json["name"],
    profile: json["profile"],
    slug: json["slug"],
    userType: json["user_type"],
    createDate: json["create_date"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "individual_id": individualId,
    "name": name,
    "profile": profile,
    "slug": slug,
    "user_type": userType,
    "create_date": createDate,
  };
}
