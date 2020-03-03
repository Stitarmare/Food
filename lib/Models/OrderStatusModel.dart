import 'dart:convert';

OrderStatusModel orderStatusModelFromJson(String str) => OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) => json.encode(data.toJson());

class OrderStatusModel {
    String status;
    int statusCode;
    StatusData data;

    OrderStatusModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: StatusData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
    };
}

class StatusData {
    int id;
    String status;

    StatusData({
        this.id,
        this.status,
    });

    factory StatusData.fromJson(Map<String, dynamic> json) => StatusData(
        id: json["id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
    };
}
