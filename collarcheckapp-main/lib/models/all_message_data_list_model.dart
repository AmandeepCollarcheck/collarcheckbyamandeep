

class AllMessageDataListModel {
  bool? status;
  String? messages;
  List<MessageDatum>? data;

  AllMessageDataListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory AllMessageDataListModel.fromJson(Map<String, dynamic> json) => AllMessageDataListModel(
    status: json["status"],
    messages: json["messages"],
    data: json["data"] == null ? [] : List<MessageDatum>.from(json["data"]!.map((x) => MessageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MessageDatum {
  String? id;
  String? sender;
  String? receiver;
  String? senderName;
  String? receiverName;
  String? profile;
  String? datetime;
  dynamic receiverProfile;
  List<Message>? message;
  int? count;

  MessageDatum({
    this.id,
    this.sender,
    this.receiver,
    this.senderName,
    this.datetime,
    this.receiverName,
    this.profile,
    this.receiverProfile,
    this.message,
    this.count,
  });

  factory MessageDatum.fromJson(Map<String, dynamic> json) => MessageDatum(
    id: json["id"],
    sender: json["sender"],
    receiver: json["receiver"],
    senderName: json["senderName"],
    datetime: json.containsKey("timestamp") && json["timestamp"] != null
        ? json["timestamp"]
        : "",
    receiverName: json["receiverName"],
    profile: json["profile"],
    receiverProfile: json["receiver_profile"],
    message: json["message"] == null ? [] : List<Message>.from(json["message"]!.map((x) => Message.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender,
    "receiver": receiver,
    "timestamp": datetime?.isNotEmpty == true ? datetime : null,
    "senderName": senderName,
    "receiverName": receiverName,
    "profile": profile,
    "receiver_profile": receiverProfile,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    "count": count,
  };
}

class Message {
  String? messageId;
  String? message;
  List<dynamic>? document;
  String? sender;
  String? receiver;
  String? datetime;
  String? userId;
  String? receiverId;
  String? senderName;
  String? receiverName;
  String? receiverProfile;
  String? profile;
  String? isViewed;

  Message({
    this.messageId,
    this.message,
    this.document,
    this.sender,
    this.receiver,
    this.datetime,
    this.userId,
    this.receiverId,
    this.senderName,
    this.receiverName,
    this.receiverProfile,
    this.profile,
    this.isViewed,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageId: json["message_id"],
    message: json["message"],
    document: json["document"] == null ? [] : List<dynamic>.from(json["document"]!.map((x) => x)),
    sender: json["sender"],
    receiver: json["receiver"],
    datetime: json["datetime"],
    userId: json["userId"],
    receiverId: json["receiver_id"],
    senderName: json["senderName"],
    receiverName: json["receiverName"],
    receiverProfile: json["receiver_profile"],
    profile: json["profile"],
    isViewed: json["is_viewed"],
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "message": message,
    "document": document == null ? [] : List<dynamic>.from(document!.map((x) => x)),
    "sender": sender,
    "receiver": receiver,
    "datetime": datetime,
    "userId": userId,
    "receiver_id": receiverId,
    "senderName": senderName,
    "receiverName": receiverName,
    "receiver_profile": receiverProfile,
    "profile": profile,
    "is_viewed": isViewed,
  };
}