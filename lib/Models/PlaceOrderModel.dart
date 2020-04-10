import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel {
  String status;
  int statusCode;
  OrderData orderData;
  String colourCode;
  String message;

  PlaceOrderModel({
    this.status,
    this.statusCode,
    this.orderData,
    this.colourCode,
    this.message,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        status: json["status"],
        statusCode: json["status_code"],
        orderData:
            json["data"] != null ? OrderData.fromJson(json["data"]) : null,
        colourCode: json["colour_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": orderData.toJson(),
        "colour_code": colourCode,
        "message": message,
      };
}

class OrderData {
  int userId;
  int restId;
  String orderType;
  String totalAmount;
  String orderNumber;
  int tableId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  OrderData({
    this.userId,
    this.restId,
    this.orderType,
    this.totalAmount,
    this.orderNumber,
    this.tableId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        userId: json["user_id"],
        restId: json["rest_id"],
        orderType: json["order_type"],
        totalAmount: json["total_amount"],
        orderNumber: json["order_number"],
        tableId: json["table_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "rest_id": restId,
        "order_type": orderType,
        "total_amount": totalAmount,
        "order_number": orderNumber,
        "table_id": tableId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
