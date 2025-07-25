class SaveAccountModel {
  bool? status;
  String? messages;

  SaveAccountModel({this.status, this.messages});

  SaveAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    return data;
  }
}
