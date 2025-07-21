

class NotificationListModel {
  bool? status;
  String? messages;
  Data? data;

  NotificationListModel({
    this.status,
    this.messages,
    this.data,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
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
  int? notificationcount;
  List<Notification>? notification;
  int? messagecount;

  Data({
    this.notificationcount,
    this.notification,
    this.messagecount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notificationcount: json["notificationcount"],
    notification: json["notification"] == null ? [] : List<Notification>.from(json["notification"]!.map((x) => Notification.fromJson(x))),
    messagecount: json["messagecount"],
  );

  Map<String, dynamic> toJson() => {
    "notificationcount": notificationcount,
    "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
    "messagecount": messagecount,
  };
}

class Notification {
  String? id;
  String? profile;
  String? message;
  String? dateTime;
  String? link;
  String? isViewed;

  Notification({
    this.id,
    this.profile,
    this.message,
    this.dateTime,
    this.link,
    this.isViewed,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    profile: json["profile"],
    message: json["message"],
    dateTime: json["date_time"],
    link: json["link"],
    isViewed: json["is_viewed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "message": message,
    "date_time": dateTime,
    "link": link,
    "is_viewed": isViewed,
  };
}
