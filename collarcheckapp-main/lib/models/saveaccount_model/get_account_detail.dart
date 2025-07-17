class SettingsDataModel {
  bool? status;
  String? messages;
  GetSettingDetailModel? getSettingDetailModel;

  SettingsDataModel({this.status, this.messages, this.getSettingDetailModel});

  SettingsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    getSettingDetailModel = json['GetSettingDetailModel'] != null
        ? new GetSettingDetailModel.fromJson(json['GetSettingDetailModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.getSettingDetailModel != null) {
      data['GetSettingDetailModel'] = this.getSettingDetailModel!.toJson();
    }
    return data;
  }
}

class GetSettingDetailModel {
  String? messages;
  String? mobile;
  String? address;
  String? email;
  String? dob;

  GetSettingDetailModel(
      {this.messages, this.mobile, this.address, this.email, this.dob});

  GetSettingDetailModel.fromJson(Map<String, dynamic> json) {
    messages = json['messages'];
    mobile = json['mobile'];
    address = json['address'];
    email = json['email'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messages'] = this.messages;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['email'] = this.email;
    data['dob'] = this.dob;
    return data;
  }
}
