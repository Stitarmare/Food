class FcmModel {
    Notification notification;
    Data data;

    FcmModel({
        this.notification,
        this.data,
    });

    factory FcmModel.fromJson(Map<String, dynamic> json) => FcmModel(
        notification: Notification.fromJson(json["notification"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "data": data.toJson(),
    };
}

class Data {
    String notifText;
    String notifType;
    int fromId;
    int toId;
    int invitationId;
    String notifTitle;

    Data({
        this.notifText,
        this.notifType,
        this.fromId,
        this.toId,
        this.invitationId,
        this.notifTitle,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifText: json["notif_text"],
        notifType: json["notif_type"],
        fromId: json["from_id"],
        toId: json["to_id"],
        invitationId: json["invitation_id"],
        notifTitle: json["notif_title"],
    );

    Map<String, dynamic> toJson() => {
        "notif_text": notifText,
        "notif_type": notifType,
        "from_id": fromId,
        "to_id": toId,
        "invitation_id": invitationId,
        "notif_title": notifTitle,
    };
}

class Notification {
    String title;
    String body;

    Notification({
        this.title,
        this.body,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
    };
}