import 'dart:convert';

UpdateOrderResponseModel updateOrderResponseModelFromJson(String str) => UpdateOrderResponseModel.fromJson(json.decode(str));

String updateOrderResponseModelToJson(UpdateOrderResponseModel data) => json.encode(data.toJson());

class UpdateOrderResponseModel {
    String status;
    int statusCode;
    String message;
    Data data;

    UpdateOrderResponseModel({
        this.status,
        this.statusCode,
        this.message,
        this.data,
    });

    factory UpdateOrderResponseModel.fromJson(Map<String, dynamic> json) => UpdateOrderResponseModel(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int orderId;
    int userId;
    int restId;
    int tableId;
    int itemId;
    dynamic quantity;
    String preparationTime;
    String price;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        this.orderId,
        this.userId,
        this.restId,
        this.tableId,
        this.itemId,
        this.quantity,
        this.preparationTime,
        this.price,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        tableId: json["table_id"],
        itemId: json["item_id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        price: json["price"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "rest_id": restId,
        "table_id": tableId,
        "item_id": itemId,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "price": price,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
