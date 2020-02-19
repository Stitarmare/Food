import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String status;
    int statusCode;
    List<NotificationData> data;

    NotificationModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class NotificationData {
    int id;
    String notifTitle;
    String notifText;
    int fromId;
    int toId;
    String userType;
    String notifType;
    dynamic createdAt;
    dynamic updatedAt;

    NotificationData({
        this.id,
        this.notifTitle,
        this.notifText,
        this.fromId,
        this.toId,
        this.userType,
        this.notifType,
        this.createdAt,
        this.updatedAt,
    });

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["id"],
        notifTitle: json["notif_title"],
        notifText: json["notif_text"],
        fromId: json["from_id"],
        toId: json["to_id"],
        userType: json["user_type"],
        notifType: json["notif_type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "notif_title": notifTitle,
        "notif_text": notifText,
        "from_id": fromId,
        "to_id": toId,
        "user_type": userType,
        "notif_type": notifType,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
