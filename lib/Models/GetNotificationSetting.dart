// To parse this JSON data, do
//
//     final getNotificationSetting = getNotificationSettingFromJson(jsonString);

import 'dart:convert';

GetNotificationSetting getNotificationSettingFromJson(String str) => GetNotificationSetting.fromJson(json.decode(str));

String getNotificationSettingToJson(GetNotificationSetting data) => json.encode(data.toJson());

class GetNotificationSetting {
    String status;
    int statusCode;
    List<Datum> data;

    GetNotificationSetting({
        this.status,
        this.statusCode,
        this.data,
    });

    factory GetNotificationSetting.fromJson(Map<String, dynamic> json) => GetNotificationSetting(
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
    int userId;
    String notifType;

    Datum({
        this.userId,
        this.notifType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        notifType: json["notif_type"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "notif_type": notifType,
    };
}
