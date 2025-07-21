

class AllDropDownListModel {
  bool? status;
  String? messages;
  Data? data;

  AllDropDownListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory AllDropDownListModel.fromJson(Map<String, dynamic> json) => AllDropDownListModel(
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
  List<AccomodationListElement>? employementList;
  List<CompanyList>? companyList;
  List<AccomodationListElement>? designationList;
  List<AccomodationListElement>? accomodationList;
  List<CountryList>? countryList;

  Data({
    this.employementList,
    this.companyList,
    this.designationList,
    this.accomodationList,
    this.countryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employementList: json["employementList"] == null ? [] : List<AccomodationListElement>.from(json["employementList"]!.map((x) => AccomodationListElement.fromJson(x))),
    companyList: json["companyList"] == null ? [] : List<CompanyList>.from(json["companyList"]!.map((x) => CompanyList.fromJson(x))),
    designationList: json["designationList"] == null ? [] : List<AccomodationListElement>.from(json["designationList"]!.map((x) => AccomodationListElement.fromJson(x))),
    accomodationList: json["accomodationList"] == null ? [] : List<AccomodationListElement>.from(json["accomodationList"]!.map((x) => AccomodationListElement.fromJson(x))),
    countryList: json["countryList"] == null ? [] : List<CountryList>.from(json["countryList"]!.map((x) => CountryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "employementList": employementList == null ? [] : List<dynamic>.from(employementList!.map((x) => x.toJson())),
    "companyList": companyList == null ? [] : List<dynamic>.from(companyList!.map((x) => x.toJson())),
    "designationList": designationList == null ? [] : List<dynamic>.from(designationList!.map((x) => x.toJson())),
    "accomodationList": accomodationList == null ? [] : List<dynamic>.from(accomodationList!.map((x) => x.toJson())),
    "countryList": countryList == null ? [] : List<dynamic>.from(countryList!.map((x) => x.toJson())),
  };
}

class AccomodationListElement {
  String? id;
  String? name;

  AccomodationListElement({
    this.id,
    this.name,
  });

  factory AccomodationListElement.fromJson(Map<String, dynamic> json) => AccomodationListElement(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CompanyList {
  String? id;
  String? companyLogo;
  String? company;
  String? contactPerson;

  CompanyList({
    this.id,
    this.companyLogo,
    this.company,
    this.contactPerson,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["id"],
    companyLogo: json["company_logo"],
    company: json["company"],
    contactPerson: json["contact_person"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_logo": companyLogo,
    "company": company,
    "contact_person": contactPerson,
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
