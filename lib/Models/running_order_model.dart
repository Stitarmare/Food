class RunningOrderModel {
  String status;
  int statusCode;
  Data data;

  RunningOrderModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory RunningOrderModel.fromJson(Map<String, dynamic> json) =>
      RunningOrderModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  DineIn dineIn;
  DineIn takeAway;
  CartModel cart;

  Data({
    this.dineIn,
    this.takeAway,
    this.cart
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dineIn:
            json["dine_in"] != null ? DineIn.fromJson(json["dine_in"]) : null,
        takeAway: json["take_away"] != null
            ? DineIn.fromJson(json["take_away"])
            : null,
            cart: json["cart"] != null
            ? CartModel.fromJson(json["cart"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "dine_in": dineIn.toJson(),
        "take_away": takeAway.toJson(),
      };
}

class DineIn {
  int id;
  String orderType;
  int tableId;
  int userId;
  dynamic additionalComments;
  int restId;
  String orderNumber;
  String status;
  String totalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic timeToPickupOrder;
  Table table;
  Restaurant restaurant;

  DineIn(
      {this.id,
      this.orderType,
      this.tableId,
      this.userId,
      this.additionalComments,
      this.restId,
      this.orderNumber,
      this.status,
      this.totalAmount,
      this.createdAt,
      this.updatedAt,
      this.timeToPickupOrder,
      this.table,
      this.restaurant});

  factory DineIn.fromJson(Map<String, dynamic> json) => DineIn(
        id: json["id"],
        orderType: json["order_type"],
        tableId: json["table_id"] == null ? null : json["table_id"],
        userId: json["user_id"],
        additionalComments: json["additional_comments"],
        restId: json["rest_id"],
        orderNumber: json["order_number"],
        status: json["status"],
        totalAmount: json["total_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        timeToPickupOrder: json["time_to_pickup_order"],
        table: json["table"] == null ? null : Table.fromJson(json["table"]),
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_type": orderType,
        "table_id": tableId == null ? null : tableId,
        "user_id": userId,
        "additional_comments": additionalComments,
        "rest_id": restId,
        "order_number": orderNumber,
        "status": status,
        "total_amount": totalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "time_to_pickup_order": timeToPickupOrder,
        "table": table == null ? null : table.toJson(),
        "restaurant": restaurant.toJson(),
      };
}

class Restaurant {
  int id;
  String restName;
  String coverImage;

  Restaurant({this.id, this.restName, this.coverImage});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        restName: json["rest_name"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_name": restName,
        "cover_image": coverImage,
      };
}

class Table {
  int id;
  String tableName;

  Table({
    this.id,
    this.tableName,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["id"],
        tableName: json["table_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table_name": tableName,
      };
}

class CartModel {
    int id;
    int quantity;
    String preparationTime;
    int itemId;
    dynamic itemSizePriceId;
    int tableId;
    String price;
    dynamic sizePrice;
    int userId;
    int restId;
    dynamic waiterId;
    int workstationId;
    String preparationNote;
    DateTime createdAt;
    DateTime updatedAt;
    String restName;

    CartModel({
        this.id,
        this.quantity,
        this.preparationTime,
        this.itemId,
        this.itemSizePriceId,
        this.tableId,
        this.price,
        this.sizePrice,
        this.userId,
        this.restId,
        this.waiterId,
        this.workstationId,
        this.preparationNote,
        this.createdAt,
        this.updatedAt,
        this.restName
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        price: json["price"],
        sizePrice: json["size_price"],
        userId: json["user_id"],
        restId: json["rest_id"],
        waiterId: json["waiter_id"],
        workstationId: json["workstation_id"],
        preparationNote: json["preparation_note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        restName: json["rest_name"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "price": price,
        "size_price": sizePrice,
        "user_id": userId,
        "rest_id": restId,
        "waiter_id": waiterId,
        "workstation_id": workstationId,
        "preparation_note": preparationNote,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rest_name":restName
    };
}
