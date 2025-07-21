class SendOtp {
  bool status;
  String message;

  SendOtp({
    required this.status,
    required this.message,
  });

  factory SendOtp.fromJson(Map<String, dynamic> json) => SendOtp(
    status: json["status"] ?? false,
    message: json["messages"] ?? "No message", // ✅ Change "message" to "messages"
  );
}
