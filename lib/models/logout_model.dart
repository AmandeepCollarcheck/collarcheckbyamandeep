class LogoutModel {
  bool status;
  String message;

  LogoutModel({
    required this.status,
    required this.message,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    status: json["status"] ?? false,
    message: json["messages"] ?? "No message", // ✅ Change "message" to "messages"
  );
}
