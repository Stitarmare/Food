import 'dart:convert';

GetMyOrdersBookingHistory getMyOrdersBookingHistoryFromJson(String str) =>
    GetMyOrdersBookingHistory.fromJson(json.decode(str));

String getMyOrdersBookingHistoryToJson(GetMyOrdersBookingHistory data) =>
    json.encode(data.toJson());

class GetMyOrdersBookingHistory {
  String status;
  int statusCode;
  List<GetMyOrderBookingHistoryList> data;

  GetMyOrdersBookingHistory({
    this.status,
    this.statusCode,
    this.data,
  });

  factory GetMyOrdersBookingHistory.fromJson(Map<String, dynamic> json) =>
      GetMyOrdersBookingHistory(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<GetMyOrderBookingHistoryList>.from(
            json["data"].map((x) => GetMyOrderBookingHistoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetMyOrderBookingHistoryList {
  int id;
  String orderType;
  int tableId;
  int userId;
  dynamic additionalComments;
  int restId;
  String status;
  String totalAmount;
  dynamic timeToPickupOrder;
  dynamic waiterId;
  DateTime createdAt;
  DateTime updatedAt;
  String orderNumber;
  bool isRunning;
  Restaurant restaurant;
  List<GetMyOrderBookingList> list;

  GetMyOrderBookingHistoryList({
    this.id,
    this.orderType,
    this.tableId,
    this.userId,
    this.additionalComments,
    this.restId,
    this.status,
    this.totalAmount,
    this.timeToPickupOrder,
    this.waiterId,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.isRunning,
    this.restaurant,
    this.list,
  });

  factory GetMyOrderBookingHistoryList.fromJson(Map<String, dynamic> json) =>
      GetMyOrderBookingHistoryList(
        id: json["id"],
        orderType: json["order_type"],
        tableId: json["table_id"],
        userId: json["user_id"],
        additionalComments: json["additional_comments"],
        restId: json["rest_id"],
        status: json["status"],
        totalAmount: json["total_amount"],
        timeToPickupOrder: json["time_to_pickup_order"],
        waiterId: json["waiter_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderNumber: json["order_number"],
        isRunning: json["is_running"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
        list: List<GetMyOrderBookingList>.from(
            json["list"].map((x) => GetMyOrderBookingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_type": orderType,
        "table_id": tableId,
        "user_id": userId,
        "additional_comments": additionalComments,
        "rest_id": restId,
        "status": status,
        "total_amount": totalAmount,
        "time_to_pickup_order": timeToPickupOrder,
        "waiter_id": waiterId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_number": orderNumber,
        "is_running": isRunning,
        "restaurant": restaurant.toJson(),
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class GetMyOrderBookingList {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  dynamic itemSizePriceId;
  int tableId;
  int orderId;
  int userId;
  int restId;
  dynamic waiterId;
  String price;
  String status;
  dynamic sizePrice;
  DateTime createdAt;
  DateTime updatedAt;
  Items items;

  GetMyOrderBookingList({
    this.id,
    this.quantity,
    this.preparationTime,
    this.itemId,
    this.itemSizePriceId,
    this.tableId,
    this.orderId,
    this.userId,
    this.restId,
    this.waiterId,
    this.price,
    this.status,
    this.sizePrice,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory GetMyOrderBookingList.fromJson(Map<String, dynamic> json) =>
      GetMyOrderBookingList(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        waiterId: json["waiter_id"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"],
        sizePrice: json["size_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        items: Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "order_id": orderId,
        "user_id": userId,
        "rest_id": restId,
        "waiter_id": waiterId,
        "price": price == null ? null : price,
        "status": status,
        "size_price": sizePrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "items": items.toJson(),
      };
}

class Items {
  int id;
  String itemName;
  String price;
  String itemDescription;
  String menuType;
  String defaultPreparationTime;
  String itemCode;
  String itemImage;
  int workstationId;
  DateTime createdAt;
  DateTime updatedAt;

  Items({
    this.id,
    this.itemName,
    this.price,
    this.itemDescription,
    this.menuType,
    this.defaultPreparationTime,
    this.itemCode,
    this.itemImage,
    this.workstationId,
    this.createdAt,
    this.updatedAt,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"],
        itemDescription: json["item_description"],
        menuType: json["menu_type"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        itemImage: json["item_image"],
        workstationId: json["workstation_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price,
        "item_description": itemDescription,
        "menu_type": menuType,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "item_image": itemImage,
        "workstation_id": workstationId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Restaurant {
  int id;
  String restName;
  String addressLine1;
  dynamic addressLine2;
  dynamic addressLine3;
  String coverImage;

  Restaurant({
    this.id,
    this.restName,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.coverImage,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        restName: json["rest_name"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        addressLine3: json["address_line_3"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_name": restName,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "address_line_3": addressLine3,
        "cover_image": coverImage,
      };
}
