class ComanySizeModel {
  bool? status;
  String? messages;
  List<CompanySizeList>? companySizeList;

  ComanySizeModel({this.status, this.messages, this.companySizeList});

  ComanySizeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];

    // ✅ Support both 'data' and 'CompanySizeList'
    var rawList = json['CompanySizeList'] ?? json['data'];
    if (rawList != null && rawList is List) {
      companySizeList = rawList.map((v) => CompanySizeList.fromJson(v)).toList();
    } else {
      companySizeList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['messages'] = messages;
    if (companySizeList != null) {
      data['CompanySizeList'] = companySizeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class CompanySizeList {
  String? id;
  String? name;

  CompanySizeList({this.id, this.name});

  CompanySizeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
