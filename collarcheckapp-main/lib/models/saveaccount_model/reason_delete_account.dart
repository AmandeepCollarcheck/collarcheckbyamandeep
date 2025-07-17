class DeleteAccountReasonModel {
  bool? status;
  List<ReasonOptionsList>? reasonOptionsList;

  DeleteAccountReasonModel({this.status, this.reasonOptionsList});

  DeleteAccountReasonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      reasonOptionsList = <ReasonOptionsList>[];
      json['data'].forEach((v) {
        reasonOptionsList!.add(ReasonOptionsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.reasonOptionsList != null) {
      data['data'] = this.reasonOptionsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class ReasonOptionsList {
  String? id;
  String? name;

  ReasonOptionsList({this.id, this.name});

  ReasonOptionsList.fromJson(Map<String, dynamic> json) {
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
