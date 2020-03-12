import 'dart:convert';

GetNotificationListModel getNotificationListModelFromJson(String str) => GetNotificationListModel.fromJson(json.decode(str));

String getNotificationListModelToJson(GetNotificationListModel data) => json.encode(data.toJson());

class GetNotificationListModel {
    String status;
    int statusCode;
    List<Datum> data;

    GetNotificationListModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory GetNotificationListModel.fromJson(Map<String, dynamic> json) => GetNotificationListModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String notifTitle;
    String notifText;
    int fromId;
    int toId;
    String userType;
    String notifType;
    DateTime createdAt;
    DateTime updatedAt;
    int invitationId;

    Datum({
        this.id,
        this.notifTitle,
        this.notifText,
        this.fromId,
        this.toId,
        this.userType,
        this.notifType,
        this.createdAt,
        this.updatedAt,
        this.invitationId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        notifTitle: json["notif_title"],
        notifText: json["notif_text"],
        fromId: json["from_id"],
        toId: json["to_id"],
        userType: json["user_type"],
        notifType: json["notif_type"] == null ? null : json["notif_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        invitationId: json["invitation_id"] == null ? null : json["invitation_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "notif_title": notifTitle,
        "notif_text": notifText,
        "from_id": fromId,
        "to_id": toId,
        "user_type": userType,
        "notif_type": notifType == null ? null : notifType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "invitation_id": invitationId == null ? null : invitationId,
    };
}
