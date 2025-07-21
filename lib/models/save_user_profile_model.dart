

class SaveUserProfileModel {
  bool? status;
  String? messages;

  SaveUserProfileModel({
    this.status,
    this.messages,
  });

  factory SaveUserProfileModel.fromJson(Map<String, dynamic> json) => SaveUserProfileModel(
    status: json["status"],
    messages: json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
  };
}
