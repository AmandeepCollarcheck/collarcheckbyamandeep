

class TopCompaniesModel {
  bool? status;
  String? messages;
  Data? data;

  TopCompaniesModel({
    this.status,
    this.messages,
    this.data,
  });

  factory TopCompaniesModel.fromJson(Map<String, dynamic> json) => TopCompaniesModel(
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
  List<dynamic>? userList;
  List<Map<String, String?>>? companyList;
  int? companyListCount;
  List<dynamic>? filterName;

  Data({
    this.userList,
    this.companyList,
    this.companyListCount,
    this.filterName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userList: json["userList"] == null ? [] : List<dynamic>.from(json["userList"]!.map((x) => x)),
    companyList: json["companyList"] == null ? [] : List<Map<String, String?>>.from(json["companyList"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    companyListCount: json["companyListCount"],
    filterName: json["filterName"] == null ? [] : List<dynamic>.from(json["filterName"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userList": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x)),
    "companyList": companyList == null ? [] : List<dynamic>.from(companyList!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "companyListCount": companyListCount,
    "filterName": filterName == null ? [] : List<dynamic>.from(filterName!.map((x) => x)),
  };
}
