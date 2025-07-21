class ConnectionListModel {
  bool? status;
  String? messages;
  Data? data;

  ConnectionListModel({this.status, this.messages, this.data});

  ConnectionListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<FollowerList>? followerList;
  int? followerCount;
  List<FollowingList>? followingList;
  int? followingCount;

  Data(
      {this.followerList,
        this.followerCount,
        this.followingList,
        this.followingCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['followerList'] != null) {
      followerList = <FollowerList>[];
      json['followerList'].forEach((v) {
        followerList!.add(new FollowerList.fromJson(v));
      });
    }
    followerCount = json['followerCount'];
    if (json['followingList'] != null) {
      followingList = <FollowingList>[];
      json['followingList'].forEach((v) {
        followingList!.add(new FollowingList.fromJson(v));
      });
    }
    followingCount = json['followingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followerList != null) {
      data['followerList'] = this.followerList!.map((v) => v.toJson()).toList();
    }
    data['followerCount'] = this.followerCount;
    if (this.followingList != null) {
      data['followingList'] =
          this.followingList!.map((v) => v.toJson()).toList();
    }
    data['followingCount'] = this.followingCount;
    return data;
  }
}

class FollowerList {
  String? id;
  String? individualId;
  String? name;
  String? designationName;
  String? stateName;
  String? countryName;
  String? profile;
  String? slug;
  String? userType;
  String? userId;
  bool? isVerified;
  bool? followBack;
  String? createDate;

  FollowerList(
      {this.id,
        this.individualId,
        this.name,
        this.designationName,
        this.stateName,
        this.countryName,
        this.profile,
        this.slug,
        this.userType,
        this.userId,
        this.isVerified,
        this.followBack,
        this.createDate});

  FollowerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    individualId = json['individual_id'];
    name = json['name'];
    designationName = json['designation_name'];
    stateName = json['state_name'];
    countryName = json['country_name'];
    profile = json['profile'];
    slug = json['slug'];
    userType = json['user_type'];
    userId = json['user_id'];
    isVerified = json['is_verified'];
    followBack = json['followBack'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['individual_id'] = this.individualId;
    data['name'] = this.name;
    data['designation_name'] = this.designationName;
    data['state_name'] = this.stateName;
    data['country_name'] = this.countryName;
    data['profile'] = this.profile;
    data['slug'] = this.slug;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['is_verified'] = this.isVerified;
    data['followBack'] = this.followBack;
    data['create_date'] = this.createDate;
    return data;
  }
}

class FollowingList {
  String? id;
  String? individualId;
  String? name;
  String? profile;
  String? industryName;
  bool? isVerified;
  String? slug;
  String? designationName;
  String? userType;
  String? userId;
  String? stateName;
  String? countryName;
  bool? followBack;
  String? createDate;

  FollowingList(
      {this.id,
        this.individualId,
        this.name,
        this.profile,
        this.industryName,
        this.isVerified,
        this.slug,
        this.designationName,
        this.userType,
        this.userId,
        this.stateName,
        this.countryName,
        this.followBack,
        this.createDate});

  FollowingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    individualId = json['individual_id'];
    name = json['name'];
    profile = json['profile'];
    designationName = json['designation_name'];
    industryName = json['industry_name'];
    isVerified = json['is_verified'];
    slug = json['slug'];
    userType = json['user_type'];
    userId = json['user_id'];
    stateName = json['state_name'];
    countryName = json['country_name'];
    followBack = json['followBack'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['individual_id'] = this.individualId;
    data['name'] = this.name;
    data['profile'] = this.profile;
    data['industry_name'] = this.industryName;
    data['is_verified'] = this.isVerified;
    data['slug'] = this.slug;
    data['designation_name'] = this.designationName;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['state_name'] = this.stateName;
    data['country_name'] = this.countryName;
    data['followBack'] = this.followBack;
    data['create_date'] = this.createDate;
    return data;
  }
}
