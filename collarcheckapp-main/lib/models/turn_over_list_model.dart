class TurnOverListModel {
  bool? status;
  String? messages;
  List<TurnOverListData>? turnOverListData;

  TurnOverListModel({this.status, this.messages, this.turnOverListData});

  TurnOverListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];

    // ✅ Corrected key name from 'TurnOverListData' to 'data'
    if (json['data'] != null) {
      turnOverListData = <TurnOverListData>[];
      json['data'].forEach((v) {
        turnOverListData!.add(TurnOverListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['messages'] = messages;

    // ✅ Also match the key when encoding
    if (turnOverListData != null) {
      data['data'] = turnOverListData!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class TurnOverListData {
  String? id;
  String? name;

  TurnOverListData({this.id, this.name});

  TurnOverListData.fromJson(Map<String, dynamic> json) {
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
