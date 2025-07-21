

class EducationListModel {
  bool? status;
  String? messages;
  Data? data;

  EducationListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory EducationListModel.fromJson(Map<String, dynamic> json) => EducationListModel(
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
  List<CourseListElement>? institutionList;
  List<CourseListElement>? courseList;
  List<CourseTypeList>? courseTypeList;
  List<CountryList>? countryList;

  Data({
    this.institutionList,
    this.courseList,
    this.courseTypeList,
    this.countryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    institutionList: json["institutionList"] == null ? [] : List<CourseListElement>.from(json["institutionList"]!.map((x) => CourseListElement.fromJson(x))),
    courseList: json["courseList"] == null ? [] : List<CourseListElement>.from(json["courseList"]!.map((x) => CourseListElement.fromJson(x))),
    courseTypeList: json["courseTypeList"] == null ? [] : List<CourseTypeList>.from(json["courseTypeList"]!.map((x) => CourseTypeList.fromJson(x))),
    countryList: json["countryList"] == null ? [] : List<CountryList>.from(json["countryList"]!.map((x) => CountryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "institutionList": institutionList == null ? [] : List<dynamic>.from(institutionList!.map((x) => x.toJson())),
    "courseList": courseList == null ? [] : List<dynamic>.from(courseList!.map((x) => x.toJson())),
    "courseTypeList": courseTypeList == null ? [] : List<dynamic>.from(courseTypeList!.map((x) => x.toJson())),
    "countryList": countryList == null ? [] : List<dynamic>.from(countryList!.map((x) => x.toJson())),
  };
}

class CountryList {
  String? id;
  String? name;
  String? phonecode;

  CountryList({
    this.id,
    this.name,
    this.phonecode,
  });

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
    id: json["id"],
    name: json["name"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phonecode": phonecode,
  };
}

class CourseListElement {
  String? id;
  String? name;
  String? image;

  CourseListElement({
    this.id,
    this.name,
    this.image,
  });

  factory CourseListElement.fromJson(Map<String, dynamic> json) => CourseListElement(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class CourseTypeList {
  String? id;
  String? name;

  CourseTypeList({
    this.id,
    this.name,
  });

  factory CourseTypeList.fromJson(Map<String, dynamic> json) => CourseTypeList(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
