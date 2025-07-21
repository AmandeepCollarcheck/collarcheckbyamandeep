

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
  List<FilterName>? filterName;

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
    filterName: _parseFilterName(json["filterName"]),
  );

  Map<String, dynamic> toJson() => {
    "userList": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x)),
    "companyList": companyList == null ? [] : List<dynamic>.from(companyList!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "companyListCount": companyListCount,
    "filterName": filterName == null ? [] : List<dynamic>.from(filterName!.map((x) => x.toJson())),
  };
  // Handling dynamic filterName type
  static List<FilterName> _parseFilterName(dynamic json) {
    if (json == null) {
      return [];
    } else if (json is List) {
      return List<FilterName>.from(json.map((x) => FilterName.fromJson(x)));
    } else if (json is Map<String, dynamic>) {
      return [FilterName.fromJson(json)];
    } else {
      return [];
    }
  }
}
class Company {
String? id;
String? name;

Company({
  this.id,
  this.name,
});

factory Company.fromJson(Map<String, dynamic> json) => Company(
id: json["id"],
name: json["name"],
);

Map<String, dynamic> toJson() => {
  "id": id,
  "name": name,
};
}

class FilterName {
  Company? company;

  FilterName({
    this.company,
  });

  factory FilterName.fromJson(Map<String, dynamic> json) => FilterName(
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "company": company?.toJson(),
  };
}

